" script local variables {{{
let s:const = Verdin#constants#distribute()
let s:lib = Verdin#lib#distribute()
let s:varconditionlist = [
      \   {'cursor_at': '\m\C^\s*call\s\+\zs\%([ablstw]:\|\%([ablstw]:\)\?\<\h\w*\|g:\h[0-9A-Za-z_#]*\)\?\%#', 'priority': 128},
      \   {'cursor_at': '\m\C^\s*\%(let\|call\?\|if\|elseif\?\|for\|wh\%[ile]\|retu\%[rn]\|exe\%[cute]\|fu\%[nction]!\?\|unl\%[et]!\?\|ec\%[hon]\|echom\%[sg]\|echoe\%[rr]\)\s.*[:.]\@1<!\zs\%(\<[abglstwv]:\h\k*\|\<[abglstwv]:\|\<\k*\)\%#', 'priority': 256},
      \   {'cursor_at': '\m\C^\s*[A-Z]\w*!\?\s.*[:.]\@1<!\zs\%(\<[abglstwv]:\h\k*\|\<[abglstwv]:\|\<\k*\)\%#', 'priority': 0},
      \   {'cursor_at': '\m\C\%(\%([ablstw]:\)\?\<\h\w\{5,}\|g:\h[0-9A-Za-z_#]\{6,}\)\%#', 'priority': 0},
      \ ]
let s:memberconditionlist = [{
      \   'cursor_at': s:const.VARNAME . '\.\zs\%(\h\k*\)\?\%#',
      \   'priority': 384,
      \ }]
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
"}}}

function! Verdin#Observer#get(...) abort "{{{
  let bufnr = get(a:000, 0, bufnr('%'))
  let bufinfo = get(getbufinfo(bufnr), 0, {})
  if bufinfo == {}
    echoerr 'Verdin: Invalid bufnr is given for Verdin#Observer#get()'
  endif

  if !has_key(bufinfo.variables, 'Verdin')
    let bufinfo.variables.Verdin = {}
  endif
  if !has_key(bufinfo.variables.Verdin, 'Observer')
    let bufinfo.variables.Verdin.Observer = s:Observer()
  endif
  return bufinfo.variables.Verdin.Observer
endfunction
"}}}

" Observer object {{{
let s:Observer = {
      \   'bufnr': -1,
      \   'changedtick': {
      \     'buffer': -1,
      \     'global': -1,
      \   },
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
      \   'clock': Verdin#clock#new(),
      \ }
function! s:Observer.inspect(...) dict abort "{{{
  if self.changedtick.buffer == b:changedtick
    return
  endif
  let self.changedtick.buffer = b:changedtick

  if &filetype ==# 'vim'
    let range = get(a:000, 0, 'buffer')
    call self._inspectvim(range)
  elseif &filetype ==# 'help'
    call self._inspecthelp()
  endif
endfunction
"}}}
function! s:Observer._inspectvim(range) dict abort "{{{
  let view = winsaveview()
  let reg = ['"', getreg('"'), getregtype('"')]
  let visualhead = ["'<", getpos("'<")]
  let visualtail = ["'>", getpos("'>")]
  let [bufstart, bufend] = [1, line('$')]
  if a:range ==# 'scope'
    let [scopestart, scopeend, is_dict] = s:scoperange()
  else
    let [scopestart, scopeend, is_dict] = [bufstart, bufend, 0]
  endif
  call self.clock.start()
  let [lvarlist, lmemberlist] = s:splitvarname(s:scan(s:const.LOCALVARREGEX, scopestart, scopeend, self.clock))
  let [gvarlist, gmemberlist] = s:splitvarname(s:scan(s:const.GLOBALVARREGEX, bufstart, bufend, self.clock))
  call s:localvarmembers(lvarlist, lmemberlist, scopestart, scopeend, self.clock)
  let varlist = lvarlist + gvarlist
  call s:lib.sortbyoccurrence(varlist)
  let varlist += s:splitargvarname(s:scan(s:const.ARGREGEX, scopestart, scopestart, self.clock))
  let [_, amemberlist] = s:splitvarname(s:scan(s:const.ARGNAME, scopestart, scopeend, self.clock))
  let memberlist = lmemberlist + gmemberlist + amemberlist
  let memberlist += s:altscan(s:const.KEYREGEX1, s:const.KEYREGEX2, bufstart, bufend, self.clock)
  let memberlist += s:splitmemberfuncname(s:scan(s:const.MEMBERFUNCREGEX, bufstart, bufend, self.clock))
  let funclist = s:functionitems(s:scan(s:const.FUNCDEFINITIONREGEX, bufstart, bufend, self.clock))
  let keymaplist = s:scan(s:const.KEYMAPREGEX, bufstart, bufend, self.clock)
  let commandlist = s:scan(s:const.COMMANDREGEX, bufstart, bufend, self.clock)
  let higrouplist = s:scan(s:const.HIGROUPREGEX, bufstart, bufend, self.clock)
  call call('setpos', visualhead)
  call call('setpos', visualtail)
  call call('setreg', reg)
  call winrestview(view)

  let Completer = Verdin#Completer#get()
  if varlist != []
    call s:scopecorrectedvaritems(varlist)
    if is_dict
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
    let member = Verdin#Dictionary#new('member', s:memberconditionlist, memberlist, 1, options)
    call s:inject(self.shelf['buffermember'], member)
  endif
  if keymaplist != []
    let options = {'sortbyoccurrence': 1, 'delimitermatch': 1}
    let keymap = Verdin#Dictionary#new('keymap', s:keymapconditionlist, keymaplist, 2, options)
    call s:inject(self.shelf['bufferkeymap'], keymap)
  endif
  if commandlist != []
    let conditionlist = Completer.shelf.command.conditionlist
    let command = Verdin#Dictionary#new('command', conditionlist, commandlist, 2)
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
  let varfragmentconditionlist = map(deepcopy(s:varconditionlist), 'extend(v:val, {"priority": get(v:val, "priority", 0) + 128}, "force")')
  let varfragmentwordlist = s:varfragmentwordlist(varlist)
  if varfragmentwordlist != []
    let varfragment = Verdin#Dictionary#new('varfragment', s:varconditionlist, varfragmentwordlist)
    call s:inject(self.shelf['varfragment'], varfragment)
  endif
  call self.clock.stop()
endfunction
"}}}
function! s:Observer._inspecthelp() dict abort "{{{
  let view = winsaveview()
  let reg = ['"', getreg('"'), getregtype('"')]
  let visualhead = ["'<", getpos("'<")]
  let visualtail = ["'>", getpos("'>")]
  let [bufstart, bufend] = [1, line('$')]
  let helptaglist = s:helptagitems(s:scan(s:const.HELPTAGREGEX, bufstart, bufend, self.clock))
  call call('setpos', visualhead)
  call call('setpos', visualtail)
  call call('setreg', reg)
  call winrestview(view)

  if helptaglist != []
    let Completer = Verdin#Completer#get()
    let conditionlist = Completer.shelf.tag.conditionlist
    let helptag = Verdin#Dictionary#new('tag', conditionlist, helptaglist, 2)
    call s:inject(self.shelf['buffertag'], helptag)
  endif
endfunction
"}}}
function! s:Observer.checkglobals() dict abort "{{{
  if &filetype ==# 'vim'
    call self._checkglobalsvim()
  elseif &filetype ==# 'help'
    call self._checkglobalshelp()
  endif
  " redraw cursor
  redraw
endfunction
"}}}
function! s:Observer._checkglobalsvim() dict abort "{{{
  let listedbufs = filter(s:lib.getbufinfo(), 'v:val.bufnr != self.bufnr')
  let globalchangedtick = s:globalchangedtick(listedbufs)
  if self.changedtick.global == globalchangedtick || len(listedbufs) == 0
    return
  endif
  let self.changedtick.global = globalchangedtick

  let originalbufnr = bufnr('%')
  let is_cmdwin = getcmdwintype() !=# ''
  let varlist = []
  let funclist = []
  let memberlist = []
  let keymapwordlist = []
  let commandlist = []
  let higrouplist = []
  for bufinfo in listedbufs
    let Observer = Verdin#Observer#get(bufinfo.bufnr)
    if Observer.changedtick.buffer == -1
      if is_cmdwin
        continue
      endif
      execute 'noautocmd buffer ' . bufinfo.bufnr
      call Observer.inspect('buffer')
    endif
    let varlist += filter(copy(get(Observer.shelf.buffervar, 'wordlist', [])), 's:lib.word(v:val) =~# ''\m\C^[bgtw]:\h\k*''')
    let funclist += filter(copy(get(Observer.shelf.bufferfunc, 'wordlist', [])), 's:lib.word(v:val) =~# ''\m\C^\%([A-Z]\k*\|\h\k\%(#\h\k*\)\+\)''')
    let memberlist += copy(get(Observer.shelf.buffermember, 'wordlist', []))
    let keymapwordlist += filter(copy(get(Observer.shelf.bufferkeymap, 'wordlist', [])), 's:lib.word(v:val) =~# ''\m\C^<Plug>''')
    let commandlist += get(Observer.shelf.buffercommand, 'wordlist', [])
    let higrouplist += get(Observer.shelf.bufferhigroup, 'wordlist', [])
  endfor
  if bufnr('%') != originalbufnr
    execute 'noautocmd buffer ' . originalbufnr
  endif
  let Completer = Verdin#Completer#get()
  if varlist != []
    let var = Verdin#Dictionary#new('var', s:varconditionlist, varlist, 2)
    call s:inject(self.shelf['globalvar'], var)
  endif
  if funclist != []
    let conditionlist = Completer.shelf.function.conditionlist
    let func = Verdin#Dictionary#new('function', conditionlist, funclist, 1)
    call s:inject(self.shelf['globalfunc'], func)
  endif
  if memberlist != []
    let member = Verdin#Dictionary#new('member', s:memberconditionlist, memberlist, 2)
    call s:inject(self.shelf['globalmember'], member)
  endif
  if keymapwordlist != []
    let keymap = Verdin#Dictionary#new('keymap', s:keymapconditionlist, keymapwordlist, 2)
    call s:inject(self.shelf['globalkeymap'], keymap)
  endif
  if commandlist != []
    let conditionlist = Completer.shelf.command.conditionlist
    let command = Verdin#Dictionary#new('command', conditionlist, commandlist, 2)
    call s:inject(self.shelf['globalcommand'], command)
  endif
  if higrouplist != []
    let conditionlist = Completer.shelf.higroup.conditionlist
    let higroup = Verdin#Dictionary#new('higroup', conditionlist, higrouplist, 2)
    call s:inject(self.shelf['globalhigroup'], higroup)
  endif
endfunction
"}}}
function! s:Observer._checkglobalshelp() dict abort "{{{
  let listedbufs = filter(s:lib.getbufinfo(), 'v:val.bufnr != self.bufnr')
  let globalchangedtick = s:globalchangedtick(listedbufs)
  if self.changedtick.global == globalchangedtick
    return
  endif
  let self.changedtick.global = globalchangedtick

  " check help buffer
  let originalbufnr = bufnr('%')
  let is_cmdwin = getcmdwintype() !=# ''
  let helptaglist = []
  for bufinfo in listedbufs
    let Observer = Verdin#Observer#get(bufinfo.bufnr)
    if Observer.changedtick.buffer == -1
      if is_cmdwin
        continue
      endif
      execute 'noautocmd buffer ' . bufinfo.bufnr
      call Observer.inspect()
    endif
    let helptaglist += get(Observer.shelf.buffertag, 'wordlist', [])
  endfor
  if bufnr('%') != originalbufnr
    execute 'noautocmd buffer ' . originalbufnr
  endif
  if helptaglist != []
    let Completer = Verdin#Completer#get()
    let conditionlist = Completer.shelf.tag.conditionlist
    let helptag = Verdin#Dictionary#new('tag', conditionlist, helptaglist, 2)
    call s:inject(self.shelf['globaltag'], helptag)
  endif

  " check vim buffer
  let listedbufs = s:lib.getbufinfo('vim')
  let varlist = []
  let funclist = []
  let keymapwordlist = []
  let commandlist = []
  for bufinfo in listedbufs
    let Observer = Verdin#Observer#get(bufinfo.bufnr)
    if Observer.changedtick.buffer == -1
      execute 'buffer ' . bufinfo.bufnr
      call Observer.inspect()
      execute 'buffer ' . originalbufnr
    endif
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
function! s:scan(pat, startlnum, endlnum, clock) abort "{{{
  if a:clock.elapsed() >= s:const.SEARCHTIMEOUT
    return []
  endif

  execute printf('normal! %dG0', a:startlnum)
  let start = searchpos(a:pat, 'cW', a:endlnum, s:const.SEARCHTIMEOUT)
  if start[0] == 0 || start[0] > a:endlnum
    return []
  endif
  let end = searchpos(a:pat, 'ceW', a:endlnum, s:const.SEARCHTIMEOUT)
  let wordlist = [s:yank(start, end)]
  call cursor(end)
  while a:clock.elapsed() < s:const.SEARCHTIMEOUT
    let start = searchpos(a:pat, 'W', a:endlnum, s:const.SEARCHTIMEOUT)
    if start[0] == 0 || start[0] > a:endlnum
      break
    endif
    let end = searchpos(a:pat, 'ceW', a:endlnum, s:const.SEARCHTIMEOUT)
    let wordlist += [s:yank(start, end)]
    call cursor(end)
  endwhile
  return wordlist
endfunction
"}}}
function! s:altscan(pat1, pat2, startlnum, endlnum, clock) abort "{{{
  if a:clock.elapsed() >= s:const.SEARCHTIMEOUT
    return []
  endif

  execute printf('normal! %dG0', a:startlnum)
  let start = searchpos(a:pat1, 'cW', a:endlnum, s:const.SEARCHTIMEOUT)
  if start[0] == 0 || start[0] > a:endlnum
    return []
  endif
  let end = searchpos(a:pat2, 'ceW', a:endlnum, s:const.SEARCHTIMEOUT)
  let wordlist = [s:yank(start, end)]
  call cursor(end)
  while a:clock.elapsed() < s:const.SEARCHTIMEOUT
    let start = searchpos(a:pat1, 'W', a:endlnum, s:const.SEARCHTIMEOUT)
    if start[0] == 0 || start[0] > a:endlnum
      break
    endif
    let end = searchpos(a:pat2, 'ceW', a:endlnum, s:const.SEARCHTIMEOUT)
    let wordlist += [s:yank(start, end)]
    call cursor(end)
  endwhile
  return wordlist
endfunction
"}}}
function! s:yank(start, end) abort "{{{
  normal! v
  call cursor(a:start)
  normal! o
  call cursor(a:end)
  noautocmd silent! normal! ""y
  return @@
endfunction
"}}}
function! s:scoperange() abort "{{{
  let start = max([search('\m\C^\s*fu\%[nction]!\?', 'bcnW'), 1])
  let end = min([search('\m\C^\s*endf\%[unction]', 'cnW'), line('$')])
  let is_dict = match(getline(start), '\m\C^\s*fu\%[nction]!\?\s\+\%([gs]:\)\?\h\k*\%(\.\%(\h\k*\)\|([^)]*)\%(\s*\%(range\|abort\|closure\)\)*\s*dict\)') >= 0
  return [start, end, is_dict]
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
function! s:splitmemberfuncname(identifierlist) abort "{{{
  let memberlist = []
  for identfier in a:identifierlist
    let memberlist += split(identfier, '\.')
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
      let completeitem = {
            \   'word': funcname, 'menu': '[function]', 'abbr': funcbody,
            \   '__text__': funcname, '__func__': 1,
            \ }
      call add(funcitemlist, completeitem)
    endif
  endfor
  return funcitemlist
endfunction
"}}}
function! s:localvarmembers(varlist, memberlist, scopestart, scopeend, clock) abort "{{{
  for var in a:varlist
    let pattern = '\<' . var . '\>\%(\.\h\k*\)*'
    let [_, memberlist] = s:splitvarname(s:scan(pattern, a:scopestart, a:scopeend, a:clock))
    call extend(a:memberlist, memberlist)
  endfor
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
function! s:globalchangedtick(listedbufs) abort "{{{
  let changedtick = len(a:listedbufs)
  for bufinfo in a:listedbufs
    let changedtick += bufinfo.changedtick
  endfor
  return changedtick
endfunction
"}}}

function! s:Observer() abort
  let Observer = deepcopy(s:Observer)
  let Observer.bufnr = bufnr('%')
  return Observer
endfunction
"}}}

" vim:set ts=2 sts=2 sw=2 tw=0:
" vim:set foldmethod=marker: commentstring="%s:
