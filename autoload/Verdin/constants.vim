function! Verdin#constants#distribute() abort
  return s:constants
endfunction

let s:VARNAME = '\<\%(\%([ablstw]:\)\?\h\w*\%(\.\h\w*\)*\|g:\h[0-9A-Za-z_#]*\%(\.\h\w*\)*\)(\@!\>'
let s:VARREGEX = join(['\m\C\%(^\|\n\)\s*\%(', join([
      \   printf('\%%(noautocmd\s\+\|silent!\?\s\+\)\?let\s\+\zs%s\ze\s*=', s:VARNAME),
      \   printf('\%%(noautocmd\s\+\|silent!\?\s\+\)\?let\s\+\[\s*\zs\%%(%s,\s*\)*%s\ze\s*\]\s*=', s:VARNAME, s:VARNAME),
      \   printf('for\s\+\zs%s\ze\s\+in', s:VARNAME),
      \   printf('for\s\+\[\s*\zs\%%(%s,\s*\)*%s\ze\s*\]\s\+in', s:VARNAME, s:VARNAME),
      \ ], '\|'), '\)'], '')
let s:GLOBALVARNAME = '\<\%([bstw]:\h\w*\|g:\h[0-9A-Za-z_#]*\)\%(\.\h\w*\)*(\@!\>'
let s:LOCALVARNAME = '\<\%(l:\)\?\h\w*\%(\.\h\w*\)*(\@!\>'
let s:LOCALVARREGEX = join(['\m\C\%(^\|\n\)\s*\%(', join([
      \   printf('\%%(noautocmd\s\+\|silent!\?\s\+\)\?let\s\+\zs%s\ze\%%(\s*\|\_s\+\\\s*\)=', s:LOCALVARNAME),
      \   printf('\%%(noautocmd\s\+\|silent!\?\s\+\)\?let\s\+\[\s*\zs\%%(%s,\s*\)*%s\ze\s*\]\%%(\s*\|\_s\+\\\s*\)=', s:LOCALVARNAME, s:LOCALVARNAME),
      \   printf('for\s\+\zs%s\ze\s\+in', s:LOCALVARNAME),
      \   printf('for\s\+\[\s*\zs\%%(%s,\s*\)*%s\ze\s*\]\s\+in', s:LOCALVARNAME, s:LOCALVARNAME),
      \ ], '\|'), '\)'], '')
let s:FUNCNAME = '\%(s:\h\w*\|\%(g:\)\?[A-Z]\w*\|\h[0-9A-Za-z_#]*\)'
let s:FUNCREGEX = printf('\m\C^fu\%%[nction]!\?\s\+\zs%s\ze(', s:FUNCNAME)
let s:FUNCBODYREGEX = printf('\m\C^fu\%%[nction]!\?\s\+\zs%s([^)]*)', s:FUNCNAME)
let s:FUNCDEFINITIONREGEX = printf('\m\C\%%(^\|\n\)\s*\zsfu\%%[nction]!\?\s\+%s([^)]*)', s:FUNCNAME)
let s:KEYREGEX = '\m[{,]\%(\_s*\\\)\?\s*\%(''\zs\h\w*\ze''\|\"\zs\h\w*\ze\"\)\s*:'
let s:HASKEYREGEX = printf('\<has_key(\s*%s\s*, \%%(''\zs\h\w*\ze''\|\"\zs\h\w*\ze\"\))', s:VARNAME)
let s:METHODREGEX = printf('\m\C\%%(^\|\n\)\s*fu\%%[nction!]\s\+%s\.\zs\%(\h\w*\.\)*\h\w*([^)]*)', s:VARNAME)
let s:KEYMAPREGEX = printf('\m\C\%%(^\|\n\)\s*\%%([nvxsoilc]\?\%%(m\%%[ap]\|nor\%%[emap]\)\|map!\)\s\+\%%(%s\)*\s*\zs\%%(%s\)\S\+',
      \   join(['<buffer>', '<nowait>', '<silent>', '<special>', '<script>', '<expr>', '<unique>',], '\|'),
      \   join(['<Plug>', '<SID>'], '\|'),
      \ )
let s:ARGNAME = '\<a:\h\w*\%(\.\h\w*\)*\>'
let s:ARGREGEX = printf('\m\C\%%(^\|\n\)\s*fu\%%[nction]!\?\s\+\%%(%s\|%s\%%(\.\h\w*\)*\)(\s*\zs\%%(\h\w*\%%(,\s*\h\w*\)*\%%(,\s*\.\{3}\)\?\|\s*\.\{3}\)\ze\s*)', s:FUNCNAME, s:VARNAME)
let s:COMMANDREGEX = '\m\C\%(^\|\n\)\s*com\%[mand]!\?\s\+\%(\%(-nargs=[01*?+]\|-complete=\S\+\|-range\%(=\%(%\|\d\+\)\)\?\|-count=\d\+\|-addr=\w\+\|-bang\|-bar\|-registers\|-buffer\)\s\+\)*\zs\w\+\>'
let s:HIGROUPREGEX = '\m\C\%(^\|\n\)\s*hi\%[ghlight]!\?\s\+\%(default\s\+\)\?\%(link\s\+\)\?\zs\h\w*'
let s:SNAKECASEWORDREGEX = '\m\C\(\h\)[0-9A-Za-z]*' . repeat('\%([_#\-]\+\(\h\)[0-9A-Za-z]*\)\?', 8)
let s:CAMELCASEWORDREGEX = '\m\C\(\u\)\u*[0-9a-z]\+' . repeat('\%(\(\u\)\u*[0-9a-z]\+\)\?', 8)
let s:HELPTAGREGEX = '\m\*\zs[^*]\+\ze\*'

let s:constants = {}
let s:constants.PATHSEPARATOR = has('win32') && !&shellslash ? '\' : '/'
let s:constants.LONGESTWORDLEN = 100
let s:constants.SEARCHTIMEOUT = 100
let s:constants.SEARCHINTERVAL = 50
let s:constants.ITEMLISTTHRESHOLD = 20
let s:constants.FUZZYMATCHINTERVAL = 5.0
let s:constants.FUZZYMATCHTHRESHOLD = 0.88
let s:constants.DOCPATHSMAX = 20
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
let s:constants.KEYREGEX = s:KEYREGEX
let s:constants.HASKEYREGEX = s:HASKEYREGEX
let s:constants.METHODREGEX = s:METHODREGEX
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
