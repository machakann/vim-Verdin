function! Verdin#constants#distribute() abort
  return s:constants
endfunction

let s:VARNAME = '\<\%(\%([ablstw]:\)\?\h\w*\%(\.\h\w*\)*\|g:\h[0-9A-Za-z_#]*\%(\.\h\w*\)*\)\>'
let s:VARREGEX = join(['\m\C\%(', join([
      \   printf('^\s*let\s\+\zs%s\ze\s*=', s:VARNAME),
      \   printf('^\s*let\s\+\[\s*\zs\%(%s,\s*\)*%s\ze\s*\]\s*=', s:VARNAME, s:VARNAME),
      \   printf('^\s*for\s\+\zs%s\ze\s\+in', s:VARNAME),
      \   printf('^\s*for\s\+\[\s*\zs\%(%s,\s*\)*%s\ze\s*\]\s\+in', s:VARNAME, s:VARNAME),
      \ ], '\|'), '\)'], '')
let s:GLOBALVARNAME = '\<\%([bstw]:\h\w*\|g:\h[0-9A-Za-z_#]*\)\%(\%(\.\h\w*\)\+\|(\@!\)\>'
let s:LOCALVARNAME = '\<\%(l:\)\?\h\w*\%(\.\h\w*\)*\>'
let s:LOCALVARREGEX = join(['\m\C\%(', join([
      \   printf('^\s*let\s\+\zs%s\ze\%(\s*\|\_s\+\\\s*\)=', s:LOCALVARNAME),
      \   printf('^\s*let\s\+\[\s*\zs\%(%s,\s*\)*%s\ze\s*\]\%(\s*\|\_s\+\\\s*\)=', s:LOCALVARNAME, s:LOCALVARNAME),
      \   printf('^\s*for\s\+\zs%s\ze\s\+in', s:LOCALVARNAME),
      \   printf('^\s*for\s\+\[\s*\zs\%(%s,\s*\)*%s\ze\s*\]\s\+in', s:LOCALVARNAME, s:LOCALVARNAME),
      \ ], '\|'), '\)'], '')
let s:FUNCNAME = '\%(s:\h\w*\|\%(g:\)\?[A-Z]\w*\|\h[0-9A-Za-z_#]*\)'
let s:FUNCREGEX = printf('\m\C^\s*fu\%%[nction]!\?\s\+\zs%s\ze(', s:FUNCNAME)
let s:FUNCBODYREGEX = printf('\m\C^\s*fu\%%[nction]!\?\s\+\zs%s([^)]*)', s:FUNCNAME)
let s:FUNCDEFINITIONREGEX = printf('\m\C^\s*fu\%%[nction]!\?\s\+%s([^)]*)', s:FUNCNAME)
let s:KEYREGEX1 = '\m[{,]\s*\%(\_s*\\\s*\)\%(''\zs\%(.\{-}\%(''''\)*\)*\ze''\|\"\zs\%(.\{-}\%(\\"\)*\)*\ze\"\)'
let s:KEYREGEX2 = '\m\%(''\zs\%(.\{-}\%(''''\)*\)*\ze''\|\"\zs\%(.\{-}\%(\\"\)*\)*\ze\"\)'
let s:MEMBERFUNCREGEX = printf('\m\C^\s*fu\%%[nction!]\s\+%s\.\zs\%(\h\w*\.\)*\h\w*\ze(', s:VARNAME)
let s:KEYMAPREGEX = printf('\m\C^\s*\%%([nvxsoilc]\?\%%(m\%%[ap]\|nor\%%[emap]\)\|map!\)\s\+\%%(%s\)*\s*\zs\%%(%s\)\S\+',
      \   join(['<buffer>', '<nowait>', '<silent>', '<special>', '<script>', '<expr>', '<unique>',], '\|'),
      \   join(['<Plug>', '<SID>'], '\|'),
      \ )
let s:ARGNAME = '\<a:\h\w*\%(\.\h\w*\)*\>'
let s:ARGREGEX = printf('\m\C^\s*fu\%%[nction]!\?\s\+\%(%s\|%s\%%(\.\h\w*\)*\)(\s*\zs\%%(\h\w*\%%(,\s*\h\w*\)*\%(,\s*\.\{3}\)\?\|\s*\.\{3}\)\ze\s*)', s:FUNCNAME, s:VARNAME)
let s:COMMANDREGEX = '\m\C^\s*com\%[mand]!\?\s\+\%(\%(-nargs=[01*?+]\|-complete=\S\+\|-range\%(=\%(%\|\d\+\)\)\?\|-count=\d\+\|-addr=\w\+\|-bang\|-bar\|-registers\|-buffer\)\s\+\)*\zs\w\+\>'
let s:HIGROUPREGEX = '\m\C^\s*hi\%[ghlight]!\?\s\+\%(default\s\+\)\?\%(link\s\+\)\zs\h\w*'
let s:SNAKECASEWORDREGEX = '\m\C\(\h\)[0-9A-Za-z]*' . repeat('\%([_#\-]\+\(\h\)[0-9A-Za-z]*\)\?', 8)
let s:CAMELCASEWORDREGEX = '\m\C\(\u\)\u*[0-9a-z]\+' . repeat('\%(\(\u\)\u*[0-9a-z]\+\)\?', 8)
let s:HELPTAGREGEX = '\m\*\zs[^*]\+\ze\*'

let s:constants = {}
let s:constants.PATHSEPARATOR = has('win32') && !&shellslash ? '\' : '/'
let s:constants.LONGESTWORDLEN = 100
let s:constants.SEARCHTIMEOUT = 300
let s:constants.ITEMLISTTHRESHOLD = 20
let s:constants.FUZZYMATCHINTERVAL = 5.0
let s:constants.FUZZYMATCHTHRESHOLD = 0.88
let s:constants.VARNAME = '\m\C' . s:VARNAME
let s:constants.VARREGEX = s:VARREGEX
let s:constants.GLOBALVARNAME = '\m\C' . s:GLOBALVARNAME
let s:constants.GLOBALVARREGEX = '\m\C' . s:GLOBALVARNAME
let s:constants.LOCALVARNAME = '\m\C' . s:LOCALVARNAME
let s:constants.LOCALVARREGEX = s:LOCALVARREGEX
let s:constants.FUNCNAME = '\m\C' . s:FUNCNAME
let s:constants.FUNCREGEX = s:FUNCREGEX
let s:constants.FUNCBODYREGEX = s:FUNCBODYREGEX
let s:constants.FUNCDEFINITIONREGEX = s:FUNCDEFINITIONREGEX
let s:constants.KEYREGEX1 = s:KEYREGEX1
let s:constants.KEYREGEX2 = s:KEYREGEX2
let s:constants.MEMBERFUNCREGEX = s:MEMBERFUNCREGEX
let s:constants.KEYMAPREGEX = s:KEYMAPREGEX
let s:constants.ARGNAME = '\m\C' . s:ARGNAME
let s:constants.ARGREGEX = s:ARGREGEX
let s:constants.COMMANDREGEX = s:COMMANDREGEX
let s:constants.HIGROUPREGEX = s:HIGROUPREGEX
let s:constants.SNAKECASEWORDREGEX = s:SNAKECASEWORDREGEX
let s:constants.CAMELCASEWORDREGEX = s:CAMELCASEWORDREGEX
let s:constants.HELPTAGREGEX = s:HELPTAGREGEX
let s:constants.option = {}
let s:constants.option.default = {}
let s:constants.option.default.autocomplete = 0
let s:constants.option.default.autocompletedelay = 100
let s:constants.option.default.donotsetomnifunc = 0
let s:constants.option.default.fuzzymatch = 0
let s:constants.option.default.autobraketinsert = 0
let s:constants.option.default.debugmodeon = 0
lockvar! s:constants

" vim:set ts=2 sts=2 sw=2 tw=0:
" vim:set foldmethod=marker: commentstring="%s:
