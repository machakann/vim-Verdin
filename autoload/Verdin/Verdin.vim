" script local variables {{{
let s:const = Verdin#constants#distribute()
let s:lib = Verdin#lib#distribute()
let s:TRUE = 1
let s:FALSE = 0
let s:ON  = 1
let s:OFF = 0
function! s:SID() abort
  return matchstr(expand('<sfile>'), '<SNR>\zs\d\+\ze_SID$')
endfunction
let s:SID = printf("\<SNR>%s_", s:SID())
delfunction s:SID
let s:VerdinCompletionTrigger = s:SID . '(VerdinCompletionTrigger)'
inoremap <silent> <SID>(VerdinCompletionTrigger) <C-r>=Verdin#Verdin#complete()<CR>
"}}}

function! Verdin#Verdin#startbufferinspection(bang) abort "{{{
  if !s:lib.filetypematches('vim') && !s:lib.filetypematches('help')
    return
  endif
  if s:lib.filetypematches('help') && &buftype ==# 'help'
    return
  endif

  if a:bang ==# '!'
    for bufinfo in s:getbufinfo()
      let Event = Verdin#Event#get(bufinfo.bufnr)
      call Event.bufferinspection_on()
    endfor
  else
    let Event = Verdin#Event#get()
    call Event.bufferinspection_on()
  endif
endfunction "}}}
function! Verdin#Verdin#stopbufferinspection(bang) abort "{{{
  if a:bang ==# '!'
    for bufinfo in s:getbufinfo()
      if has_key(bufinfo.variables, 'Verdin')
        let Event = Verdin#Event#get(bufinfo.bufnr)
        call Event.bufferinspection_off()
      endif
    endfor
  else
    let Event = Verdin#Event#get()
    call Event.bufferinspection_off()
  endif
endfunction "}}}
function! Verdin#Verdin#startautocomplete(bang) abort "{{{
  if !s:lib.filetypematches('vim') && !s:lib.filetypematches('help')
    return
  endif
  if s:lib.filetypematches('help') && &buftype ==# 'help'
    return
  endif

  if a:bang ==# '!'
    let g:Verdin#autocomplete = s:ON
    for bufinfo in s:getbufinfo()
      let Event = Verdin#Event#get(bufinfo.bufnr)
      call Event.bufferinspection_on()
      call Event.autocomplete_on()
    endfor
  else
    let Event = Verdin#Event#get()
    call Event.bufferinspection_on()
    call Event.autocomplete_on()
  endif
endfunction "}}}
function! Verdin#Verdin#stopautocomplete(bang) abort "{{{
  if a:bang ==# '!'
    let g:Verdin#autocomplete = s:OFF
    for bufinfo in s:getbufinfo()
      if has_key(bufinfo.variables, 'Verdin')
        let Event = Verdin#Event#get(bufinfo.bufnr)
        call Event.bufferinspection_off()
        call Event.autocomplete_off()
      endif
    endfor
  else
    let Event = Verdin#Event#get()
    call Event.bufferinspection_off()
    call Event.autocomplete_off()
  endif
endfunction "}}}
function! Verdin#Verdin#refreshautocomplete(bang) abort "{{{
  if a:bang ==# '!'
    for bufinfo in s:getbufinfo()
      if has_key(bufinfo.variables, 'Verdin')
        call s:refresh(bufinfo.bufnr)
      endif
    endfor
  else
    call s:refresh(bufnr('%'))
  endif
endfunction "}}}
function! Verdin#Verdin#finishautocomplete(bang) abort "{{{
  if a:bang ==# '!'
    for bufinfo in s:getbufinfo()
      if has_key(bufinfo.variables, 'Verdin')
        let Event = Verdin#Event#get(bufinfo.bufnr)
        call Event.bufferinspection_off()
        call Event.autocomplete_off()
        unlet! bufinfo.variables.Verdin
      endif
    endfor
  else
    let Event = Verdin#Event#get()
    call Event.bufferinspection_off()
    call Event.autocomplete_off()
    unlet! b:Verdin
  endif
endfunction "}}}
function! Verdin#Verdin#scanbuffer(args) abort "{{{
  if s:lib.filetypematches('vim')
    let defaultorder = s:const.DEFAULTORDERVIM
  elseif s:lib.filetypematches('help')
    let defaultorder = s:const.DEFAULTORDERHELP
  else
    return
  endif
  if a:args ==# ''
    let order = defaultorder
  else
    let order = split(a:args, '[[:blank:],]')
    let validpat = join(['^\%(', join(defaultorder, '\|'), '\)$'], '')
    let invalids = filter(copy(order), {idx, val -> val !~# validpat})
    if invalids != []
      echohl ErrorMsg
      if len(invalids) >= 2
        echomsg printf('Verdin: The input items %s are invalid.', join(map(invalids, {idx, val -> '"' . val . '"'}), ', '))
      elseif len(invalids) == 1
        echomsg printf('Verdin: The input item %s is invalid.', '"' . invalids[0] . '"')
      endif
      echomsg printf('Verdin: The available items are %s. Please try again.', join(map(copy(defaultorder), {idx, val -> '"' . val . '"'}), ', '))
      echohl NONE
      return
    endif
  endif
  let bufnr = bufnr('%')
  call Verdin#Observer#checkglobals(bufnr, 1/0, order)
  call Verdin#Observer#inspect(bufnr, 1/0, order)
endfunction "}}}
function! Verdin#Verdin#scanbuffer_compl(ArgLead, CmdLine, CursorPos) abort "{{{
  if s:lib.filetypematches('vim')
    let defaultorder = s:const.DEFAULTORDERVIM
  elseif s:lib.filetypematches('help')
    let defaultorder = s:const.DEFAULTORDERHELP
  else
    return []
  endif
  return join(defaultorder, "\n")
endfunction "}}}
function! Verdin#Verdin#omnifunc(findstart, base) abort "{{{
  let Event = Verdin#Event#get()
  call Event.bufferinspection_on()

  let Completer = Verdin#Completer#get()
  if a:findstart == 1
    " first run
    return Completer.startcol()
  endif

  " second run
  for item in Completer.modify(Completer.match(a:base))
    call complete_add(item)
  endfor
  call Event.aftercomplete_set(function(Completer.aftercomplete, [0], Completer))

  " fuzzy matching
  let fuzzymatch = Verdin#getoption('fuzzymatch')
  if !fuzzymatch || strchars(a:base) < 3
    return []
  endif
  let timeout = s:const.FUZZYMATCHINTERVAL
  call Completer.clock.start()
  while Completer.fuzzycandidatelist != []
    if complete_check()
      break
    endif
    for item in Completer.modify(Completer.fuzzymatch(a:base, timeout))
      call complete_add(item)
    endfor
  endwhile
  return []
endfunction "}}}
function! Verdin#Verdin#triggercomplete() abort "{{{
  let Completer = Verdin#Completer#get()
  if s:nothingchanged(Completer)
    return ''
  endif

  " to update cursor
  if &lazyredraw
    set nolazyredraw
    let Completer.is.lazyredraw_changed = s:TRUE
  endif
  call feedkeys(s:VerdinCompletionTrigger, 'im')
  return ''
endfunction "}}}
function! Verdin#Verdin#complete() abort "{{{
  let Completer = Verdin#Completer#get()
  call Completer.clock.start()

  " to show matchparen highlight etc...
  redraw
  " restore the 'lazyredraw' option changed in Verdin#Verdin#triggercomplete()
  if Completer.is.lazyredraw_changed
    set lazyredraw
    let Completer.is.lazyredraw_changed = s:FALSE
  endif

  let giveupifshort = s:TRUE
  let startcol = Completer.startcol(giveupifshort)
  if startcol < 0
    return ''
  endif
  let cursorcol = col('.')
  let base = cursorcol == 1 ? '' : getline('.')[startcol : cursorcol-2]
  let nbase = strchars(base)
  let itemlist = Completer.match(base)

  " wait & fuzzy matching (1st stage)
  let timeout = s:const.FUZZYMATCHINTERVAL
  let autocompletedelay = Verdin#getoption('autocompletedelay')
  let fuzzymatch = Verdin#getoption('fuzzymatch') && nbase >= 3
  let fuzzyitemlist = []
  while Completer.clock.elapsed() < autocompletedelay
    if getchar(1) isnot# 0
      return ''
    endif
    if fuzzymatch && Completer.fuzzycandidatelist != []
      let fuzzyitemlist += Completer.fuzzymatch(base, timeout)
    endif
  endwhile
  let itemlist += sort(fuzzyitemlist, 's:compare_fuzzyitem')
  if itemlist != []
    call Completer.modify(itemlist)
    call Completer.complete(startcol, itemlist)
  endif

  " fuzzy matching (2nd stage)
  if !fuzzymatch
    return ''
  endif
  let timeout = s:const.FUZZYMATCHINTERVAL
  while Completer.fuzzycandidatelist != []
    if getchar(1) isnot# 0 || len(itemlist) > s:const.ITEMLISTTHRESHOLD
      break
    endif
    let additional = Completer.fuzzymatch(base, timeout)
    if additional != []
      call Completer.modify(additional)
      let itemlist += additional
      call Completer.complete(startcol, itemlist)
    endif
  endwhile
  return ''
endfunction "}}}
function! s:getbufinfo() abort "{{{
  if s:lib.filetypematches('vim')
    return filter(getbufinfo({'buflisted':1}), 's:lib.filetypematches("vim", v:val.bufnr)')
  elseif s:lib.filetypematches('help')
    return filter(getbufinfo({'buflisted':1}), 's:lib.filetypematches("help", v:val.bufnr) && getbufvar(v:val.bufnr, "&buftype") !=# "help"')
  endif
  return []
endfunction "}}}
function! s:nothingchanged(Completer) abort "{{{
  return a:Completer.last.lnum == line('.') && a:Completer.last.col == col('.') && a:Completer.last.line ==# getline('.')
endfunction "}}}
function! s:refresh(bufnr) abort "{{{
  let Event = Verdin#Event#get(a:bufnr)
  unlet! b:Verdin
  call Verdin#Completer#get()
  call Verdin#Observer#get()
  let b:Verdin.Event = Event
  call Event.bufferinspection_on()
endfunction "}}}
function! s:compare_fuzzyitem(i1, i2) abort "{{{
  let diffdifflen = abs(a:i1.__difflen__) - abs(a:i2.__difflen__)
  if diffdifflen != 0
    return diffdifflen
  endif
  if a:i1.__score__ > a:i2.__score__
    return -1
  elseif a:i1.__score__ < a:i2.__score__
    return 1
  endif
  return 0
endfunction "}}}

" vim:set ts=2 sts=2 sw=2 tw=0:
" vim:set foldmethod=marker: commentstring="%s:

