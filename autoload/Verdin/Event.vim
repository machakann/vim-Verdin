" function library specialized for managing autocommands

" script local variables {{{
let s:on = 1
let s:off = 0
let s:pause = -1
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
      \ }
function! s:Event.startbufferinspection() abort "{{{
  if self.bufferinspection is s:on
    return
  endif

  let self.bufferinspection = s:on
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
function! s:Event.stopbufferinspection() abort "{{{
  let self.bufferinspection = s:off
  augroup Verdin-completion-inspect
    autocmd! * <buffer>
  augroup END
endfunction
"}}}
function! s:Event.startautocomplete() abort "{{{
  if self.autocomplete is s:on
    return
  endif

  let self.autocomplete = s:on
  augroup Verdin-completion-auto
    autocmd! * <buffer>
    autocmd CursorMovedI <buffer> call Verdin#triggercomplete()
  augroup END
endfunction
"}}}
function! s:Event.stopautocomplete() abort "{{{
  let self.autocomplete = s:off
  augroup Verdin-completion-auto
    autocmd! * <buffer>
  augroup END
endfunction
"}}}
function! s:Event.pauseautocomplete() abort "{{{
  if self.autocomplete is s:off
    return
  endif

  let self.autocomplete = s:pause
  augroup Verdin-completion-auto
    autocmd! * <buffer>
    autocmd CompleteDone  <buffer> call s:aftercomplete('CompleteDone')
    autocmd InsertCharPre <buffer> call s:aftercomplete('InsertCharPre')
    autocmd InsertLeave   <buffer> call s:aftercomplete('InsertLeave')
    autocmd CursorMovedI  <buffer> call s:aftercomplete('CursorMovedI')
  augroup END
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
function! s:aftercomplete(event) abort "{{{
  if a:event ==# 'InsertCharPre' && pumvisible()
    " refresh popup always
    call feedkeys("\<C-e>", 'in')
  endif

  let Completer = Verdin#Completer#get()
  call Completer.aftercomplete(a:event)
endfunction
"}}}

function! s:Event() abort
  return deepcopy(s:Event)
endfunction

" vim:set ts=2 sts=2 sw=2 tw=0:
" vim:set foldmethod=marker: commentstring="%s:
