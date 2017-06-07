let s:save_cpo = &cpo
set cpo&vim

let s:giveupifshort = 1
let s:lib = Verdin#lib#distribute()
let s:const = Verdin#constants#distribute()

let s:source = {
      \ 'name' : 'Verdin',
      \ 'kind' : 'manual',
      \ 'filetypes' : {'vim' : 1, 'help' : 1},
      \ 'is_volatile' : 1,
      \ 'rank' : 300,
      \ 'max_candidates': 20,
      \ 'min_pattern_length' : 0,
      \ 'hooks': {},
      \ 'matchers': ['matcher_Verdin'],
      \ 'sorters': [],
      \ 'converters': ['converter_Verdin'],
      \}

function! s:source.hooks.on_init(context) dict abort "{{{
  let originalbufnr = bufnr('%')
  for bufinfo in s:lib.getbufinfo()
    if !has_key(bufinfo.variables, 'Verdin')
      execute 'buffer ' . bufinfo.bufnr
      let Event = Verdin#Event#get()
      call Event.startbufferinspection()
    endif
  endfor
  execute 'buffer ' . originalbufnr
endfunction
"}}}
function! s:source.hooks.on_final(context) dict abort "{{{
  let originalbufnr = bufnr('%')
  for bufinfo in s:lib.getbufinfo()
    if !has_key(bufinfo.variables, 'Verdin')
      execute 'buffer ' . bufinfo.bufnr
      let Event = Verdin#Event#get()
      call Event.stopbufferinspection()
    endif
  endfor
  execute 'buffer ' . originalbufnr
endfunction
"}}}
function! s:source.get_complete_position(context) dict abort "{{{
  let Event = Verdin#Event#get()
  call Event.startbufferinspection()
  let Completer = Verdin#Completer#get()
  return Completer.startcol(s:giveupifshort)
endfunction
"}}}
function! s:source.gather_candidates(context) dict abort "{{{
  let Completer = Verdin#Completer#get()
  let itemlist = []
  call sort(Completer.candidatelist, {a, b -> b.priority - a.priority})
  for candidate in Completer.candidatelist
    let itemlist += candidate.itemlist
  endfor
  let fuzzymatch = s:lib.getoption('fuzzymatch')
  if fuzzymatch && strchars(a:context.complete_str) >= 3
    let itemlist += Completer.fuzzycandidatelist
  endif
  if itemlist != []
    let Event = Verdin#Event#get()
    call Event.setpersistentCompleteDone(0)
  endif
  return map(itemlist, 'type(v:val) == v:t_dict ? v:val : {"word": v:val}')
endfunction
"}}}

function! neocomplete#sources#Verdin#define() abort
  return s:source
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

" vim:set ts=2 sts=2 sw=2 tw=0:
" vim:set foldmethod=marker: commentstring="%s:
