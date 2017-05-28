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

  if !s:is_started()
    call s:startbufferinspection()
    call s:startautocomplete()
  endif

  let bang = get(a:000, 0, '')
  if bang ==# '!'
    let originalbufnr = bufnr('%')
    for bufinfo in filter(s:lib.getbufinfo(), 'v:val.bufnr != originalbufnr')
      if !has_key(bufinfo.variables, 'Verdin')
        execute 'buffer ' . bufinfo.bufnr
        call s:startbufferinspection()
        call s:startautocomplete()
      endif
    endfor
    execute 'buffer ' . originalbufnr
  endif
endfunction
"}}}
function! Verdin#stopautocomplete(...) abort "{{{
  if s:is_started()
    call s:stopbufferinspection()
    call s:stopautocomple()
  endif

  let bang = get(a:000, 0, '')
  if bang ==# '!'
    let originalbufnr = bufnr('%')
    for bufinfo in filter(s:lib.getbufinfo(), 'v:val.bufnr != originalbufnr')
      if has_key(bufinfo.variables, 'Verdin')
        execute 'buffer ' . bufinfo.bufnr
        call s:stopbufferinspection()
        call s:stopautocomple()
      endif
    endfor
    execute 'buffer ' . originalbufnr
  endif
endfunction
"}}}
function! Verdin#refreshautocomplete(...) abort "{{{
  if s:is_started()
    call s:refresh()
  endif

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
  if s:is_started()
    call s:stopbufferinspection()
    call s:stopautocomple()
    unlet b:Verdin
  endif

  let bang = get(a:000, 0, '')
  if bang ==# '!'
    let originalbufnr = bufnr('%')
    for bufinfo in filter(s:lib.getbufinfo(), 'v:val.bufnr != originalbufnr')
      if has_key(bufinfo.variables, 'Verdin')
        execute 'buffer ' . bufinfo.bufnr
        call s:stopbufferinspection()
        call s:stopautocomple()
        unlet b:Verdin
      endif
    endfor
    execute 'buffer ' . originalbufnr
  endif
endfunction
"}}}
function! Verdin#omnifunc(findstart, base) abort "{{{
  if !s:is_started()
    call s:startbufferinspection()
  endif

  let Completer = Verdin#Completer#get()
  if a:findstart == 1
    " first run
    return Completer.startcol()
  endif

  " second run
  for item in Completer.match(a:base)
    call complete_add(item)
  endfor

  " fuzzy matching
  let n = strchars(a:base)
  if n < 3
    return []
  endif
  call Completer.clock.start()
  while Completer.fuzzycandidatelist != []
    if complete_check()
      break
    endif
    let timeout = Completer.clock.elapsed() + s:const.FUZZYMATCHINTERVAL
    let additionals = Completer.fuzzymatch(a:base, timeout)
    if additionals == []
      continue
    endif
    for item in additional
      call complete_add(item)
    endfor
  endwhile
  return []
endfunction
"}}}
function! Verdin#__startautocomplete__() abort "{{{
  call s:startautocomplete()
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
    while Completer.clock.elapsed() < autocompletedelay
      if getchar(1) isnot# 0
        return ''
      endif
      if Completer.fuzzycandidatelist != []
        let timeout = Completer.clock.elapsed() + s:const.FUZZYMATCHINTERVAL
        let fuzzyitemlist += Completer.fuzzymatch(base, timeout)
      endif
    endwhile
  endif
  let itemlist += sort(fuzzyitemlist, 's:compare_fuzzyitem')
  if itemlist != []
    call Completer.complete(startcol, itemlist)
  endif

  " fuzzy matching (2nd stage)
  if !fuzzymatch || nbase < 3
    return ''
  endif
  while Completer.fuzzycandidatelist != []
    if getchar(1) isnot# 0 || len(itemlist) > s:const.ITEMLISTTHRESHOLD
      break
    endif
    let timeout = Completer.clock.elapsed() + s:const.FUZZYMATCHINTERVAL
    let additional = Completer.fuzzymatch(base, timeout)
    if additional != []
      let itemlist += additional
      call Completer.complete(startcol, itemlist)
    endif
  endwhile
  return ''
endfunction
"}}}
function! s:inspect() abort "{{{
  let Observer = Verdin#Observer#get()
  call Observer.inspect('scope')
  let Completer = Verdin#Completer#get()

  if &filetype ==# 'vim'
    if !has_key(Completer.shelf, 'buffervar')
      call Completer.addDictionary('buffervar', Observer.shelf.buffervar)
      call Completer.addDictionary('bufferfunc', Observer.shelf.bufferfunc)
      call Completer.addDictionary('buffermember', Observer.shelf.buffermember)
      call Completer.addDictionary('bufferkeymap', Observer.shelf.bufferkeymap)
      call Completer.addDictionary('buffercommand', Observer.shelf.buffercommand)
      call Completer.addDictionary('funcfragment', Observer.shelf.funcfragment)
      call Completer.addDictionary('varfragment', Observer.shelf.varfragment)
    endif
  elseif &filetype ==# 'help'
    if !has_key(Completer.shelf, 'buffertag')
      call Completer.addDictionary('buffertag', Observer.shelf.buffertag)
    endif
  endif

  if Observer.changedtick.global == -1
    call s:checkglobals()
  endif
endfunction
"}}}
function! s:checkglobals() abort "{{{
  let Observer = Verdin#Observer#get()
  call Observer.checkglobals()
  let Completer = Verdin#Completer#get()

  if &filetype ==# 'vim'
    if !has_key(Completer.shelf, 'globalvar')
      call Completer.addDictionary('globalvar', Observer.shelf.globalvar)
      call Completer.addDictionary('globalfunc', Observer.shelf.globalfunc)
      call Completer.addDictionary('globalkeymap', Observer.shelf.globalkeymap)
      call Completer.addDictionary('globalcommand', Observer.shelf.globalcommand)
    endif
  elseif &filetype ==# 'help'
    if !has_key(Completer.shelf, 'globaltag')
      call Completer.addDictionary('globalvar', Observer.shelf.globalvar)
      call Completer.addDictionary('globalfunc', Observer.shelf.globalfunc)
      call Completer.addDictionary('globalkeymap', Observer.shelf.globalkeymap)
      call Completer.addDictionary('globalcommand', Observer.shelf.globalcommand)
      call Completer.addDictionary('globaltag', Observer.shelf.globaltag)
    endif
  endif
endfunction
"}}}
function! s:startbufferinspection() abort "{{{
  call Verdin#Completer#get()
  call Verdin#Observer#get()
  call s:inspect()
  augroup Verdin-completion-inspect
    autocmd! * <buffer>
    autocmd InsertEnter <buffer> call s:inspect()
    autocmd BufEnter    <buffer> call s:checkglobals()
  augroup END
endfunction
"}}}
function! s:stopbufferinspection() abort "{{{
  augroup Verdin-completion-inspect
    autocmd! * <buffer>
  augroup END
endfunction
"}}}
function! s:startautocomplete() abort "{{{
  augroup Verdin-completion-auto
    autocmd! * <buffer>
    autocmd CursorMovedI <buffer> call s:triggercomplete()
  augroup END
endfunction
"}}}
function! s:stopautocomplete() abort "{{{
  augroup Verdin-completion-auto
    autocmd! * <buffer>
  augroup END
endfunction
"}}}
function! s:triggercomplete() abort "{{{
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
function! s:nothingchanged(Completer) abort "{{{
  return a:Completer.last.lnum == line('.') && a:Completer.last.col == col('.') && a:Completer.last.line ==# getline('.')
endfunction
"}}}
function! s:refresh() abort "{{{
  unlet! b:Verdin
  call s:inspect()
endfunction
"}}}
function! s:is_started() abort "{{{
  return exists('b:Verdin')
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
