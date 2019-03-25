" function library specialized for managing autocommands

" script ID {{{
function! s:SID() abort
  return matchstr(expand('<sfile>'), '<SNR>\zs\d\+\ze_SID$')
endfunction
let s:SID = printf("\<SNR>%s_", s:SID())
delfunction s:SID
"}}}

" script local variables {{{
let s:const = Verdin#constants#distribute()
let s:lib = Verdin#lib#distribute()
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

function! s:Event(...) abort
  let Event = deepcopy(s:Event)
  let Event.bufnr = get(a:000, 0, bufnr('%'))
  return Event
endfunction

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
    execute printf('autocmd InsertEnter  <buffer=%d> call Verdin#Observer#debounce(%d)', self.bufnr, self.bufnr)
    execute printf('autocmd InsertLeave  <buffer=%d> call Verdin#Observer#cancel_debounce()', self.bufnr)
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
    execute printf('autocmd CursorMovedI <buffer=%d> call Verdin#Verdin#debounce()', self.bufnr)
    if exists('##TextChangedP')
      execute printf('autocmd TextChangedP <buffer=%d> call Verdin#Verdin#trigger(line("."), col("."))', self.bufnr)
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

function! s:Event.autoparen_set() abort "{{{
  augroup Verdin-autoparen
    execute printf('autocmd! * <buffer=%d>', self.bufnr)
    if g:Verdin#autoparen == 2
      execute printf('autocmd CompleteDone <buffer=%d> call s:autoparenclose(%d)', self.bufnr, self.bufnr)
    endif
  augroup END
endfunction "}}}


function! s:aftercomplete(event) abort "{{{
  let Completer = Verdin#Completer#get()
  if Completer.is.in_completion
    return
  endif

  let Event = Verdin#Event#get()
  for l:F in Event.todolist
    call l:F(a:event)
  endfor
  call filter(Event.todolist, 0)
  augroup Verdin-aftercomplete
    execute printf('autocmd! * <buffer=%d>', Event.bufnr)
  augroup END
endfunction "}}}

function! s:autoparenclose(bufnr) abort "{{{
  if empty(v:completed_item)
    return
  endif

  augroup Verdin-autoparen
    execute printf('autocmd! * <buffer=%d>', a:bufnr)
  augroup END

  let user_data = get(v:completed_item, 'user_data', '')
  if user_data is# ''
    return
  endif

  try
    let dict = json_decode(user_data)
  catch
    return
  endtry

  if !has_key(dict, 'Verdin')
    return
  endif

  let autoparen = get(dict['Verdin'], 'autoparen', 0)
  if autoparen != 2
    return
  endif

  call feedkeys(s:CloseParen, 'im')
endfunction

let s:CloseParen = s:SID . '(CloseParen)'
inoremap <silent> <SID>(CloseParen) <C-r>=<SID>CloseParen('i')<CR>
cnoremap <silent> <SID>(CloseParen) <Nop>
nnoremap <silent><expr> <SID>(CloseParen) <SID>CloseParen('n')
function! s:CloseParen(mode) abort
  let Completer = Verdin#Completer#get()
  if Completer.last.postcursor[0] ==# '('
    return ''
  endif
  let lnum = Completer.last.lnum
  let startcol = Completer.last.startcol+1
  let funcname = s:lib.escape(v:completed_item.word)
  let postcursor = s:lib.escape(Completer.last.postcursor)
  if a:mode ==# 'i'
    let pat = printf('\m\%%%dl\%%%dc%s.*\%%#%s$',
                    \lnum, startcol, funcname, postcursor)
    let keyseq = ")\<C-g>U\<Left>"
  elseif a:mode ==# 'n'
    let pat = printf('\m\%%%dl\%%%dc%s\%%#(%s$',
                    \lnum, startcol, funcname[:-2], postcursor)
    let keyseq = "a)\<Esc>"
  endif
  if search(pat, 'bcn', Completer.last.lnum)
    return keyseq
  endif
  return ''
endfunction
"}}}

" vim:set ts=2 sts=2 sw=2 tw=0:
" vim:set foldmethod=marker: commentstring="%s:
