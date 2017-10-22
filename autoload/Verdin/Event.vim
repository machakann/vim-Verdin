" function library specialized for managing autocommands

" script local variables {{{
let s:const = Verdin#constants#distribute()
let s:ON = 1
let s:OFF = 0
let s:PAUSE = -1
"}}}

function! Verdin#Event#get(...) abort "{{{
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
"}}}

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
  call Verdin#Observer#inspect(self.bufnr)
  augroup Verdin-bufferinspection
    execute printf('autocmd! * <buffer=%d>', self.bufnr)
    execute printf('autocmd InsertEnter  <buffer=%d> call Verdin#Observer#inspect(%d)', self.bufnr, self.bufnr)
    execute printf('autocmd BufWritePost <buffer=%d> call Verdin#Observer#inspect(%d, %d)', self.bufnr, self.bufnr, s:const.SCANTIMEOUTLONG)
    execute printf('autocmd BufEnter     <buffer=%d> call Verdin#Observer#checkglobals(%d)', self.bufnr, self.bufnr)
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
  if self.CompleteDone is s:ON
    call s:aftercomplete('', 1)
  endif

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

  let self.autocomplete = s:PAUSE
  augroup Verdin-autocomplete
    execute printf('autocmd! * <buffer=%d>', self.bufnr)
  augroup END
  call self.setCompleteDone(1)
endfunction
"}}}
function! s:Event.resumeautocomplete() dict abort "{{{
  if self.autocomplete isnot s:PAUSE
    return
  endif

  call self.startautocomplete()
endfunction
"}}}
function! s:aftercomplete(event, autocomplete) abort "{{{
  let Completer = Verdin#Completer#get()
  let success = Completer.aftercomplete(a:event, a:autocomplete)
  if success
    let Event = Verdin#Event#get()
    call Event.resumeautocomplete()
    call Event.unsetCompleteDone()
  endif
endfunction
"}}}

function! s:Event(...) abort
  let Event = deepcopy(s:Event)
  let Event.bufnr = get(a:000, 0, bufnr('%'))
  return Event
endfunction

" vim:set ts=2 sts=2 sw=2 tw=0:
" vim:set foldmethod=marker: commentstring="%s:
