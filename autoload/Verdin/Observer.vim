" script local variables {{{
let s:SEARCHLINES = 200
let s:const = Verdin#constants#distribute()
let s:lib = Verdin#lib#distribute()
let s:varconditionlist = [
      \   {'cursor_at': '\m\C^\s*call\s\+\zs\%([ablstw]:\|\%([ablstw]:\)\?\<\h\w*\|g:\h[0-9A-Za-z_#]*\)\?\%#', 'priority': 128},
      \   {'cursor_at': '\m\C^\s*\%(let\|call\?\|if\|elseif\?\|for\|wh\%[ile]\|retu\%[rn]\|exe\%[cute]\|fu\%[nction]!\?\|unl\%[et]!\?\|ec\%[hon]\|echom\%[sg]\|echoe\%[rr]\)\s.*[:.&+]\@1<!\zs\%(\<[abglstwv]:\h\k*\|\<[abglstwv]:\|\<\k*\)\%#', 'priority': 256},
      \   {'cursor_at': '\m\C^\s*[A-Z]\w*!\?\s.*[:.&]\@1<!\zs\%(\<[abglstwv]:\h\k*\|\<[abglstwv]:\|\<\k*\)\%#', 'priority': 0},
      \   {'cursor_at': '\m\C\%(\%([:.&]\@1<![ablstw]:\)\?\<\h\w\{5,}\|g:\h[0-9A-Za-z_#]\{6,}\)\%#', 'priority': 0},
      \ ]
let s:memberconditionlist = [
      \   {'cursor_at': s:const.VARNAME . '\.\zs\%(\h\w*\)\?\%#', 'priority': 384},
      \   {'cursor_at': printf('\m\C\<has_key(\s*%s\s*,\s*[''"]\zs\w*\%%#', s:const.VARNAME), 'priority': 384},
      \ ]
let s:keymapconditionlist = [
      \   {
      \     'cursor_at': '\m\C<\%(P\%[lug>]\|S\%[ID>]\)\S*\%#',
      \     'priority': 256,
      \   },
      \   {
      \     'cursor_at': '\m\C^\s*\%([nvxsoilc]\?map\|map!\)\s\+\%(<\%(buffer\|nowait\|silent\|special\|script\|expr\|unique\)>\s*\)*\S\+\s\+\zs\%(<\S*\)\?\%#',
      \     'priority': 256,
      \   },
      \   {
      \     'cursor_at': '\m\C^\s*\%([nvxsoilc]\?u\%[map]\|unm\%[ap]!\)\s\+\zs\%(<\S*\)\?\%#',
      \     'priority': 256,
      \   },
      \   {
      \     'cursor_at': '\m\C\<normal\s\+.*\zs<\S*\%#',
      \     'priority': 256,
      \   },
      \   {
      \     'cursor_at': '\m\C\<feedkeys(\%(''\%([^'']*\%(''''\)*\)*[^'']*\|"\%([^"]*\%(\\"\)*\)[^"]*\)\zs<\S*\%#',
      \     'priority': 256,
      \   },
      \ ]
let s:cache = {}
"}}}


function! Verdin#Observer#new(target, kind) abort "{{{
  return s:Observer(a:target, a:kind)
endfunction
"}}}
function! Verdin#Observer#get(...) abort "{{{
  let target = get(a:000, 0, bufname('%'))
  let bufinfo = get(getbufinfo(target), 0, {})
  if bufinfo == {}
    echoerr 'Verdin: Invalid bufexpr is given for Verdin#Observer#get()'
  endif

  if !has_key(bufinfo.variables, 'Verdin')
    let bufinfo.variables.Verdin = {}
  endif
  if !has_key(bufinfo.variables.Verdin, 'Observer')
    let filetype = getbufvar(target, '&filetype')
    let filename = bufname(target)
    if filetype ==# 'vim' || filename =~# '\.vim$'
      let kind = 'vim'
    elseif filetype ==# 'help' || filename =~# '\.txt'
      let kind = 'help'
    else
      return {}
    endif
    let bufinfo.variables.Verdin.Observer = Verdin#Observer#new(target, kind)
  endif
  return bufinfo.variables.Verdin.Observer
endfunction
"}}}

" Observer object {{{
let s:Observer = {
      \   'bufnr': -1,
      \   'changedtick': -1,
      \   'shelf': {
      \     'buffervar': {},
      \     'bufferfunc': {},
      \     'buffermember': {},
      \     'bufferkeymap': {},
      \     'buffercommand': {},
      \     'bufferhigroup': {},
      \     'buffertag': {},
      \     'globalvar': {},
      \     'globalfunc': {},
      \     'globalmember': {},
      \     'globalkeymap': {},
      \     'globalcommand': {},
      \     'globalhigroup': {},
      \     'globaltag': {},
      \     'varfragment': {},
      \     'funcfragment': {},
      \   },
      \ }
function! s:checkglobalsvim() dict abort "{{{
  let varlist = []
  let funclist = []
  let memberlist = []
  let keymapwordlist = []
  let commandlist = []
  let higrouplist = []
  for filepath in s:lib.searchvimscripts()
    let Observer = s:checkglobal(filepath, 'vim')
    let varlist += filter(copy(get(Observer.shelf.buffervar, 'wordlist', [])), 's:lib.word(v:val) =~# ''\m\C^[bgtw]:\h\k*''')
    let funclist += filter(copy(get(Observer.shelf.bufferfunc, 'wordlist', [])), 's:lib.word(v:val) =~# ''\m\C^\%([A-Z]\k*\|\h\k\%(#\h\k*\)\+\)''')
    let memberlist += copy(get(Observer.shelf.buffermember, 'wordlist', []))
    let keymapwordlist += filter(copy(get(Observer.shelf.bufferkeymap, 'wordlist', [])), 's:lib.word(v:val) =~# ''\m\C^<Plug>''')
    let commandlist += get(Observer.shelf.buffercommand, 'wordlist', [])
    let higrouplist += get(Observer.shelf.bufferhigroup, 'wordlist', [])
  endfor

  let Completer = Verdin#Completer#get()
  if varlist != []
    let conditionlist = s:decrementpriority(s:varconditionlist)
    let var = Verdin#Dictionary#new('var', conditionlist, varlist, 2)
    call s:inject(self.shelf['globalvar'], var)
  endif
  if funclist != []
    let conditionlist = s:decrementpriority(Completer.shelf.function.conditionlist)
    let func = Verdin#Dictionary#new('function', conditionlist, funclist, 1)
    call s:inject(self.shelf['globalfunc'], func)
  endif
  if memberlist != []
    call s:lib.uniq(memberlist)
    let conditionlist = s:decrementpriority(s:memberconditionlist)
    let member = Verdin#Dictionary#new('member', conditionlist, memberlist, 1)
    call s:inject(self.shelf['globalmember'], member)
  endif
  if keymapwordlist != []
    let conditionlist = s:decrementpriority(s:keymapconditionlist)
    let keymap = Verdin#Dictionary#new('keymap', conditionlist, keymapwordlist, 2)
    call s:inject(self.shelf['globalkeymap'], keymap)
  endif
  if commandlist != []
    let conditionlist = s:decrementpriority(Completer.shelf.command.conditionlist)
    let command = Verdin#Dictionary#new('command', conditionlist, commandlist, 2)
    call s:inject(self.shelf['globalcommand'], command)
  endif
  if higrouplist != []
    let conditionlist = s:decrementpriority(Completer.shelf.higroup.conditionlist)
    let higroup = Verdin#Dictionary#new('higroup', conditionlist, higrouplist, 2)
    call s:inject(self.shelf['globalhigroup'], higroup)
  endif
endfunction
"}}}
function! s:checkglobalshelp() dict abort "{{{
  " check help buffer
  let helptaglist = []
  for filepath in s:lib.searchvimhelps()
    let Observer = s:checkglobal(filepath, 'help')
    let helptaglist += get(Observer.shelf.buffertag, 'wordlist', [])
  endfor
  if helptaglist != []
    let Completer = Verdin#Completer#get()
    let conditionlist = Completer.shelf.tag.conditionlist
    let helptag = Verdin#Dictionary#new('tag', conditionlist, helptaglist, 2)
    call s:inject(self.shelf['globaltag'], helptag)
  endif

  " check vim buffer
  let varlist = []
  let funclist = []
  let keymapwordlist = []
  let commandlist = []
  for filepath in s:lib.searchvimscripts()
    let Observer = s:checkglobal(filepath, 'vim')
    let varlist += filter(copy(get(Observer.shelf.buffervar, 'wordlist', [])), 's:lib.__text__(v:val) =~# ''\m\C^[bgtw]:\h\k*''')
    let funclist += filter(copy(get(Observer.shelf.bufferfunc, 'wordlist', [])), 's:lib.__text__(v:val) =~# ''\m\C^\%([A-Z]\k*\|\h\k\%(#\h\k*\)\+\)''')
    let keymapwordlist += filter(copy(get(Observer.shelf.bufferkeymap, 'wordlist', [])), 's:lib.__text__(v:val) =~# ''\m\C^<Plug>''')
    let commandlist += get(Observer.shelf.buffercommand, 'wordlist', [])
  endfor
  let conditionlist = [{'cursor_at': '\m\%(\<\%([bgtw]:\|:\)\?\h\S*\|<P\%[lug>]\S*\)\%#'}]
  if varlist != []
    let var = Verdin#Dictionary#new('var', conditionlist, varlist, 3)
    call s:inject(self.shelf['globalvar'], var)
  endif
  if funclist != []
    let func = Verdin#Dictionary#new('function', conditionlist, funclist, 3)
    call s:inject(self.shelf['globalfunc'], func)
  endif
  if keymapwordlist != []
    let keymap = Verdin#Dictionary#new('keymap', conditionlist, keymapwordlist, 3)
    call s:inject(self.shelf['globalkeymap'], keymap)
  endif
  if commandlist != []
    let command = Verdin#Dictionary#new('command', conditionlist, commandlist, 3)
    call s:inject(self.shelf['globalcommand'], command)
  endif
endfunction
"}}}
function! s:checkglobal(filepath, kind) abort "{{{
  if bufloaded(a:filepath)
    let Observer = Verdin#Observer#get(a:filepath)
    if Observer.changedtick == -1
      call Observer.inspect()
    endif
    if has_key(s:cache, a:filepath)
      unlet s:cache[a:filepath]
    endif
  elseif !has_key(s:cache, a:filepath)
    let Observer = Verdin#Observer#new(a:filepath, a:kind)
    call Observer.inspect()
    let s:cache[a:filepath] = Observer
  else
    let Observer = s:cache[a:filepath]
  endif
  return Observer
endfunction
"}}}
function! s:inspectvim() dict abort "{{{
  if self.changedtick == b:changedtick
    return
  endif
  let self.changedtick = b:changedtick

  " NOTE: The second condition is for tests
  if bufloaded(self.bufexpr) || self.bufexpr is# ''
    let global = s:get_buffer_string(self.bufexpr)
    if bufnr(self.bufexpr) == bufnr('%')
      let cursoridx = line2byte(line('.')) + col('.') - 1
    else
      let cursoridx = -1
    endif
  else
    let global = s:get_file_string(self.bufexpr)
    let cursoridx = -1
  endif
  let local = s:get_local_string(global, cursoridx)

  let clock = Verdin#clock#new()
  call clock.start()
  let [lvarlist, lmemberlist] = s:splitvarname(s:scan(local, s:const.LOCALVARREGEX, clock))
  let [gvarlist, gmemberlist] = s:splitvarname(s:scan(global, s:const.GLOBALVARREGEX, clock))
  let varlist = lvarlist + gvarlist
  call s:lib.sortbyoccurrence(varlist)
  let varlist += s:splitargvarname(s:scan(local, s:const.ARGREGEX, clock))
  let [_, amemberlist] = s:splitvarname(s:scan(local, s:const.ARGNAME, clock))
  let memberlist = lmemberlist + gmemberlist + amemberlist
  let memberlist += s:scan(global, s:const.KEYREGEX, clock)
  let memberlist += s:scan(global, s:const.HASKEYREGEX, clock)

  call uniq(sort(memberlist))
  let memberlist += s:splitmethodname(s:scan(global, s:const.METHODREGEX, clock))
  let funclist = s:functionitems(s:scan(global, s:const.FUNCDEFINITIONREGEX, clock))
  let keymaplist = s:scan(global, s:const.KEYMAPREGEX, clock)
  let commandlist = s:scan(global, s:const.COMMANDREGEX, clock)
  let higrouplist = s:scan(global, s:const.HIGROUPREGEX, clock)

  let Completer = Verdin#Completer#get()
  if varlist != []
    call s:scopecorrectedvaritems(varlist)
    call s:lib.uniq(varlist)
    if local.is_dictfunc
      call add(varlist, 'self')
    endif
    let options = {'delimitermatch': 1}
    let var = Verdin#Dictionary#new('var', s:varconditionlist, varlist, 2, options)
    call s:inject(self.shelf['buffervar'], var)
  endif
  if funclist != []
    call s:SIDfuncitems(funclist)
    let conditionlist = Completer.shelf.function.conditionlist
    let options = {'sortbyoccurrence': 1, 'delimitermatch': 1}
    let func = Verdin#Dictionary#new('function', conditionlist, funclist, 1, options)
    call s:inject(self.shelf['bufferfunc'], func)
  endif
  if memberlist != []
    let options = {'sortbyoccurrence': 1}
    call s:lib.uniq(memberlist)
    let member = Verdin#Dictionary#new('member', s:memberconditionlist, memberlist, 1, options)
    call s:inject(self.shelf['buffermember'], member)
  endif
  if keymaplist != []
    let options = {'sortbyoccurrence': 1, 'delimitermatch': 1}
    let keymap = Verdin#Dictionary#new('keymap', s:keymapconditionlist, keymaplist, 2, options)
    call s:inject(self.shelf['bufferkeymap'], keymap)
  endif
  if commandlist != []
    let options = {'delimitermatch': 1}
    let conditionlist = Completer.shelf.command.conditionlist
    let command = Verdin#Dictionary#new('command', conditionlist, commandlist, 2, options)
    call s:inject(self.shelf['buffercommand'], command)
  endif
  if higrouplist != []
    let options = {'delimitermatch': 1}
    let conditionlist = Completer.shelf.higroup.conditionlist
    let higroup = Verdin#Dictionary#new('higroup', conditionlist, higrouplist, 2, options)
    call s:inject(self.shelf['bufferhigroup'], higroup)
  endif
  if self.shelf.funcfragment == {}
    let funcfragmentconditionlist = map(deepcopy(Completer.shelf.function.conditionlist), 'extend(v:val, {"priority": get(v:val, "priority", 0) + 128}, "force")')
    call insert(funcfragmentconditionlist, {'cursor_at': '\m\C^\s*fu\%[nction]!\?\s\+\zs\%([gs]:\)\?\k*\%#', 'priority': 384})
    let funcfragmentwordlist = s:funcfragmentwordlist()
    let funcfragment = Verdin#Dictionary#new('funcfragment', funcfragmentconditionlist, funcfragmentwordlist)
    call s:inject(self.shelf['funcfragment'], funcfragment)
  endif
  let varfragmentwordlist = s:varfragmentwordlist(varlist)
  if varfragmentwordlist != []
    let varfragmentconditionlist = map(deepcopy(s:varconditionlist), 'extend(v:val, {"priority": get(v:val, "priority", 0) + 128}, "force")')
    let varfragment = Verdin#Dictionary#new('varfragment', s:varconditionlist, varfragmentwordlist)
    call s:inject(self.shelf['varfragment'], varfragment)
  endif
  call clock.stop()
endfunction
"}}}
function! s:inspecthelp() dict abort "{{{
  if self.changedtick == b:changedtick
    return
  endif
  let self.changedtick = b:changedtick

  if bufloaded(self.bufexpr)
    let doc = s:get_buffer_string(self.bufexpr)
  else
    let doc = s:get_file_string(self.bufexpr)
  endif
  let clock = Verdin#clock#new()
  call clock.start()
  let helptaglist = s:helptagitems(s:scan(doc, s:const.HELPTAGREGEX, clock))

  if helptaglist != []
    let Completer = Verdin#Completer#get()
    let conditionlist = Completer.shelf.tag.conditionlist
    let helptag = Verdin#Dictionary#new('tag', conditionlist, helptaglist, 2)
    call s:inject(self.shelf['buffertag'], helptag)
  endif
endfunction
"}}}
function! s:get_line_break() abort "{{{
  if &fileformat ==# 'unix'
    let linebreak = "\n"
  elseif &fileformat ==# 'dos'
    let linebreak = "\r\n"
  else
    let linebreak = "\r"
  endif
  return linebreak
endfunction
"}}}
function! s:get_buffer_string(bufnr) abort "{{{
  let linebreak = s:get_line_break()
  let buffer = getbufline(a:bufnr, 1, line('$'))
  let string = join(buffer, linebreak)
  let length = strlen(string)
  return {'str': string, 'len': length}
endfunction
"}}}
function! s:get_file_string(filepath) abort "{{{
  let linebreak = s:get_line_break()
  let file = readfile(a:filepath)
  let string = join(file, linebreak)
  let length = strlen(string)
  return {'str': string, 'len': length}
endfunction
"}}}
function! s:get_local_string(global, cursoridx) abort "{{{
  if a:cursoridx < 0
    return {'str': '', 'len': 0, 'is_dictfunc': 0}
  endif

  let i = 0
  let string = ''
  while i < a:global.len
    let start = matchstrpos(a:global.str, '\m\C\%(^\|\n\)\s*\zsfu\%[nction]!\?', i)
    if start[1] == -1
      break
    endif

    let end = matchstrpos(a:global.str, '\m\C\%(^\|\n\)\s*\%(endf\%[unction]o\@!\|\zefu\%[nction]!\?\)', start[2])
    if start[1] <= a:cursoridx && a:cursoridx <= end[2]
      let string = a:global.str[start[1] : end[2]-1]
      break
    endif
    if end[2] == -1
      break
    endif
    let i = end[2]
  endwhile
  let length = strlen(string)
  let is_dictfunc = s:is_dict_function(string)
  return {'str': string, 'len': length, 'is_dictfunc': is_dictfunc}
endfunction
"}}}
function! s:is_dict_function(local) abort "{{{
  if a:local ==# ''
    return 0
  endif
  return match(a:local, '\m\C^\s*fu\%[nction]!\?\s\+\%([gs]:\)\?\h\k*\%(\.\%(\h\k*\)\|([^)]*)\%(\s*\%(range\|abort\|closure\)\)*\s*dict\)') >= 0
endfunction
"}}}
function! s:scan(text, pat, clock) abort "{{{
  if a:text.str ==# ''
    return []
  endif

  let i = 0
  let alive = 1
  let counts = range(s:const.SEARCHINTERVAL)
  let string = a:text.str
  let threshold = a:text.len
  let wordlist = []
  while alive
    if a:clock.elapsed() >= s:const.SEARCHTIMEOUT
      break
    endif

    for j in counts
      let ret = matchstrpos(string, a:pat, i)
      if ret[1] == -1
        let alive = 0
        break
      endif
      let wordlist += [ret[0]]
      let i = ret[2]
      if i >= threshold
        let alive = 0
        break
      endif
    endfor
  endwhile
  return wordlist
endfunction
"}}}
function! s:splitvarname(varblocklist) abort "{{{
  let varlist = []
  let memberlist = []
  for varblock in a:varblocklist
    for identfier in split(varblock, ',\s*')
      let parts = split(identfier, '\.')
      let varlist += [parts[0]]
      if len(parts) > 1
        let memberlist += parts[1:]
      endif
    endfor
  endfor
  return [varlist, memberlist]
endfunction
"}}}
function! s:splitargvarname(varblocklist) abort "{{{
  let varlist = []
  for varblock in a:varblocklist
    let varlist = split(varblock, ',\s*')
  endfor
  let additional = filter(copy(varlist), 'v:val !~# ''\.\{3}''')
  call map(varlist, '"a:" . v:val')
  let i = match(varlist, '^a:\.\{3}$')
  if i != -1
    call remove(varlist, i)
    let varlist += ['a:000', 'a:0', 'a:1', 'a:2', 'a:3']
  endif
  return varlist
endfunction
"}}}
function! s:splitmethodname(identifierlist) abort "{{{
  let memberlist = []
  for identfier in a:identifierlist
    let members = split(identfier, '[^.]\zs\.\ze[^.]')
    if members == []
      continue
    elseif len(members) > 1
      let memberlist += members[: -2]
    endif
    let methodbody = members[-1]
    let methodname = matchstr(methodbody, '\m^\h\w*')
    call add(memberlist, s:funcitem(methodname, methodbody, {'menu': '[member]', 'dup': 1}))
  endfor
  return memberlist
endfunction
"}}}
function! s:functionitems(funcdefinitions) abort "{{{
  let funcitemlist = []
  let funclist = map(copy(a:funcdefinitions), '[
        \   matchstr(v:val, s:const.FUNCREGEX),
        \   matchstr(v:val, s:const.FUNCBODYREGEX),
        \ ]')
  for [funcname, funcbody] in funclist
    if funcname !=# ''
      let completeitem = s:funcitem(funcname, funcbody)
      call add(funcitemlist, completeitem)
    endif
  endfor
  return funcitemlist
endfunction
"}}}
function! s:funcitem(name, body, ...) abort "{{{
  return extend({'word': a:name, 'abbr': a:body, '__text__': a:name, '__func__': 1}, get(a:000, 0, {'menu': '[function]'}))
endfunction
"}}}
function! s:scopecorrectedvaritems(varlist) abort "{{{
  let varlist = copy(a:varlist)
  for var in varlist
    let word = s:lib.word(var)
    if word =~# '^[abglstw]:\h\w*$'
      let withoutscope = matchstr(word, '^[abglstw]:\zs\h\w*$')
      let completeitem = {'word': word, 'menu': '[var]', '__text__': withoutscope}
      call add(a:varlist, completeitem)
    endif
  endfor
  return a:varlist
endfunction
"}}}
function! s:SIDfuncitems(funclist) abort "{{{
  let funclist = copy(a:funclist)
  for func in funclist
    let word = s:lib.word(func)
    if word =~# '^s:\h\w*$'
      let SIDfunc = substitute(word, '^s:\ze\h\w*$', '<SID>', '')
      let item = deepcopy(func)
      let item.word = SIDfunc
      let item.__text__ = SIDfunc
      let item.abbr = substitute(item.abbr, '^s:\ze\h\w*$', '<SID>', '')
      call add(a:funclist, item)
    endif
  endfor
  return a:funclist
endfunction
"}}}
function! s:funcfragmentwordlist() abort "{{{
  let funcfragmentwordlist = []
  let fragment = ''
  for dir in split(matchstr(expand('%:p'), printf('autoload\zs\%%(%s\h\w*\)\+\ze\.vim$', s:lib.escape(s:const.PATHSEPARATOR))), s:lib.escape(s:const.PATHSEPARATOR))
    let fragment .= dir . '#'
    let item = {'word': fragment, 'menu': '[fragment]', '__text__': fragment}
    call add(funcfragmentwordlist, item)
  endfor
  return funcfragmentwordlist
endfunction
"}}}
function! s:varfragmentwordlist(varlist) abort "{{{
  let varfragmentwordlist = []
  for varf in uniq(sort(filter(map(copy(a:varlist), 'matchstr(s:lib.word(v:val), ''\m\C^\zs\%([abglstw]:\)\?\h[[:alnum:]]*[#_]'')'), 'v:val !=# ""')))
    let item = {'word': varf, 'menu': '[fragment]', '__text__': varf}
    call add(varfragmentwordlist, item)
  endfor
  return varfragmentwordlist
endfunction
"}}}
function! s:helptagitems(helptaglist) abort "{{{
  let helptagitems = []
  let file = ' ' . expand('%:t')
  for helptag in a:helptaglist
    let word = printf('|%s|', helptag)
    call add(helptagitems, {'word': word, 'menu': file, 'abbr': helptag, '__text__': word})
  endfor
  return helptagitems
endfunction
"}}}
function! s:inject(destination, Dictionary) abort "{{{
  call filter(a:destination, 0)
  return extend(a:destination, a:Dictionary)
endfunction
"}}}
function! s:decrementpriority(conditionlist) abort "{{{
  let newlist = deepcopy(a:conditionlist)
  for condition in newlist
    if has_key(condition, 'priority') && condition.priority > 0
      let condition.priority -= 1
    endif
  endfor
  return newlist
endfunction
"}}}

function! s:Observer(target, kind) abort
  let Observer = deepcopy(s:Observer)
  let Observer.bufexpr = a:target
  if a:kind ==# 'vim'
    let Observer.inspect = function('s:inspectvim')
    let Observer.checkglobals = function('s:checkglobalsvim')
  elseif a:kind ==# 'help'
    let Observer.inspect = function('s:inspecthelp')
    let Observer.checkglobals = function('s:checkglobalshelp')
  else
    echoerr 'Verdin: Unanticipated arguments are passed to s:Observer().'
  endif
  return Observer
endfunction
"}}}

" vim:set ts=2 sts=2 sw=2 tw=0:
" vim:set foldmethod=marker: commentstring="%s:
