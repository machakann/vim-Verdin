" function library specialized for managing autocommands

" script local variables {{{
let s:ON = 1
let s:OFF = 0
"}}}

function! Verdin#Event#get(...) abort
  let bufnr = get(a:000, 0, bufnr('%'))
  let bufinfo = get(getbufinfo(bufnr), 0, {})
  if bufinfo == {}
    echoerr 'Verdin: Invalid bufnr is given for Verdin#Event#get()'
  endif

  if !has_key(bufinfo.variables, 'Verdin')
    let bufinfo.variables.Verdin = {}
  endif
  if !has_key(bufinfo.variables.Verdin, 'Event')
    let bufinfo.variables.Verdin.Event = s:Event()
  endif
  return bufinfo.variables.Verdin.Event
endfunction

let s:Event = {
      \   'bufnr': 0,
      \   'bufferinspection': 0,
      \   'autocomplete': 0,
      \   'CompleteDone': 0,
      \ }
function! s:Event.startbufferinspection() abort "{{{
  if self.bufferinspection is s:ON
    return
  endif

  let self.bufferinspection = s:ON
  call Verdin#Completer#get(self.bufnr)
  call Verdin#Observer#get(self.bufnr)
  call s:inspect()
  augroup Verdin-bufferinspection
    execute printf('autocmd! * <buffer=%d>', self.bufnr)
    execute printf('autocmd InsertEnter <buffer=%d> call s:inspect()', self.bufnr)
    execute printf('autocmd BufEnter    <buffer=%d> call s:checkglobals()', self.bufnr)
  augroup END
endfunction
"}}}
function! s:Event.stopbufferinspection() abort "{{{
  let self.bufferinspection = s:OFF
  augroup Verdin-bufferinspection
    execute printf('autocmd! * <buffer=%d>', self.bufnr)
  augroup END
endfunction
"}}}
function! s:Event.setCompleteDone(autocomplete) dict abort "{{{
  let self.CompleteDone = s:ON
  augroup Verdin-aftercomplete
    execute printf('autocmd! * <buffer=%d>', self.bufnr)
    execute printf('autocmd CompleteDone  <buffer=%d> call s:aftercomplete("CompleteDone",  %d)', self.bufnr, a:autocomplete)
    execute printf('autocmd InsertCharPre <buffer=%d> call s:aftercomplete("InsertCharPre", %d)', self.bufnr, a:autocomplete)
    execute printf('autocmd InsertLeave   <buffer=%d> call s:aftercomplete("InsertLeave",   %d)', self.bufnr, a:autocomplete)
    execute printf('autocmd CursorMovedI  <buffer=%d> call s:aftercomplete("CursorMovedI",  %d)', self.bufnr, a:autocomplete)
  augroup END
endfunction
"}}}
function! s:Event.unsetCompleteDone() dict abort "{{{
  augroup Verdin-aftercomplete
    execute printf('autocmd! * <buffer=%d>', self.bufnr)
  augroup END
  let self.CompleteDone = s:OFF
endfunction
"}}}
function! s:Event.setpersistentCompleteDone(autocomplete) dict abort "{{{
  let self.CompleteDone = s:ON
  augroup Verdin-aftercomplete
    execute printf('autocmd! * <buffer=%d>', self.bufnr)
    execute printf('autocmd CompleteDone <buffer=%d> call s:aftercomplete("CompleteDone", %d)', self.bufnr, a:autocomplete)
  augroup END
endfunction
"}}}
function! s:Event.startautocomplete() abort "{{{
  if self.autocomplete is s:ON
    return
  endif

  let self.autocomplete = s:ON
  augroup Verdin-autocomplete
    execute printf('autocmd! * <buffer=%d>', self.bufnr)
    execute printf('autocmd CursorMovedI <buffer=%d> call Verdin#Verdin#triggercomplete()', self.bufnr)
  augroup END
endfunction
"}}}
function! s:Event.stopautocomplete() abort "{{{
  let self.autocomplete = s:OFF
  augroup Verdin-autocomplete
    execute printf('autocmd! * <buffer=%d>', self.bufnr)
  augroup END
endfunction
"}}}
function! s:Event.pauseautocomplete() abort "{{{
  if self.autocomplete is s:OFF
    return
  endif
  call self.stopautocomplete()
  call self.setCompleteDone(1)
endfunction
"}}}
function! s:inspect() abort "{{{
  let Observer = Verdin#Observer#get()
  if Observer.changedtick == -1
    call s:checkglobals()
  endif

  call Observer.inspect()
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
      call Completer.addDictionary('globalmember', Observer.shelf.globalmember)
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
function! s:aftercomplete(event, autocomplete) abort "{{{
  let Completer = Verdin#Completer#get()
  call Completer.aftercomplete(a:event, a:autocomplete)
endfunction
"}}}

function! s:Event(...) abort
  let Event = deepcopy(s:Event)
  let Event.bufnr = get(a:000, 0, bufnr('%'))
  return Event
endfunction

" vim:set ts=2 sts=2 sw=2 tw=0:
" vim:set foldmethod=marker: commentstring="%s:
