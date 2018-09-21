" FIXME: CR to close popup and break at once
" script ID {{{
function! s:SID() abort
  return matchstr(expand('<sfile>'), '<SNR>\zs\d\+\ze_SID$')
endfunction
let s:SID = printf("\<SNR>%s_", s:SID())
delfunction s:SID
"}}}


" script local variables {{{
let s:const = Verdin#constants#distribute()
let s:lib = Verdin#lib#distribute()
let s:TRUE = 1
let s:FALSE = 0
let s:INF = 1/0
let s:FUNCABBR = printf('^%s([^)]*)$', s:const.FUNCNAME)
let s:FUNCARG = printf('^%s(\zs[^)]*\ze)$', s:const.FUNCNAME)
"}}}


" public constructor of Completer object
function! Verdin#Completer#new(Dictionaries) abort "{{{
  return s:Completer(a:Dictionaries)
endfunction "}}}


let s:basedict = {}
function! s:getbasedict(filetype) abort "{{{
  let filename = a:filetype . '.json'
  let dictpath = s:lib.pathjoin([s:const.VERDINTOPDIR, 'dict', filename])
  return json_decode(join(readfile(dictpath), ''))
endfunction "}}}


" return a Completer object in a specified buffer
" NOTE: return the Completer object in the current buffer without argument
function! Verdin#Completer#get(...) abort "{{{
  let bufexpr = get(a:000, 0, '%')
  let bufinfo = get(getbufinfo(bufexpr), 0, {})
  if bufinfo == {}
    echoerr printf('Verdin: Invalid bufexpr is given for Verdin#Completer#get(): %s', string(bufexpr))
  endif

  if !has_key(bufinfo.variables, 'Verdin')
    let bufinfo.variables.Verdin = {}
  endif
  if !has_key(bufinfo.variables.Verdin, 'Completer')
    if s:lib.filetypematches('help')
      let filetype = 'help'
    else
      let filetype = 'vim'
    endif
    let Dictionaries = s:getbasedict(filetype)
    let bufinfo.variables.Verdin.Completer = s:Completer(Dictionaries)
  endif
  return bufinfo.variables.Verdin.Completer
endfunction "}}}


" Completer object {{{
let s:Completer = {
      \   'shelf': {},
      \   'candidatelist': [],
      \   'fuzzycandidatelist': [],
      \   'clock': Verdin#clock#new(),
      \   'savedoptions': {},
      \   'is': {
      \     'in_completion': s:FALSE,
      \     'lazyredraw_changed': s:FALSE,
      \   },
      \   'last': {
      \     'lnum': 0,
      \     'col': 0,
      \     'line': '',
      \     'precursor': '',
      \     'postcursor': '',
      \     'startcol': -1,
      \     'base': '',
      \   },
      \ }

" (private) constructor of Completer object
function! s:Completer(Dictionaries) abort
  let Completer = deepcopy(s:Completer)
  let Completer.shelf = copy(a:Dictionaries)
  return Completer
endfunction

" return the column where the completion starts
function! s:Completer.startcol(...) dict abort "{{{
  let giveupifshort = get(a:000, 0, s:FALSE)
  let fuzzymatch = Verdin#_getoption('fuzzymatch')
  let context = s:getcontext(line('.'), col('.'), getline('.'), s:INF)
  let startcol = context.startcol
  let self.candidatelist = []
  let self.fuzzycandidatelist = []
  for Dictionary in values(self.shelf)
    let [startcol, candidate, fuzzycandidate] = s:lookup(Dictionary, context, giveupifshort, fuzzymatch)
    if startcol < 0 || startcol > context.startcol
      continue
    endif
    if startcol < context.startcol
      let context.startcol = startcol
      let self.candidatelist = []
      let self.fuzzycandidatelist = []
    endif
    call add(self.candidatelist, candidate)
    call add(self.fuzzycandidatelist, fuzzycandidate)
  endfor
  if context.startcol == s:INF
    return -1
  endif
  call filter(self.candidatelist, 'v:val != {}')
  call filter(self.fuzzycandidatelist, 'v:val != {}')
  if self.candidatelist == [] && self.fuzzycandidatelist == []
    return -1
  endif
  let context.base = context.col == 1 ? '' : context.line[context.startcol : context.col-2]
  let self.fuzzycandidatelist = s:flatten(self.fuzzycandidatelist, context.base)
  let self.last = context
  return context.startcol
endfunction "}}}

" return the list of complete items matched with a:base
function! s:Completer.match(base) dict abort "{{{
  if self.candidatelist == []
    return []
  endif

  call sort(self.candidatelist, {a, b -> b.priority - a.priority})
  let pattern = '\m^' . s:lib.escape(a:base)
  let candidatelist = []
  let filterlist = ['v:val.__text__ =~# pattern',
                  \ 'v:val.__text__ =~? pattern && v:val.__text__ !~# pattern']
  for filter in filterlist
    for candidate in self.candidatelist
      if candidate.itemlist == []
        continue
      endif
      let candidatelist += filter(copy(candidate.itemlist), filter)
    endfor
  endfor
  return candidatelist
endfunction "}}}

" return the list of complete items fuzzy-matched with a:base
let s:MEMO_fuzzymatch = {}
function! s:Completer.fuzzymatch(base, ...) dict abort "{{{
  if self.fuzzycandidatelist == []
    return []
  endif

  let timelimit = self.clock.elapsed() + get(a:000, 0, 500)
  let nbase = strchars(a:base)
  let s:MEMO_fuzzymatch = {}
  let candidatelist = []
  while self.fuzzycandidatelist != [] && self.clock.elapsed() < timelimit
    let item = remove(self.fuzzycandidatelist, 0)
    let __text__ = s:lib.__text__(item)
    let difflen = strchars(__text__) - nbase
    let texthead = strcharpart(__text__, 0, nbase)
    if a:base ==? texthead || difflen < -2 || (type(item) == v:t_dict && get(item, '__delimitermatch__', 0))
      continue
    endif
    let d = s:strcmp(a:base, texthead)
    if d >= s:const.FUZZYMATCHTHRESHOLD
      call add(candidatelist, s:fuzzyitem(item, a:base, d, difflen))
    endif
  endwhile
  return candidatelist
endfunction "}}}

function! s:Completer.modify(candidatelist, ...) dict abort "{{{
  let modifiers = get(a:000, 0, ['braket', 'snip'])
  if match(modifiers, '\m\C^braket$') > -1
    call s:autobrainsert(a:candidatelist, self.last.postcursor)
  endif
  if match(modifiers, '\m\C^snip$') > -1
    call s:addsnippeditems(a:candidatelist, self.last.postcursor)
  endif
  return a:candidatelist
endfunction "}}}
function! s:Completer.complete(startcol, itemlist) dict abort "{{{
  if self.savedoptions == {}
    let self.savedoptions.completeopt = &completeopt
  endif
  set completeopt=menuone,noselect,noinsert
  let Event = Verdin#Event#get()
  call Event.aftercomplete_set(function(self.aftercomplete, [1], self))
  call Event.aftercomplete_set(function(Event.autocomplete_on, [], Event))
  call Event.autocomplete_off()

  " NOTE: It seems 'CompleteDone' event is triggered even inside complete() function.
  let self.is.in_completion = s:TRUE
  call complete(a:startcol+1, a:itemlist)
  let self.is.in_completion = s:FALSE
endfunction "}}}
function! s:Completer.aftercomplete(autocomplete, event) dict abort "{{{
  if self.is.in_completion
    return 0
  endif
  if a:event ==# 'CompleteDone' && get(v:completed_item, 'abbr', '') =~# s:FUNCABBR
    call s:autoketinsert(v:completed_item)
  endif
  if !a:autocomplete
    return 1
  endif
  if self.savedoptions != {}
    let &completeopt = self.savedoptions.completeopt
    let self.savedoptions = {}
  endif
  return 1
endfunction "}}}
function! s:Completer.addDictionary(name, new) dict abort "{{{
  let self.shelf[a:name] = a:new
endfunction "}}}
function! s:Completer.dropduplicates(wordlist, namelist) dict abort "{{{
  for name in a:namelist
    call filter(a:wordlist, 'count(self.shelf[name]["wordlist"], v:val) == 0')
  endfor
  return a:wordlist
endfunction "}}}
let s:NOTHING_FOUND = [-1, {}, {}]
function! s:getcontext(lnum, col, line, startcol) abort "{{{
  let context = {}
  let context.lnum = a:lnum
  let context.col = a:col
  let context.line = a:line
  let context.precursor = a:col == 1 ? '' : a:line[: a:col-2]
  let context.postcursor = a:line[a:col-1 :]
  let context.syntax = s:getcursorsyntax(context)
  let context.startcol = a:startcol
  let context.base = context.precursor
  return context
endfunction "}}}
function! s:getcursorsyntax(context) abort "{{{
  if synIDattr(synIDtrans(synID(a:context.lnum, a:context.col-1, 1)), 'name') ==# 'Comment'
    return {'comment': 1, 'string': 0}
  endif
  if match(a:context.precursor, '^[^''"]*\%(\%(''[^'']*''\|".\{-}\%(\\\%(\\\\\)*\)\@21<!"\)[^''"]*\)*[''"][^''"]*$') > -1
    return {'comment': 0, 'string': 1}
  endif
  return {'comment': 0, 'string': 0}
endfunction "}}}
function! s:lookup(Dictionary, context, giveupifshort, fuzzymatch) abort  "{{{
  if a:Dictionary == {}
    return s:NOTHING_FOUND
  endif

  " for reactive dictionaries
  if has_key(a:Dictionary, 'compile')
    let success = a:Dictionary.compile(a:context.precursor)
    if !success
      return s:NOTHING_FOUND
    endif
  endif

  let candidate = {}
  let candidate.name = a:Dictionary.name
  let candidate.itemlist = []
  let fuzzycandidate = {}
  let notyetmatched = s:TRUE
  let savedstartcol = -1
  for condition in a:Dictionary.conditionlist
    let [matched, str] = s:matchstr(a:context, condition.cursor_at)
    if !matched || (a:giveupifshort && strchars(str) < a:Dictionary.indexlen) || !s:cursor_is_in(condition, a:context) || s:cursor_not_at(condition, a:context)
      continue
    endif
    let startcol = a:context.col - strlen(str) - 1
    if startcol > a:context.startcol
      continue
    endif

    if a:fuzzymatch && notyetmatched
      let fuzzycandidate = a:Dictionary.index
      let savedstartcol = startcol
      let notyetmatched = s:FALSE
    endif

    let c = strcharpart(str, 0, a:Dictionary.indexlen)
    let escaped_c = '^' . s:lib.escape(c)
    if has_key(a:Dictionary.index, c)
      let keys = [c] + filter(keys(a:Dictionary.index), 'v:val =~? escaped_c && v:val !=# c')
    else
      let keys = filter(keys(a:Dictionary.index), 'v:val =~? escaped_c')
    endif

    for key in keys
      let candidate.itemlist += a:Dictionary.index[key]
    endfor
    if candidate.itemlist != []
      let candidate.priority = get(condition, 'priority', 0)
      return [startcol, candidate, fuzzycandidate]
    endif
  endfor
  if savedstartcol >= 0 && savedstartcol <= a:context.startcol
    return [savedstartcol, {}, fuzzycandidate]
  endif
  return s:NOTHING_FOUND
endfunction "}}}
function! s:matchstr(context, pat) abort "{{{
  let [lnum, col] = searchpos(a:pat, 'bcnW', a:context.lnum)
  if lnum != 0
    return [s:TRUE, a:context.precursor[col-1 :]]
  endif
  return  [s:FALSE, '']
endfunction "}}}
function! s:cursor_not_at(condition, context) abort "{{{
  let cursor_not_at = get(a:condition, 'cursor_not_at', '')
  return cursor_not_at !=# '' && (search(cursor_not_at, 'bcnW', a:context.lnum) != 0 || search(cursor_not_at, 'cn', a:context.lnum) != 0)
endfunction "}}}
function! s:cursor_is_in(condition, context) abort "{{{
  let flags = []
  if has_key(a:condition, 'in_string')
    if !!a:context.syntax.string == !!a:condition.in_string
      call add(flags, 1)
    else
      call add(flags, 0)
    endif
  endif
  if has_key(a:condition, 'in_comment')
    if !!a:context.syntax.comment == !!a:condition.in_comment
      call add(flags, 1)
    else
      call add(flags, 0)
    endif
  endif
  if has_key(a:condition, 'not_in_string')
    if !!a:context.syntax.string != !!a:condition.not_in_string
      call add(flags, 1)
    else
      call add(flags, 0)
    endif
  endif
  if has_key(a:condition, 'not_in_comment')
    if !!a:context.syntax.comment != !!a:condition.not_in_comment
      call add(flags, 1)
    else
      call add(flags, 0)
    endif
  endif
  return flags == [] || eval(join(flags, '&&')) ? 1 : 0
endfunction "}}}
function! s:addsnippeditems(candidatelist, postcursor, ...) abort "{{{
  let postcursor = matchstr(a:postcursor, '^\S\+')
  if postcursor ==# ''
    return a:candidatelist
  endif

  if strchars(postcursor) == 1
    let pattern = printf('\m\C%s$', s:lib.escape(postcursor))
  else
    let header = strcharpart(postcursor, 0, 1)
    let body = substitute(strcharpart(postcursor, 1, 50), '\([][]\)', '[\1]', 'g')
    let pattern = printf('\m\C%s\%%[%s]$', s:lib.escape(header), escape(body, '~"\.^$*'))
  endif
  let i = len(a:candidatelist) - 1
  while i >= 0
    let candidate = a:candidatelist[i]
    if get(candidate, '__delimitermatch__', s:FALSE)
      let i -= 1
      continue
    endif

    let word = s:lib.word(candidate)
    let idx = match(word, pattern)
    if idx > 0
      if type(candidate) == v:t_dict
        let snipped = deepcopy(candidate)
        let snipped.word = snipped.word[: idx-1]
        let snipped.menu .= ' snipped'
        let snipped.dup = 1
        if !has_key(snipped, 'abbr')
          let snipped.abbr = candidate.word
        endif
        let snipped.__func__ = s:FALSE
        let entire = deepcopy(candidate)
        let entire.menu .= ' entire'
        let entire.dup = 1
      else
        let snipped = {'word': candidate[: idx-1], 'abbr': candidate,
                    \  'menu': 'snipped', 'dup': 1}
        let entire = {'word': candidate, 'menu': 'entire', 'dup': 1}
      endif
      call remove(a:candidatelist, i)
      call insert(a:candidatelist, entire, i)
      call insert(a:candidatelist, snipped, i)
    endif
    let i -= 1
  endwhile
  return a:candidatelist
endfunction "}}}
function! s:is_started() abort "{{{
  return exists('b:Verdin')
endfunction "}}}
function! s:flatten(candidatelist, base) abort "{{{
  let nbase = strchars(a:base)
  if nbase < 3
    return []
  endif

  let similarlist = s:similarlist(a:candidatelist, a:base)
  let flattened = []
  for [_, itemlist] in sort(similarlist, {a, b -> a[0] - b[0]})
    let flattened += itemlist
  endfor
  return flattened
endfunction "}}}
function! s:similarlist(candidatelist, base) abort "{{{
  let pat = join(['\m^\%(', strcharpart(a:base, 0, 1), '\|', substitute(a:base, '\m^\(.\)\(.\).*', '\2\1', ''), '\)'], '')
  let similarlist = []
  for candidate in a:candidatelist
    for key in filter(keys(candidate), 'v:val =~? pat')
      let n = strchars(key)
      let shortbase = strcharpart(a:base, 0, n)
      if n <= 2
        let d = shortbase ==? key ? 0 : 1
        call add(similarlist, [d, copy(candidate[key])])
        continue
      endif
      let threshold = s:lib.DL_threshold(n)
      let d = s:lib.Damerau_Levenshtein_distance(shortbase, key)
      if d <= threshold
        call add(similarlist, [d, copy(candidate[key])])
      endif
    endfor
  endfor
  return similarlist
endfunction "}}}
function! s:fuzzyitem(item, base, score, difflen) abort "{{{
  let itemtype = type(a:item)
  let fuzzymenu = ' *fuzzy*'
  if itemtype == v:t_dict
    let candidate = deepcopy(a:item)
    if has_key(candidate, 'menu')
      let candidate.menu .= fuzzymenu
    else
      let candidate.menu = fuzzymenu
    endif
    let candidate.dup = 0
    let candidate.__text__ = a:base
    let candidate.__score__ = a:score
    let candidate.__difflen__ = a:difflen
  elseif itemtype == v:t_string
    let candidate = {'word': a:item, 'menu': fuzzymenu, 'dup': 0,
                  \  '__text__': a:base, '__score__': a:score, '__difflen__': a:difflen}
  endif
  return candidate
endfunction "}}}
function! s:strcmp(base, text) abort "{{{
  if has_key(s:MEMO_fuzzymatch, a:text)
    let d = s:MEMO_fuzzymatch[a:text]
  else
    let d = s:lib.Jaro_Winkler_distance(a:base, a:text)
    let s:MEMO_fuzzymatch[a:text] = d
  endif
  return d
endfunction "}}}
function! s:autobrainsert(candidatelist, postcursor) abort "{{{
  if a:postcursor[0] ==# '('
    return a:candidatelist
  endif

  let autobraketinsert = Verdin#_getoption('autobraketinsert')
  if autobraketinsert
    for i in range(len(a:candidatelist))
      let candidate = a:candidatelist[i]
      if type(candidate) == v:t_dict && get(candidate, '__func__', s:FALSE)
        let new = copy(candidate)
        if matchstr(candidate.abbr, s:FUNCARG) ==# ''
          let new.word = candidate.word . '()'
        else
          let new.word = candidate.word . '('
        endif
        call remove(a:candidatelist, i)
        call insert(a:candidatelist, new, i)
      endif
    endfor
  endif
  return a:candidatelist
endfunction "}}}
function! s:autoketinsert(item) abort "{{{
  let autobraketinsert = Verdin#_getoption('autobraketinsert')
  if autobraketinsert == 2
    if matchstr(a:item.abbr, s:FUNCARG) !=# ''
      call feedkeys(s:InsertKetKey, 'im')
    endif
  endif
endfunction

let s:InsertKetKey = s:SID . '(InsertKet)'
inoremap <silent> <SID>(InsertKet) <C-r>=<SID>InsertKet('i')<CR>
cnoremap <silent> <SID>(InsertKet) <Nop>
nnoremap <silent><expr> <SID>(InsertKet) <SID>InsertKet('n')
function! s:InsertKet(mode) abort
  let Completer = Verdin#Completer#get()
  if Completer.last.postcursor[0] ==# '('
    return ''
  endif
  let lnum = Completer.last.lnum
  let startcol = Completer.last.startcol+1
  let funcname = s:lib.escape(v:completed_item.word)
  let postcursor = s:lib.escape(Completer.last.postcursor)
  if a:mode ==# 'i'
    let pat = printf('\m\%%%dl\%%%dc%s.*\%%#%s$',
                    \lnum, startcol, funcname, postcursor)
    let keyseq = ")\<C-g>U\<Left>"
  elseif a:mode ==# 'n'
    let pat = printf('\m\%%%dl\%%%dc%s\%%#(%s$',
                    \lnum, startcol, funcname[:-2], postcursor)
    let keyseq = "a)\<Esc>"
  endif
  if search(pat, 'bcn', Completer.last.lnum)
    return keyseq
  endif
  return ''
endfunction
"}}}
"}}}

" vim:set ts=2 sts=2 sw=2 tw=0:
" vim:set foldmethod=marker: commentstring="%s:
