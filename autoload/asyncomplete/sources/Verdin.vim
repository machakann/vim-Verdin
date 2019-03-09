function! asyncomplete#sources#Verdin#get_source_options(opt) abort "{{{
  return a:opt
endfunction "}}}


function! asyncomplete#sources#Verdin#completor(opt, ctx) abort
  let typed = a:ctx['typed']
  let startcol = Verdin#Verdin#omnifunc_cooperative(1, '')
  if startcol < 0
    return
  endif

  let cursorcol = col('.')
  let base = cursorcol == 1 ? '' : getline('.')[startcol : cursorcol-2]
  if base is# ''
    return
  endif

  let candidates = Verdin#Verdin#omnifunc_cooperative(0, base)
  if empty(candidates)
    return
  endif

  call asyncomplete#complete(a:opt['name'], a:ctx, startcol + 1, candidates)
endfunction

" vim:set ts=2 sts=2 sw=2 tw=0:
" vim:set foldmethod=marker: commentstring="%s:
