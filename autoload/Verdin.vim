" script local variables {{{
let s:lib = Verdin#lib#distribute()
let s:const = Verdin#constants#distribute()
let s:default = s:const.option.default
function! s:SID() abort
  return matchstr(expand('<sfile>'), '<SNR>\zs\d\+\ze_SID$')
endfunction
let s:SID = printf("\<SNR>%s_", s:SID())
delfunction s:SID
let s:VerdinCompletionTrigger = s:SID . '(VerdinCompletionTrigger)'
inoremap <silent> <SID>(VerdinCompletionTrigger) <C-r>=<SID>complete()<CR>
"}}}
" options{{{
let g:Verdin_autocomplete = get(g:, 'Verdin_autocomplete', s:default.autocomplete)
let g:Verdin_autocompletedelay = get(g:, 'Verdin_autocompletedelay', s:default.autocompletedelay)
let g:Verdin_donotsetomnifunc = get(g:, 'Verdin_donotsetomnifunc', s:default.donotsetomnifunc)
let g:Verdin_fuzzymatch = get(g:, 'Verdin_fuzzymatch', s:default.fuzzymatch)
let g:Verdin_autobraketinsert = get(g:, 'Verdin_autobraketinsert', s:default.autobraketinsert)
let g:Verdin_debugmodeon = get(g:, 'Verdin_autobraketinsert', s:default.debugmodeon)
"}}}

function! Verdin#startautocomplete(...) abort "{{{
  if &filetype !=# 'vim' && &filetype !=# 'help'
    echoerr 'Verdin: This is *not* vim buffer!'
    return
  endif
  if &filetype ==# 'help' && &buftype ==# 'help'
    return
  endif

  let Event = Verdin#Event#get()
  call Event.startbufferinspection()
  call Event.startautocomplete()

  let bang = get(a:000, 0, '')
  if bang ==# '!'
    let originalbufnr = bufnr('%')
    for bufinfo in filter(s:lib.getbufinfo(), 'v:val.bufnr != originalbufnr')
      if !has_key(bufinfo.variables, 'Verdin')
        execute 'buffer ' . bufinfo.bufnr
        let Event = Verdin#Event#get()
        call Event.startbufferinspection()
        call Event.startautocomplete()
      endif
    endfor
    execute 'buffer ' . originalbufnr
  endif
endfunction
"}}}
function! Verdin#stopautocomplete(...) abort "{{{
  let Event = Verdin#Event#get()
  call Event.stopbufferinspection()
  call Event.stopautocomplete()

  let bang = get(a:000, 0, '')
  if bang ==# '!'
    let originalbufnr = bufnr('%')
    for bufinfo in filter(s:lib.getbufinfo(), 'v:val.bufnr != originalbufnr')
      if has_key(bufinfo.variables, 'Verdin')
        execute 'buffer ' . bufinfo.bufnr
        let Event = Verdin#Event#get()
        call Event.stopbufferinspection()
        call Event.stopautocomplete()
      endif
    endfor
    execute 'buffer ' . originalbufnr
  endif
endfunction
"}}}
function! Verdin#refreshautocomplete(...) abort "{{{
  call s:refresh()

  let bang = get(a:000, 0, '')
  if bang ==# '!'
    let originalbufnr = bufnr('%')
    for bufinfo in filter(s:lib.getbufinfo(), 'v:val.bufnr != originalbufnr')
      if has_key(bufinfo.variables, 'Verdin')
        execute 'buffer ' . bufinfo.bufnr
        call s:refresh()
      endif
    endfor
    execute 'buffer ' . originalbufnr
  endif
endfunction
"}}}
function! Verdin#finishautocomplete(...) abort "{{{
  let Event = Verdin#Event#get()
  call Event.stopbufferinspection()
  call Event.stopautocomplete()
  unlet! b:Verdin

  let bang = get(a:000, 0, '')
  if bang ==# '!'
    let originalbufnr = bufnr('%')
    for bufinfo in filter(s:lib.getbufinfo(), 'v:val.bufnr != originalbufnr')
      if has_key(bufinfo.variables, 'Verdin')
        execute 'buffer ' . bufinfo.bufnr
        let Event = Verdin#Event#get()
        call Event.stopbufferinspection()
        call Event.stopautocomplete()
        unlet! b:Verdin
      endif
    endfor
    execute 'buffer ' . originalbufnr
  endif
endfunction
"}}}
function! Verdin#omnifunc(findstart, base) abort "{{{
  let Event = Verdin#Event#get()
  call Event.startbufferinspection()

  let Completer = Verdin#Completer#get()
  if a:findstart == 1
    " first run
    return Completer.startcol()
  endif

  " second run
  for item in Completer.modify(Completer.match(a:base))
    call complete_add(item)
  endfor

  " fuzzy matching
  let fuzzymatch = s:lib.getoption('fuzzymatch')
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
endfunction
"}}}
function! Verdin#triggercomplete() abort "{{{
  let Completer = Verdin#Completer#get()
  if s:nothingchanged(Completer)
    return ''
  endif
  if &lazyredraw
    set nolazyredraw
    let Completer.is.lazyredraw_changed = v:true
  endif
  call feedkeys(s:VerdinCompletionTrigger, 'im')
  return ''
endfunction
"}}}
function! s:complete() abort "{{{
  let Completer = Verdin#Completer#get()
  call s:redraw(Completer)
  call Completer.clock.start()
  let startcol = Completer.startcol(v:true)
  if startcol < 0
    return ''
  endif
  let cursorcol = col('.')
  let base = cursorcol == 1 ? '' : getline('.')[startcol : cursorcol-2]
  let nbase = strchars(base)
  let itemlist = Completer.match(base)

  " wait & fuzzy matching (1st stage)
  let autocompletedelay = s:lib.getoption('autocompletedelay')
  let fuzzymatch = s:lib.getoption('fuzzymatch')
  let fuzzyitemlist = []
  if !fuzzymatch || nbase < 3
    while Completer.clock.elapsed() < autocompletedelay
      if getchar(1) isnot# 0
        return ''
      endif
    endwhile
  else
    let timeout = s:const.FUZZYMATCHINTERVAL
    while Completer.clock.elapsed() < autocompletedelay
      if getchar(1) isnot# 0
        return ''
      endif
      if Completer.fuzzycandidatelist != []
        let fuzzyitemlist += Completer.fuzzymatch(base, timeout)
      endif
    endwhile
  endif
  let itemlist += sort(fuzzyitemlist, 's:compare_fuzzyitem')
  if itemlist != []
    call Completer.modify(itemlist)
    call Completer.complete(startcol, itemlist)
  endif

  " fuzzy matching (2nd stage)
  if !fuzzymatch || nbase < 3
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
endfunction
"}}}
function! s:nothingchanged(Completer) abort "{{{
  return a:Completer.last.lnum == line('.') && a:Completer.last.col == col('.') && a:Completer.last.line ==# getline('.')
endfunction
"}}}
function! s:refresh() abort "{{{
  let Event = Verdin#Event#get()
  unlet! b:Verdin
  call Verdin#Completer#get()
  call Verdin#Observer#get()
  let b:Verdin.Event = Event
  call Event.startbufferinspection()
endfunction
"}}}
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
endfunction
"}}}
function! s:redraw(Completer) abort "{{{
  " to show matchparen highlight etc...
  redraw
  " to update cursor
  if a:Completer.is.lazyredraw_changed
    set lazyredraw
    let a:Completer.is.lazyredraw_changed = v:false
  endif
endfunction
"}}}

" vim:set ts=2 sts=2 sw=2 tw=0:
" vim:set foldmethod=marker: commentstring="%s:
