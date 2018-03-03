" function library specialized for managing autocommands

" script local variables {{{
let s:const = Verdin#constants#distribute()
let s:ON  = 1
let s:OFF = 0
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
endfunction "}}}

let s:Event = {
  \   'bufnr': 0,
  \   'bufferinspection': s:OFF,
  \   'autocomplete': s:OFF,
  \   'todolist': [],
  \ }
function! s:Event.bufferinspection_on(...) abort "{{{
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
endfunction "}}}
function! s:Event.bufferinspection_off(...) abort "{{{
  let self.bufferinspection = s:OFF
  augroup Verdin-bufferinspection
    execute printf('autocmd! * <buffer=%d>', self.bufnr)
  augroup END
endfunction "}}}
function! s:Event.autocomplete_on(...) abort "{{{
  if self.autocomplete is s:ON
    return
  endif

  let self.autocomplete = s:ON
  augroup Verdin-autocomplete
    execute printf('autocmd! * <buffer=%d>', self.bufnr)
    execute printf('autocmd CursorMovedI <buffer=%d> call Verdin#Verdin#triggercomplete()', self.bufnr)
    if exists('##TextChangeP')
      execute printf('autocmd TextChangedP <buffer=%d> call Verdin#Verdin#complete()', self.bufnr)
    endif
  augroup END
endfunction "}}}
function! s:Event.autocomplete_off(...) abort "{{{
  let self.autocomplete = s:OFF
  augroup Verdin-autocomplete
    execute printf('autocmd! * <buffer=%d>', self.bufnr)
  augroup END
endfunction "}}}
function! s:Event.aftercomplete_set(Funcref) dict abort "{{{
  call add(self.todolist, a:Funcref)
  augroup Verdin-aftercomplete
    execute printf('autocmd! * <buffer=%d>', self.bufnr)
    execute printf('autocmd CompleteDone  <buffer=%d> call s:aftercomplete("CompleteDone")',  self.bufnr)
    execute printf('autocmd InsertLeave   <buffer=%d> call s:aftercomplete("InsertLeave")',   self.bufnr)
    execute printf('autocmd CursorMovedI  <buffer=%d> call s:aftercomplete("CursorMovedI")',  self.bufnr)
  augroup END
endfunction "}}}
function! s:Event.aftercomplete_setCompleteDone(Funcref) dict abort "{{{
  call add(self.todolist, a:Funcref)
  augroup Verdin-aftercomplete
    execute printf('autocmd! * <buffer=%d>', self.bufnr)
    execute printf('autocmd CompleteDone <buffer=%d> call s:aftercomplete("CompleteDone")', self.bufnr)
  augroup END
endfunction "}}}
function! s:Event.aftercomplete_done(event) abort "{{{
  for F in self.todolist
    call F(a:event)
  endfor
  call filter(self.todolist, 0)
  augroup Verdin-aftercomplete
    execute printf('autocmd! * <buffer=%d>', self.bufnr)
  augroup END
endfunction "}}}
function! s:aftercomplete(event) abort "{{{
  let Completer = Verdin#Completer#get()
  if Completer.is.in_completion
    return
  endif

  let Event = Verdin#Event#get()
  call Event.aftercomplete_done(a:event)
endfunction "}}}

function! s:Event(...) abort
  let Event = deepcopy(s:Event)
  let Event.bufnr = get(a:000, 0, bufnr('%'))
  return Event
endfunction

" vim:set ts=2 sts=2 sw=2 tw=0:
" vim:set foldmethod=marker: commentstring="%s:
