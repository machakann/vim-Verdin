" options{{{
let s:PATHSEPARATOR = has('win32') && !&shellslash ? '\' : '/'
let s:default = {}
let s:default.autocomplete = 0
let s:default.autocompletedelay = 200
let s:default.setomnifunc = 1
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
let s:default.autoparen = 0
let s:default.debugmodeon = 0
let s:default.cooperativemode = 0

let g:Verdin#autocomplete      = get(g:, 'Verdin#autocomplete', s:default.autocomplete)
let g:Verdin#autocompletedelay = get(g:, 'Verdin#autocompletedelay', s:default.autocompletedelay)
let g:Verdin#fuzzymatch        = get(g:, 'Verdin#fuzzymatch', s:default.fuzzymatch)
let g:Verdin#loadpath          = get(g:, 'Verdin#loadpath', s:default.loadpath)
let g:Verdin#debugmodeon       = get(g:, 'Verdin#debugmodeon', s:default.debugmodeon)
let g:Verdin#cooperativemode   = get(g:, 'Verdin#cooperativemode', s:default.cooperativemode)
" check 'donotsetomnifunc' for historical reason
let g:Verdin#setomnifunc       =  get(g:, 'Verdin#setomnifunc',
                               \ !get(g:, 'Verdin#donotsetomnifunc',
                               \      !s:default.setomnifunc))
" check 'autobraketinsert' for historical reason
let g:Verdin#autoparen         = get(g:, 'Verdin#autoparen',
                               \ get(g:, 'Verdin#autobraketinsert',
                               \     s:default.autoparen))

let g:Verdin#disable_var_fragment = get(g:, 'Verdin#disable_var_fragment', 0)
let g:Verdin#disable_func_fragment = get(g:, 'Verdin#disable_func_fragment', 0)
"}}}

" The omni-completion function for Vim script
" NOTE: To be used as 'omnifunc'; `:set omnifunc=Verdin#omnifunc`
function! Verdin#omnifunc(findstart, base) abort "{{{
  let cooperativemode = Verdin#_getoption('cooperativemode')
  if cooperativemode
    return Verdin#Verdin#omnifunc_cooperative(a:findstart, a:base)
  endif
  return Verdin#Verdin#omnifunc(a:findstart, a:base)
endfunction "}}}

" Returns a option value of `'g:Verdin#' . a:name`
function! Verdin#_getoption(name) abort "{{{
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
