" options{{{
let s:PATHSEPARATOR = has('win32') && !&shellslash ? '\' : '/'
let s:default = {}
let s:default.autocomplete = 0
let s:default.autocompletedelay = 200
let s:default.donotsetomnifunc = 0
let s:default.fuzzymatch = 1
let s:default.loadpath = [
      \   '*.vim',
      \   join(['autoload', '*.vim'], s:PATHSEPARATOR),
      \   join(['autoload', '**', '*.vim'], s:PATHSEPARATOR),
      \   join(['plugin', '*.vim'], s:PATHSEPARATOR),
      \   join(['plugin', '**', '*.vim'], s:PATHSEPARATOR),
      \   join(['ftplugin', '*.vim'], s:PATHSEPARATOR),
      \   join(['ftplugin', '**', '*.vim'], s:PATHSEPARATOR),
      \ ]
let s:default.autobraketinsert = 0
let s:default.debugmodeon = 0

let g:Verdin#autocomplete = get(g:, 'Verdin#autocomplete', s:default.autocomplete)
let g:Verdin#autocompletedelay = get(g:, 'Verdin#autocompletedelay', s:default.autocompletedelay)
let g:Verdin#donotsetomnifunc = get(g:, 'Verdin#donotsetomnifunc', s:default.donotsetomnifunc)
let g:Verdin#fuzzymatch = get(g:, 'Verdin#fuzzymatch', s:default.fuzzymatch)
let g:Verdin#loadpath = get(g:, 'Verdin#loadpath', s:default.loadpath)
let g:Verdin#autobraketinsert = get(g:, 'Verdin#autobraketinsert', s:default.autobraketinsert)
let g:Verdin#debugmodeon = get(g:, 'Verdin#debugmodeon', s:default.debugmodeon)
"}}}

function! Verdin#omnifunc(findstart, base) abort "{{{
  return Verdin#Verdin#omnifunc(a:findstart, a:base)
endfunction "}}}
function! Verdin#getoption(name) abort "{{{
  if exists('b:Verdin_' . a:name)
    return b:['Verdin_' . a:name]
  endif
  if exists('g:Verdin#' . a:name)
    return g:['Verdin#' . a:name]
  endif
  return s:default[a:name]
endfunction "}}}

" vim:set ts=2 sts=2 sw=2 tw=0:
" vim:set foldmethod=marker: commentstring="%s:
