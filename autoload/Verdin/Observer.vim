" script local variables {{{
let s:SEARCHLINES = 200
let s:const = Verdin#constants#distribute()
let s:lib = Verdin#lib#distribute()
let s:TRUE = 1
let s:FALSE = 0
let s:cache = {}
"}}}


function! Verdin#Observer#get(...) abort "{{{
  let target = get(a:000, 0, '%')
  let bufinfo = get(getbufinfo(target), 0, {})
  if bufinfo == {}
    echoerr printf('Verdin: Invalid target is given for Verdin#Observer#get(): %s', target)
  endif

  if !has_key(bufinfo.variables, 'Verdin')
    let bufinfo.variables.Verdin = {}
  endif
  if !has_key(bufinfo.variables.Verdin, 'Observer')
    if s:lib.filetypematches('vim') || s:lib.filetypematches('vimspec') || bufname(target) =~# '\.vim\%(spec\)\?$'
      let filetype = 'vim'
    elseif s:lib.filetypematches('help')
      let filetype = 'help'
    else
      return {}
    endif
    let bufinfo.variables.Verdin.Observer = Verdin#Observer#new(target, filetype)
  endif
  return bufinfo.variables.Verdin.Observer
endfunction "}}}


let s:timerid = -1

function! Verdin#Observer#debounce(bufnr) abort "{{{
  call Verdin#Observer#cancel_debounce()
  let s:timerid = timer_start(1, {-> Verdin#Observer#inspect(a:bufnr)})
endfunction "}}}


function! Verdin#Observer#cancel_debounce() abort "{{{
  if s:timerid isnot# -1
    let hoge = s:timerid
    call timer_stop(s:timerid)
    let s:timerid = -1
  endif
endfunction "}}}


function! Verdin#Observer#inspect(bufnr, ...) abort "{{{
  let s:timerid = -1
  if s:lib.filetypematches('vim') || s:lib.filetypematches('vimspec') || bufname(a:bufnr) =~# '\.vim\%(spec\)\?$'
    let filetype = 'vim'
    let order = get(a:000, 1, s:const.DEFAULTORDERVIM)
  elseif s:lib.filetypematches('help')
    let filetype = 'help'
    let order = get(a:000, 1, s:const.DEFAULTORDERHELP)
  else
    return
  endif

  let timeout = get(a:000, 0, s:const.SCANTIMEOUT)
  let forcescan = get(a:000, 2, 0)
  let Observer = Verdin#Observer#get(a:bufnr)
  if Observer.changedtick == -1
    call Observer.checkglobals(timeout, order, forcescan)
  endif
  call Observer.inspect(timeout, order, forcescan)
endfunction "}}}


function! Verdin#Observer#checkglobals(bufnr, ...) abort "{{{
  if s:lib.filetypematches('vim') || s:lib.filetypematches('vimspec') || bufname(a:bufnr) =~# '\.vim\%(spec\)\?$'
    let filetype = 'vim'
    let order = get(a:000, 1, s:const.DEFAULTORDERVIM)
  elseif s:lib.filetypematches('help')
    let filetype = 'help'
    let order = get(a:000, 1, s:const.DEFAULTORDERHELP)
  else
    return
  endif

  let timeout = get(a:000, 0, s:const.SCANTIMEOUT)
  let forcescan = get(a:000, 2, 0)
  let Observer = Verdin#Observer#get(a:bufnr)
  call Observer.checkglobals(timeout, order, forcescan)
endfunction "}}}


" Observer object {{{
let s:Observer = {
      \   'filetype': '',
      \   'bufname': '',
      \   'bufnr': 0,
      \   'changedtick': -1,
      \   'globalcheckstarted': 0,
      \   'shelf': {
      \     'buffervar': {},
      \     'bufferfunc': {},
      \     'buffermember': {},
      \     'bufferkeymap': {},
      \     'buffercommand': {},
      \     'bufferhigroup': {},
      \     'bufferaugroup': {},
      \     'buffertag': {},
      \     'globalvar': {},
      \     'globalfunc': {},
      \     'globalmember': {},
      \     'globalkeymap': {},
      \     'globalcommand': {},
      \     'globalhigroup': {},
      \     'globalaugroup': {},
      \     'globaltag': {},
      \     'varfragment': {},
      \     'funcfragment': {},
      \   },
      \   'testmode': 0,
      \   'bufferinspection': s:FALSE,
      \ }
function! s:Observer.changed() dict abort "{{{
  return getbufvar(self.bufnr, 'changedtick', 0) != self.changedtick
endfunction "}}}


function! s:checkglobalsvim(...) dict abort "{{{
  let timeout = get(a:000, 0, s:const.SCANTIMEOUT)
  let order = get(a:000, 1, s:const.DEFAULTORDERVIM)
  let forcescan = get(a:000, 2, 0)

  let files = filter(s:lib.searchvimscripts(), 'bufnr(v:val) != self.bufnr')
  if !forcescan && self.globalcheckstarted && !s:changed(files)
    return
  endif
  let self.globalcheckstarted = 1

  let varlist = []
  let funclist = []
  let memberlist = []
  let keymapwordlist = []
  let commandlist = []
  let higrouplist = []
  let augrouplist = []
  for filepath in files
    let Observer = s:check(filepath, 'vim', timeout, order)
    if empty(Observer)
      continue
    endif
    let varlist += filter(copy(get(Observer.shelf.buffervar, 'wordlist', [])), 's:lib.word(v:val) =~# ''\m\C^[bgtw]:\h\k*''')
    let funclist += filter(copy(get(Observer.shelf.bufferfunc, 'wordlist', [])), 's:lib.word(v:val) =~# ''\m\C^\%([A-Z]\k*\|\h\k*\%(#\h\k*\)\+\)''')
    let memberlist += copy(get(Observer.shelf.buffermember, 'wordlist', []))
    let keymapwordlist += filter(copy(get(Observer.shelf.bufferkeymap, 'wordlist', [])), 's:lib.word(v:val) =~# ''\m\C^<Plug>''')
    let commandlist += get(Observer.shelf.buffercommand, 'wordlist', [])
    let higrouplist += get(Observer.shelf.bufferhigroup, 'wordlist', [])
    let augrouplist += get(Observer.shelf.bufferaugroup, 'wordlist', [])
  endfor

  if varlist != []
    let conditionlist = s:decrementpriority(s:const.VARCONDITIONLIST)
    let var = Verdin#Dictionary#new('var', conditionlist, varlist, 2)
    call s:inject(self.shelf['globalvar'], var)
  endif
  if funclist != []
    let conditionlist = s:decrementpriority(s:const.FUNCCONDITIONLIST)
    let func = Verdin#Dictionary#new('function', conditionlist, funclist, 1)
    call s:inject(self.shelf['globalfunc'], func)
  endif
  if memberlist != []
    call uniq(sort(memberlist))
    let conditionlist = s:decrementpriority(s:const.MEMBERCONDITIONLIST)
    let member = Verdin#Dictionary#new('member', conditionlist, memberlist, 1)
    call s:inject(self.shelf['globalmember'], member)
  endif
  if keymapwordlist != []
    let conditionlist = s:decrementpriority(s:const.KEYMAPCONDITIONLIST)
    let keymap = Verdin#Dictionary#new('keymap', conditionlist, keymapwordlist, 2)
    call s:inject(self.shelf['globalkeymap'], keymap)
  endif
  if commandlist != []
    let conditionlist = s:decrementpriority(s:const.COMMANDCONDITIONLIST)
    let command = Verdin#Dictionary#new('command', conditionlist, commandlist, 2)
    call s:inject(self.shelf['globalcommand'], command)
  endif
  if higrouplist != []
    let conditionlist = s:decrementpriority(s:const.HIGROUPCONDITIONLIST)
    let higroup = Verdin#Dictionary#new('higroup', conditionlist, higrouplist, 2)
    call s:inject(self.shelf['globalhigroup'], higroup)
  endif
  if augrouplist != []
    let conditionlist = s:decrementpriority(s:const.AUGROUPCONDITIONLIST)
    let augroup = Verdin#Dictionary#new('augroup', conditionlist, augrouplist, 1)
    call s:inject(self.shelf['globalaugroup'], augroup)
  endif
endfunction "}}}
function! s:checkglobalshelp(...) dict abort "{{{
  let timeout = get(a:000, 0, s:const.SCANTIMEOUT)
  let order = get(a:000, 1, s:const.DEFAULTORDERHELP)
  let forcescan = get(a:000, 2, 0)

  let files = filter(s:lib.searchvimhelps(), 'bufnr(v:val) != self.bufnr')
  if !forcescan && self.globalcheckstarted && !s:changed(files)
    return
  endif
  let self.globalcheckstarted = 1

  " check help buffer
  let helptaglist = []
  for filepath in files
    let Observer = s:check(filepath, 'help', timeout, order)
    if empty(Observer)
      continue
    endif
    let helptaglist += get(Observer.shelf.buffertag, 'wordlist', [])
  endfor
  if helptaglist != []
    let conditionlist = s:const.HELPTAGCONDITIONLIST
    let helptag = Verdin#Dictionary#new('tag', conditionlist, helptaglist, 2)
    call s:inject(self.shelf['globaltag'], helptag)
  endif

  " check vim buffer
  let varlist = []
  let funclist = []
  let keymapwordlist = []
  let commandlist = []
  let higrouplist = []
  for filepath in s:lib.searchvimscripts()
    let Observer = s:check(filepath, 'vim', timeout, ['var', 'func', 'keymap', 'command', 'higroup'])
    if empty(Observer)
      continue
    endif
    let varlist += filter(copy(get(Observer.shelf.buffervar, 'wordlist', [])), 's:lib.__text__(v:val) =~# ''\m\C^[bgtw]:\h[A-Za-z0-9_#]*''')
    let funclist += filter(copy(get(Observer.shelf.bufferfunc, 'wordlist', [])), 's:lib.__text__(v:val) =~# ''\m\C^\%([A-Z]\w*\|\h\w\%(#\h\w*\)\+\)''')
    let keymapwordlist += filter(copy(get(Observer.shelf.bufferkeymap, 'wordlist', [])), 's:lib.__text__(v:val) =~# ''\m\C^<Plug>''')
    let commandlist += get(Observer.shelf.buffercommand, 'wordlist', [])
    let higrouplist += get(Observer.shelf.bufferhigroup, 'wordlist', [])
  endfor
  if varlist != []
    let conditionlist = [{'cursor_at': '\m\C\<[bgtw]:\h[A-Za-z0-9_#]*\%#'}]
    let var = Verdin#Dictionary#new('var', conditionlist, varlist, 3)
    call s:inject(self.shelf['globalvar'], var)
  endif
  if funclist != []
    let conditionlist = [{'cursor_at': '\m\C\<\%([A-Z]\w*\|\h\w*\%(#\h\w*\)*\)\%#'}]
    let func = Verdin#Dictionary#new('function', conditionlist, funclist, 3)
    call s:inject(self.shelf['globalfunc'], func)
  endif
  if keymapwordlist != []
    let conditionlist = [{'cursor_at': '\m\C\%(<Pl\%[ug>]\|<Plug>\S*\)\%#'}]
    let keymap = Verdin#Dictionary#new('keymap', conditionlist, keymapwordlist, 3)
    call s:inject(self.shelf['globalkeymap'], keymap)
  endif
  if commandlist != []
    let conditionlist = [{'cursor_at': '\m\C:\?\<[A-Z]\w*\%#'}, ]
    let commandlist += map(filter(copy(commandlist), 'type(v:val) == v:t_string'), '":" . v:val')
    let command = Verdin#Dictionary#new('command', conditionlist, commandlist, 3)
    call s:inject(self.shelf['globalcommand'], command)
  endif
  if higrouplist != []
    let conditionlist = [{'cursor_at': '\m\C\zs\<\%(hl-\)\?[A-Z]\w*\%#'}]
    let higrouplist += map(filter(copy(higrouplist), 'type(v:val) == v:t_string'), '"hl-" . v:val')
    let higroup = Verdin#Dictionary#new('higroup', conditionlist, higrouplist, 3)
    call s:inject(self.shelf['globalhigroup'], higroup)
  endif
endfunction "}}}
function! s:check(filepath, filetype, timeout, order) abort "{{{
  if bufloaded(a:filepath)
    let Observer = Verdin#Observer#get(a:filepath)
    if empty(Observer)
      return Observer
    endif
    call Observer.inspect(a:timeout, a:order)
    if has_key(s:cache, a:filepath)
      unlet s:cache[a:filepath]
    endif
  elseif !has_key(s:cache, a:filepath)
    let Observer = Verdin#Observer#new(a:filepath, a:filetype)
    call Observer.inspect(a:timeout, a:order)
    let s:cache[a:filepath] = Observer
  else
    let Observer = s:cache[a:filepath]
  endif
  return Observer
endfunction "}}}
function! s:changed(vimscripts) abort "{{{
  for filepath in a:vimscripts
    if bufloaded(filepath)
      let Observer = Verdin#Observer#get(filepath)
      if empty(Observer)
        continue
      endif
      if Observer.changed()
        return 1
      endif
    endif
  endfor
  return 0
endfunction "}}}


function! s:inspectvim(...) dict abort "{{{
  let timeout = get(a:000, 0, s:const.SCANTIMEOUT)
  let order = get(a:000, 1, s:const.DEFAULTORDERVIM)
  let forcescan = get(a:000, 2, 0)

  if !forcescan && !self.changed()
    return
  endif
  let self.changedtick = getbufvar(self.bufnr, 'changedtick', 0)

  " NOTE: The second condition is for tests
  if bufloaded(self.bufnr) || self.testmode
    let global = s:get_buffer_string(self.bufnr)
    if self.bufnr == bufnr('%')
      let cursoridx = line2byte(line('.')) + col('.') - 1
    else
      let cursoridx = -1
    endif
  else
    let global = s:get_file_string(self.bufname)
    let cursoridx = -1
  endif
  let local = s:get_local_string(global, cursoridx)

  let clock = Verdin#clock#new()
  call clock.start()

  let varlist = []
  let memberlist = []
  let funclist = []
  let keymaplist = []
  let commandlist = []
  let higrouplist = []
  let augrouplist = []
  if match(order, '\m\C^var$') >= 0
    let [lvarlist, lmemberlist] = s:splitvarname(s:scan(local, s:const.LOCALVARREGEX, clock, timeout))
    let [gvarlist, gmemberlist] = s:splitvarname(s:scan(global, s:const.GLOBALVARREGEX, clock, timeout))
    let varlist += lvarlist + gvarlist
    call s:lib.sortbyoccurrence(varlist)
    let varlist += s:splitargvarname(s:scan(local, s:const.ARGREGEX, clock, timeout))
    let [_, amemberlist] = s:splitvarname(s:scan(local, s:const.ARGNAME, clock, timeout))
    let memberlist = lmemberlist + gmemberlist + amemberlist
    let memberlist += s:splitmembername(s:scan(global, s:const.KEYREGEX, clock, timeout))
    call uniq(sort(memberlist))
    let memberlist += s:splitmethodname(s:scan(global, s:const.METHODREGEX, clock, timeout))
  endif
  if match(order, '\m\C^func$') >= 0
    let funclist = s:functionitems(s:scan(global, s:const.FUNCDEFINITIONREGEX, clock, timeout))
  endif
  if match(order, '\m\C^keymap$') >= 0
    let keymaplist = s:scan(global, s:const.KEYMAPREGEX, clock, timeout)
  endif
  if match(order, '\m\C^command$') >= 0
    let commandlist = s:scan(global, s:const.COMMANDREGEX, clock, timeout)
  endif
  if match(order, '\m\C^higroup$') >= 0
    let higrouplist = s:scan(global, s:const.HIGROUPREGEX, clock, timeout)
  endif
  if match(order, '\m\C^augroup$') >= 0
    let augrouplist = s:scan(global, s:const.AUGROUPREGEX, clock, timeout)
  endif

  if varlist != []
    call s:scopecorrectedvaritems(varlist)
    if local.is_dictfunc
      call add(varlist, 'self')
    endif
    let var = Verdin#Dictionary#new('var', s:const.VARCONDITIONLIST, varlist, 2)
    call s:inject(self.shelf['buffervar'], var)
  endif
  if funclist != []
    call s:SIDfuncitems(funclist)
    let options = {'sortbyoccurrence': 1}
    let func = Verdin#Dictionary#new('function', s:const.FUNCCONDITIONLIST, funclist, 1, options)
    call s:inject(self.shelf['bufferfunc'], func)
  endif
  if memberlist != []
    let options = {'sortbyoccurrence': 1}
    let member = Verdin#Dictionary#new('member', s:const.MEMBERCONDITIONLIST, memberlist, 1, options)
    call s:inject(self.shelf['buffermember'], member)
  endif
  if keymaplist != []
    let options = {'sortbyoccurrence': 1}
    let keymap = Verdin#Dictionary#new('keymap', s:const.KEYMAPCONDITIONLIST, keymaplist, 2, options)
    call s:inject(self.shelf['bufferkeymap'], keymap)
  endif
  if commandlist != []
    let command = Verdin#Dictionary#new('command', s:const.COMMANDCONDITIONLIST, commandlist, 2)
    call s:inject(self.shelf['buffercommand'], command)
  endif
  if higrouplist != []
    let higroup = Verdin#Dictionary#new('higroup', s:const.HIGROUPCONDITIONLIST, higrouplist, 2)
    call s:inject(self.shelf['bufferhigroup'], higroup)
  endif
  if augrouplist != []
    let augroup = Verdin#Dictionary#new('augroup', s:const.AUGROUPCONDITIONLIST, augrouplist, 1)
    call s:inject(self.shelf['bufferaugroup'], augroup)
  endif
  if !g:Verdin#disable_func_fragment
    if self.shelf.funcfragment == {}
      let funcfragmentwordlist = s:funcfragmentwordlist(self.bufnr)
      let funcfragment = Verdin#Dictionary#new('funcfragment', s:const.FUNCFRAGMENTCONDITIONLIST, funcfragmentwordlist)
      call s:inject(self.shelf['funcfragment'], funcfragment)
    endif
  endif
  if !g:Verdin#disable_var_fragment
    let varfragmentwordlist = s:varfragmentwordlist(varlist)
    if varfragmentwordlist != []
      let varfragment = Verdin#Dictionary#new('varfragment', s:const.VARFRAGMENTCONDITIONLIST, varfragmentwordlist)
      call s:inject(self.shelf['varfragment'], varfragment)
    endif
  endif
  call clock.stop()
endfunction "}}}
function! s:inspecthelp(...) dict abort "{{{
  let timeout = get(a:000, 0, s:const.SCANTIMEOUT)
  let order = get(a:000, 1, s:const.DEFAULTORDERHELP)
  let forcescan = get(a:000, 2, 0)

  if !forcescan && !self.changed()
    return
  endif
  let self.changedtick = getbufvar(self.bufnr, 'changedtick', 0)

  if bufloaded(self.bufnr)
    let doc = s:get_buffer_string(self.bufnr)
  else
    let doc = s:get_file_string(self.bufname)
  endif
  let clock = Verdin#clock#new()
  call clock.start()

  let helptaglist = []
  if match(order, '\m\C^tag$') >= 0
    let helptaglist += s:helptagitems(s:scan(doc, s:const.HELPTAGREGEX, clock, timeout))
  endif

  if helptaglist != []
    let helptag = Verdin#Dictionary#new('tag', s:const.HELPTAGCONDITIONLIST, helptaglist, 2)
    call s:inject(self.shelf['buffertag'], helptag)
  endif
endfunction "}}}
function! s:get_line_break() abort "{{{
  if &fileformat ==# 'unix'
    let linebreak = "\n"
  elseif &fileformat ==# 'dos'
    let linebreak = "\r\n"
  else
    let linebreak = "\r"
  endif
  return linebreak
endfunction "}}}
function! s:get_buffer_string(bufnr) abort "{{{
  let linebreak = s:get_line_break()
  let buffer = getbufline(a:bufnr, 1, line('$'))
  let string = join(buffer, linebreak)
  let length = strlen(string)
  return {'str': string, 'len': length}
endfunction "}}}
function! s:get_file_string(filepath) abort "{{{
  if !filereadable(a:filepath)
    return {'str': '', 'len': 0}
  endif

  let linebreak = s:get_line_break()
  let file = readfile(a:filepath)
  let string = join(file, linebreak)
  let length = strlen(string)
  return {'str': string, 'len': length}
endfunction "}}}
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
endfunction "}}}
function! s:is_dict_function(local) abort "{{{
  if a:local ==# ''
    return 0
  endif
  return match(a:local, '\m\C^\s*fu\%[nction]!\?\s\+\%([gs]:\)\?\h\k*\%(\.\%(\h\k*\)\|([^)]*)\%(\s*\%(range\|abort\|closure\)\)*\s*dict\)') >= 0
endfunction "}}}
function! s:scan(text, pat, clock, timeout) abort "{{{
  if a:text.str ==# ''
    return []
  endif

  let i = 0
  let alive = 1
  let counts = range(s:const.SEARCHINTERVAL)
  let wordlist = []
  while alive
    if a:clock.elapsed() >= a:timeout
      break
    endif

    for j in counts
      let ret = matchstrpos(a:text.str, a:pat, i)
      if ret[1] == -1
        let alive = 0
        break
      endif
      let wordlist += [ret[0]]
      let i = ret[2]
      if i >= a:text.len
        let alive = 0
        break
      endif
    endfor
  endwhile
  return wordlist
endfunction "}}}
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
endfunction "}}}
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
endfunction "}}}
function! s:splitmembername(memberlist) abort "{{{
  let wordlist = []
  for string in a:memberlist
    let wordlist += split(string, '\.')
  endfor
  return filter(wordlist, 'v:val !~# ''($''')
endfunction "}}}
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
endfunction "}}}
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
endfunction "}}}
function! s:funcitem(name, body, ...) abort "{{{
  return extend({'word': a:name, 'abbr': a:body, '__text__': a:name, '__func__': 1}, get(a:000, 0, {'menu': '[function]'}))
endfunction "}}}
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
endfunction "}}}
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
endfunction "}}}
function! s:funcfragmentwordlist(bufnr) abort "{{{
  let funcfragmentwordlist = []
  let fragment = ''
  let pat = printf('autoload\zs\%%(%s\h\w*\)\+\ze\.vim$', s:lib.escape(s:const.PATHSEPARATOR))
  let autoloadpath = matchstr(bufname(a:bufnr), pat)
  for dir in split(autoloadpath, s:lib.escape(s:const.PATHSEPARATOR))
    let fragment .= dir . '#'
    let item = {'word': fragment, 'menu': '[fragment]', '__text__': fragment}
    call add(funcfragmentwordlist, item)
  endfor
  return funcfragmentwordlist
endfunction "}}}
function! s:varfragmentwordlist(varlist) abort "{{{
  let varfragmentwordlist = []
  for varf in uniq(sort(filter(map(copy(a:varlist), 'matchstr(s:lib.word(v:val), ''\m\C^\zs\%([abglstw]:\)\?\h[[:alnum:]]*[#_]'')'), 'v:val !=# ""')))
    let item = {'word': varf, 'menu': '[fragment]', '__text__': varf}
    call add(varfragmentwordlist, item)
  endfor
  return varfragmentwordlist
endfunction "}}}
function! s:helptagitems(helptaglist) abort "{{{
  let file = ' ' . expand('%:t')
  return map(a:helptaglist, "{'word': v:val, 'menu': file, 'abbr': v:val, '__text__': v:val}")
endfunction "}}}
function! s:inject(destination, Dictionary) abort "{{{
  call filter(a:destination, 0)
  return extend(a:destination, a:Dictionary)
endfunction "}}}
function! s:decrementpriority(conditionlist, ...) abort "{{{
  let dec = get(a:000, 0, 1)
  let newlist = deepcopy(a:conditionlist)
  for condition in newlist
    if has_key(condition, 'priority') && condition.priority > 0
      let condition.priority -= dec
    endif
  endfor
  return newlist
endfunction "}}}


let s:ON  = 1
let s:OFF = 0
function! s:Observer.bufferinspection_on(...) abort "{{{
  if self.bufferinspection is s:ON
    return
  endif
  let self.bufferinspection = s:ON

  let timeout = get(a:000, 0, s:const.SCANTIMEOUT)
  let order = get(a:000, 1, self.filetype is# 'help' ? s:const.DEFAULTORDERHELP : s:const.DEFAULTORDERVIM)
  let forcescan = get(a:000, 2, 0)
  if self.changedtick == -1
    call self.checkglobals(timeout, order, forcescan)
  endif
  call self.inspect(timeout, order, forcescan)

  augroup Verdin-bufferinspection
    execute printf('autocmd! * <buffer=%d>', self.bufnr)
    execute printf('autocmd InsertEnter  <buffer=%d> call Verdin#Observer#debounce(%d)', self.bufnr, self.bufnr)
    execute printf('autocmd InsertLeave  <buffer=%d> call Verdin#Observer#cancel_debounce()', self.bufnr)
    execute printf('autocmd BufWritePost <buffer=%d> call Verdin#Observer#inspect(%d, %d)', self.bufnr, self.bufnr, s:const.SCANTIMEOUTLONG)
    execute printf('autocmd BufEnter     <buffer=%d> call Verdin#Observer#checkglobals(%d)', self.bufnr, self.bufnr)
  augroup END
endfunction "}}}
function! s:Observer.bufferinspection_off(...) abort "{{{
  let self.bufferinspection = s:OFF
  augroup Verdin-bufferinspection
    execute printf('autocmd! * <buffer=%d>', self.bufnr)
  augroup END
endfunction "}}}
"}}}


function! Verdin#Observer#new(target, filetype, ...) abort "{{{
  let testmode = get(a:000, 0, 0)
  let bufinfo = get(getbufinfo(a:target), 0, {})
  let Observer = deepcopy(s:Observer)
  let Observer.filetype = a:filetype
  if type(a:target) == v:t_number
    let Observer.bufname = fnamemodify(bufname(a:target), ':p')
  else
    let Observer.bufname = fnamemodify(a:target, ':p')
  endif
  let Observer.bufnr = bufnr(a:target)
  let Observer.testmode = testmode
  if a:filetype ==# 'vim'
    let Observer.inspect = function('s:inspectvim')
    let Observer.checkglobals = function('s:checkglobalsvim')
  elseif a:filetype ==# 'help'
    let Observer.inspect = function('s:inspecthelp')
    let Observer.checkglobals = function('s:checkglobalshelp')
  else
    echoerr 'Verdin: Unanticipated arguments are passed to s:Observer().'
  endif
  return Observer
endfunction "}}}

" vim:set ts=2 sts=2 sw=2 tw=0:
" vim:set foldmethod=marker: commentstring="%s:
