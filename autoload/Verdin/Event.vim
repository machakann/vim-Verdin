" function library specialized for managing autocommands

" script local variables {{{
let s:on = 1
let s:off = 0
"}}}

function! Verdin#Event#get() abort
  if !exists('b:Verdin')
    let b:Verdin = {}
  endif
  if !has_key(b:Verdin, 'Event')
    let b:Verdin.Event = s:Event()
  endif
  return b:Verdin.Event
endfunction

let s:Event = {
      \   'bufferinspection': 0,
      \   'autocomplete': 0,
      \   'CompleteDone': 0,
      \ }
function! s:Event.startbufferinspection() abort "{{{
  if self.bufferinspection is s:on
    return
  endif

  let self.bufferinspection = s:on
  call Verdin#Completer#get()
  call Verdin#Observer#get()
  call s:inspect()
  augroup Verdin-bufferinspection
    autocmd! * <buffer>
    autocmd InsertEnter <buffer> call s:inspect()
    autocmd BufEnter    <buffer> call s:checkglobals()
  augroup END
endfunction
"}}}
function! s:Event.stopbufferinspection() abort "{{{
  let self.bufferinspection = s:off
  augroup Verdin-bufferinspection
    autocmd! * <buffer>
  augroup END
endfunction
"}}}
function! s:Event.setCompleteDone(autocomplete) dict abort "{{{
  let self.CompleteDone = s:on
  if a:autocomplete
    augroup Verdin-aftercomplete
      autocmd! * <buffer>
      autocmd CompleteDone  <buffer> call s:aftercomplete('CompleteDone', 1)
      autocmd InsertCharPre <buffer> call s:aftercomplete('InsertCharPre', 1)
      autocmd InsertLeave   <buffer> call s:aftercomplete('InsertLeave', 1)
      autocmd CursorMovedI  <buffer> call s:aftercomplete('CursorMovedI', 1)
    augroup END
  else
    augroup Verdin-aftercomplete
      autocmd! * <buffer>
      autocmd CompleteDone  <buffer> call s:aftercomplete('CompleteDone', 0)
      autocmd InsertCharPre <buffer> call s:aftercomplete('InsertCharPre', 0)
      autocmd InsertLeave   <buffer> call s:aftercomplete('InsertLeave', 0)
      autocmd CursorMovedI  <buffer> call s:aftercomplete('CursorMovedI', 0)
    augroup END
  endif
endfunction
"}}}
function! s:Event.unsetCompleteDone() dict abort "{{{
  augroup Verdin-aftercomplete
    autocmd! * <buffer>
  augroup END
  let self.CompleteDone = s:off
endfunction
"}}}
function! s:Event.setpersistentCompleteDone(autocomplete) dict abort "{{{
  let self.CompleteDone = s:on
  if a:autocomplete
    augroup Verdin-aftercomplete
      autocmd! * <buffer>
      autocmd CompleteDone  <buffer> call s:aftercomplete('CompleteDone', 1)
    augroup END
  else
    augroup Verdin-aftercomplete
      autocmd! * <buffer>
      autocmd CompleteDone  <buffer> call s:aftercomplete('CompleteDone', 0)
    augroup END
  endif
endfunction
"}}}
function! s:Event.startautocomplete() abort "{{{
  if self.autocomplete is s:on
    return
  endif

  let self.autocomplete = s:on
  augroup Verdin-autocomplete
    autocmd! * <buffer>
    autocmd CursorMovedI <buffer> call Verdin#triggercomplete()
  augroup END
endfunction
"}}}
function! s:Event.stopautocomplete() abort "{{{
  let self.autocomplete = s:off
  augroup Verdin-autocomplete
    autocmd! * <buffer>
  augroup END
endfunction
"}}}
function! s:Event.pauseautocomplete() abort "{{{
  if self.autocomplete is s:off
    return
  endif
  call self.stopautocomplete()
  call self.setCompleteDone(1)
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
  let Event = Verdin#Event#get()
  call Event.unsetCompleteDone()

  let Completer = Verdin#Completer#get()
  call Completer.aftercomplete(a:event, a:autocomplete)
endfunction
"}}}

function! s:Event() abort
  return deepcopy(s:Event)
endfunction

" vim:set ts=2 sts=2 sw=2 tw=0:
" vim:set foldmethod=marker: commentstring="%s:
