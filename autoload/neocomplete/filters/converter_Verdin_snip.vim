let s:converter = {
      \   'name': 'converter_Verdin_snip',
      \ }
function! s:converter.filter(context) dict abort "{{{
  let Completer = Verdin#Completer#get()
  return Completer.modify(a:context.candidates, 'snip')
endfunction "}}}

function! neocomplete#filters#converter_Verdin_snip#define() abort
  return s:converter
endfunction

" vim:set ts=2 sts=2 sw=2 tw=0:
" vim:set foldmethod=marker: commentstring="%s:
