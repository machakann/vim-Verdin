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
let s:KEYREGEX = join(['\m\C\%(', join([
      \   '[{,]\%(\_s*\\\)\?\s*\%(''\zs\h\w*\ze''\|\"\zs\h\w*\ze\"\)\s*:',
      \   printf('\<has_key(\s*%s\s*, \%%(''\zs\h\w*\ze''\|\"\zs\h\w*\ze\"\))', s:VARNAME),
      \   '\%([abglstw]:\)\?\h\w*\zs\%(\.\h\w*\)\+(\?',
      \ ], '\|'), '\)'], '')
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
let s:CAMELCASEWORDREGEX = '\m\C\(\h\)[0-9a-z]\+' . repeat('\%(\(\u\)\u*[0-9a-z]\+\)\?', 8)
let s:HELPTAGREGEX = '\m\*\zs[^*[:space:]]\+\ze\*'

let s:constants = {}
" control constants
let s:constants.PATHSEPARATOR = has('win32') && !&shellslash ? '\' : '/'
let s:constants.LONGESTWORDLEN = 100
let s:constants.SCANTIMEOUT = 100
let s:constants.SCANTIMEOUTLONG = 500
let s:constants.SEARCHINTERVAL = 50
let s:constants.ITEMLISTTHRESHOLD = 20
let s:constants.FUZZYMATCHINTERVAL = 5.0
let s:constants.FUZZYMATCHTHRESHOLD = 0.88
let s:constants.DOCPATHSMAX = 20
let s:constants.DEFAULTORDERVIM = ['var', 'func', 'keymap', 'command', 'higroup']
let s:constants.DEFAULTORDERHELP = ['tag']
" regular expressions
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
let s:constants.METHODREGEX = s:METHODREGEX
let s:constants.KEYMAPREGEX = s:KEYMAPREGEX
let s:constants.ARGNAME = '\m\C' . s:ARGNAME
let s:constants.ARGREGEX = s:ARGREGEX
let s:constants.COMMANDREGEX = s:COMMANDREGEX
let s:constants.HIGROUPREGEX = s:HIGROUPREGEX
let s:constants.SNAKECASEWORDREGEX = s:SNAKECASEWORDREGEX
let s:constants.CAMELCASEWORDREGEX = s:CAMELCASEWORDREGEX
let s:constants.HELPTAGREGEX = s:HELPTAGREGEX
" constants for Dictionary
let s:constants.COMMANDCONDITIONLIST = [
      \   {'cursor_at': '\m\C\%(^\s*\|[^|]|\s\+\)\%(\%(sil\%[ent!]\|noa\%[utocmd]\|undoj\%[oin]\|vert\%[ical]\|lefta\%[bove]\|abo\%[veleft]\|rightb\%[elow]\|bel\%[owright]\|to\%[pleft]\|bo\%[tright]\)\s\+\)*\zs\%(!!\?\|@@\?\|[#&<>=]\|\a\w*\)\?\%#', 'priority': 256},
      \   {'cursor_at': '\m\C\%(^\s*\|[^|]|\s\+\)au\%[tocmd]\s\+\%(\S\+\s\+\)\{2,3}\%(nested\s\+\)\?:\?\zs\%(!!\?\|@@\?\|[#&<>=]\|\a\w*\)\?\%#', 'priority': 256},
      \   {'cursor_at': '\m\C\%(^\s*\|[^|]|\s\+\)com\%[mand!]\s\+\%(\%(-nargs=[01*?+]\|-complete=\h\w*\%(,\S\+\)\?\|-range\%(=[%[:digit:]]\)\?\|-count=\d\+\|-addr=\h\w*\|-bang\|-bar\|-register\|-buffer\)\s\+\)*[A-Z]\w*\s\+:\?\zs\%(!!\?\|@@\?\|[#&<>=]\|\a\w*\)\?\%#', 'priority': 256},
      \   {'cursor_at': '\m\C\<exists([''"]:\zs\%(!!\?\|@@\?\|[#&<>=]\|\a\w*\)\?\%#', 'priority': 256},
      \   {'cursor_at': '\m\C^\s*\%([nvxsoilc]\?\%(m\%[ap]\|no\%[remap]\)\|map!\|no\%[remap]!\)\s\+\%(<\%(buffer\|nowait\|silent\|special\|script\|unique\)>\s*\)*\S\+\s\+:\zs\%(!!\?\|@@\?\|[#&<>=]\|\a\w*\)\?\%#', 'priority': 256},
      \   {'cursor_at': '\m^\%(\%([^"]*"[^"]*"\)*[^"]*"[^"]*\|\%([^'']*''[^'']*''\)*[^'']*''[^'']*\)\zs\<\a\w\{5,}\%#', 'in_comment': 1, 'priority': 0},
      \   {'cursor_at': '\m^\%(\%([^"]*"[^"]*"\)*[^"]*"[^"]*\|\%([^'']*''[^'']*''\)*[^'']*''[^'']*\)\zs\<\a\w\{5,}\%#', 'in_string': 1, 'priority': 0},
      \ ]
let s:constants.FUNCCONDITIONLIST = [
      \   {'cursor_at': '\m\C\<call\s\+\zs\<\%([gs]:\)\?\k*\%#', 'not_in_string': 1, 'not_in_comment': 1, 'priority': 384},
      \   {'cursor_at': '\m\C\<call\s\+.*\zs\<\%([gs]:\)\?\k*\%#', 'not_in_string': 1, 'not_in_comment': 1, 'priority': 128},
      \   {'cursor_at': '\m\C<[Cc]-[Rr]>=\zs\%([gs]:\|\%([gs]:\)\?\h\k*\)\?\%#', 'priority': 256},
      \   {'cursor_at': '\m\C\<\%(call([''"]\|exists([''"]\*\)\zs\<\%([gs]:\|\%([gs]:\)\?\h\k*\)\?\%#', 'priority': 256},
      \   {'cursor_at': '\m\C^\s*\%([nvxsoilc]\?\%(m\%[ap]\|no\%[remap]\)\|map!\|no\%[remap]!\)\s\+\%(<\%(buffer\|nowait\|silent\|special\|script\|unique\)>\s*\)*<expr>\s*\%(<\%(buffer\|nowait\|silent\|special\|script\|unique\)>\s*\)*\S\+\s\+\zs\%(\S*\)\?\%#', 'not_in_string': 1, 'not_in_comment': 1, 'priority': 256},
      \   {'cursor_at': '\m\C^\s*let\s\+[^=]\{-}=\%(.*[^.:]\)\?\zs\<\%([gs]:\)\?\k*\%#', 'not_in_string': 1, 'not_in_comment': 1, 'priority': 128},
      \   {'cursor_at': '\m\C\%(^\s*\|[^|]|\s\+\)com\%[mand!]\s\+\%(\%(-nargs=[01*?+]\|-range\%(=[%[:digit:]]\)\?\|-count=\d\+\|-addr=\h\w*\|-bang\|-bar\|-register\|-buffer\)\s\+\)*-complete=custom\%(list\)\?,\zs\S*\%#', 'priority': 256},
      \   {'cursor_at': '\m\C^\s*\%(if\|elseif\?\|for\|wh\%[ile]\|retu\%[rn]\|exe\%[cute]\|ec\%[hon]\|echom\%[sg]\|echoe\%[rr]\)\s.*[:.&]\@1<!\zs\%(\<[gs]:\h\k*\|\<[gs]:\|\<\k*\)\%#', 'not_in_string': 1, 'not_in_comment': 1, 'priority': 128},
      \   {'cursor_at': '\m\C^\s*[A-Z]\w*!\?\s.*[:.&]\@1<!\zs\%(\<[gs]:\h\k*\|\<[gs]:\|\<\k*\)\%#', 'not_in_string': 1, 'not_in_comment': 1, 'priority': 0,},
      \   {'cursor_at': '\m\C\%(<S\%[ID>]\|<SID>\h\w*\)\%#', 'priority': 0},
      \   {'cursor_at': '\m\C\<\%([gs]:\h\k\{5,}\|\%([gs]:\)\?\h\k\{5,}\)\%#', 'in_string': 1, 'priority': 0},
      \   {'cursor_at': '\m\C\<\%([gs]:\h\k\{5,}\|\%([gs]:\)\?\h\k\{5,}\)\%#', 'in_comment': 1, 'priority': 0},
      \ ]
let s:constants.OPTIONCONDITIONLIST = [
      \   {'cursor_at': '\m\C&\%(l:\)\?\zs\a*\%#', 'priority': 256},
      \   {'cursor_at': '\m\C^\s*set\%[local]\s\+\%(no\)\?\zs\a*\%#', 'priority': 256},
      \   {'cursor_at': '\m\C\<exists([''"][&+]\zs\a*\%#', 'priority': 256},
      \   {'cursor_at': '\m^\%(\%([^"]*"[^"]*"\)*[^"]*"[^"]*\|\%([^'']*''[^'']*''\)*[^'']*''[^'']*\)\zs\<\a\{6,}\%#', 'in_string': 1, 'priority': 0},
      \   {'cursor_at': '\m^\%(\%([^"]*"[^"]*"\)*[^"]*"[^"]*\|\%([^'']*''[^'']*''\)*[^'']*''[^'']*\)\zs\<\a\{6,}\%#', 'in_comment': 1, 'priority': 0},
      \ ]
let s:constants.EVENTCONDITIONLIST = [
      \   {'cursor_at': '\m\C^\s*au\%[tocmd]\s\+\%(\S\+\s\+\)\?\%([A-Z]\a*,\)*\zs\%([A-Z]\a*\)\?\%#', 'priority': 256},
      \   {'cursor_at': '\m\C\<exists([''"]##\?\zs\%([A-Z]\a*\)\?\%#', 'priority': 256},
      \   {'cursor_at': '\m\C^\s*do\%[autocmd]\s\+\%(<nomodeline>\s\+\)\?\%(\S\+\s\+\)\?\zs\%([A-Z]\a*\)\?\%#', 'priority': 256},
      \   {'cursor_at': '\m^\%(\%([^"]*"[^"]*"\)*[^"]*"[^"]*\|\%([^'']*''[^'']*''\)*[^'']*''[^'']*\)\zs\<\a\{6,}\%#', 'in_string': 1, 'priority': 0},
      \   {'cursor_at': '\m^\%(\%([^"]*"[^"]*"\)*[^"]*"[^"]*\|\%([^'']*''[^'']*''\)*[^'']*''[^'']*\)\zs\<\a\{6,}\%#', 'in_comment': 1, 'priority': 0},
      \ ]
let s:constants.HIGROUPCONDITIONLIST = [
      \   {'cursor_at': '\m\C^\s*hi\%[ghlight]!\?\s\+\%(\%(clear\|default\)\s\+\)\?\zs\%(\h\w*\)\?\%#', 'priority': 128},
      \   {'cursor_at': '\m\C^\s*hi\%[ghlight]!\?\s\+\%(default\s\+\)\?link\s\+\%(\h\w*\s\+\)\?\zs\%(\h\w*\)\?\%#', 'priority': 128},
      \   {'cursor_at': '\m\C\<matchadd\%(pos\)\?([''"]\zs\%(\h\w*\)\?\%#', 'priority': 256},
      \   {'cursor_at': '\m\C^\s*[23]\?mat\%[ch]\s\+\zs\%(\h\w*\)\?\%#', 'priority': 256},
      \   {'cursor_at': '\m^\%(\%([^"]*"[^"]*"\)*[^"]*"[^"]*\|\%([^'']*''[^'']*''\)*[^'']*''[^'']*\)\zs\<\a\{6,}\%#', 'in_string': 1, 'priority': 0},
      \   {'cursor_at': '\m^\%(\%([^"]*"[^"]*"\)*[^"]*"[^"]*\|\%([^'']*''[^'']*''\)*[^'']*''[^'']*\)\zs\<\a\{6,}\%#', 'in_comment': 1, 'priority': 0},
      \ ]
let s:constants.HICMDOPTCONDITIONLIST = [
      \   {'cursor_at': '\m\C^\s*hi\%[ghlight]!\?\s\+\zs\%(\h\w*\)\?\%#', 'priority': 384}
      \ ]
let s:constants.HICMDKEYCONDITIONLIST = [
      \   {'cursor_at': '\m\C^\s*hi\%[ghlight]!\?\s\+\%(\%(clear\|default\)\s\+\)\?\h\w*\s\+\%(\S\+=\S\+\s\+\)*\zs\a*\%#', 'priority': 384}
      \ ]
let s:constants.HICMDATTRCONDITIONLIST = [
      \   {'cursor_at': '\m\C^\s*hi\%[ghlight]!\?\s\+\%(\%(clear\|default\)\s\+\)\?\h\w*\s\+\%(\S\+=\S\+\s\+\)*\%(c\?term\|gui\)=\zs\S*\%#', 'priority': 384}
      \ ]
let s:constants.SPECIALKEYCONDITIONLIST = [
      \   {'cursor_at': '\m\C^\s*\%([nvxsoilc]\?\%(m\%[ap]\|no\%[remap]\)\|map!\|no\%[remap]!\)\s\+\%(<\%(buffer\|nowait\|silent\|special\|script\|expr\|unique\)>\s*\)*\%(\S\+\s\+\)\?\zs<[[:alnum:]-]*\%#', 'priority': 128},
      \   {'cursor_at': '\m\C\<normal!\?\s\+.*\zs<[[:alnum:]-]*\%#', 'priority': 128},
      \   {'cursor_at': '\m\C\<feedkeys(\%(''\%([^'']*\%(''''\)*\)*[^'']*\|"\%([^"]*\%(\\"\)*\)[^"]*\)\zs<[[:alnum:]-]*\%#', 'in_string': 1, 'priority': 128},
      \   {'cursor_at': '\m<[[:alnum:]-]\+\%#', 'priority': 128},
      \ ]
let s:constants.MAPATTRCONDITIONLIST = [
      \   {'cursor_at': '\m\C^\s*\%([nvxsoilc]\?\%(m\%[ap]\|nor\%[emap]\)\|map!\)\s\+\%(<\a\+>\)*\zs\%(<\a*\)\?\%#', 'priority': 256},
      \   {'cursor_at': '\m<\a\+\%#', 'priority': 128},
      \ ]
let s:constants.COMMANDATTRCONDITIONLIST = [
      \   {'cursor_at': '\m\C^\s*command!\?\s\+\%(\%(-nargs=[01*?+]\|-complete=\h\w*\%(,\S\+\)\?\|-range\%(=[%[:digit:]]\)\?\|-count=\d\+\|-addr=\h\w*\|-bang\|-bar\|-register\|-buffer\)\s\+\)*\zs\%(-\w*\)\?\%#', 'priority': 256}
      \ ]
let s:constants.COMMANDATTRNARGSCONDITIONLIST = [
      \   {'cursor_at': '\m\C^\s*command!\?\s\+\%(\%(-complete=\h\w*\%(,\S\+\)\?\|-range\%(=[%[:digit:]]\)\?\|-count=\d\+\|-addr=\h\w*\|-bang\|-bar\|-register\|-buffer\)\s\+\)*-nargs\zs\%(=[01*?+]\?\)\?\%#', 'priority': 256}
      \ ]
let s:constants.COMMANDATTRCOMPLETECONDITIONLIST = [
      \   {'cursor_at': '\m\C^\s*command!\?\s\+\%(\%(-nargs=[01*?+]\|-range\%(=[%[:digit:]]\)\?\|-count=\d\+\|-addr=\h\w*\|-bang\|-bar\|-register\|-buffer\)\s\+\)*-complete\zs\%(=[a-z_]*\)\?\%#', 'priority': 256}
      \ ]
let s:constants.COMMANDATTRADDRCONDITIONLIST = [
      \   {'cursor_at': '\m\C^\s*command!\?\s\+\%(\%(-nargs=[01*?+]\|-complete=\h\w*\%(,\S\+\)\?\|-range\%(=[%[:digit:]]\)\?\|-count=\d\+\|-bang\|-bar\|-register\|-buffer\)\s\+\)*-addr\zs\%(=[a-z_]*\)\?\%#', 'priority': 256}
      \ ]
let s:constants.EXPANDABLECONDITIONLIST = [
      \   {'cursor_at': '\m\Cexpand([''"]\zs\%(%\|#\d*\|<\a*\)\?\%#', 'priority': 256}
      \ ]
let s:constants.EXPANDABLEMODIFIERCONDITIONLIST = [
      \   {'cursor_at': '\m\Cexpand([''"]\%(%\|#\d*\|<\a*\)\%(:[phtre]\)*\zs:[phtre]\?\%#', 'priority': 256}
      \ ]
let s:constants.VIMVARCONDITIONLIST = [
      \   {'cursor_at': '\m\Cv:\w*\%#', 'priority': 256},
      \ ]
let s:constants.EXISTSHELPERCONDITIONLIST = [
      \   {'cursor_at': '\m\C\<exists([''"]\zs\%([&+$*:]\|##\?\)\?\%#', 'priority': 384}
      \ ]
let s:constants.FEATURECONDITIONLIST = [
      \   {'cursor_at': '\<has([''"]\zs\w*\%#', 'priority': 384}
      \ ]
let s:constants.HELPTAGCONDITIONLIST = [
      \   {'cursor_at': '\m|\zs[^| 	]\+\%#'}
      \ ]
let s:constants.VARCONDITIONLIST = [
      \   {'cursor_at': '\m\C^\s*call\s\+\zs\%([ablstw]:\|\%([ablstw]:\)\?\<\h\w*\|g:\h[0-9A-Za-z_#]*\)\?\%#', 'priority': 128},
      \   {'cursor_at': '\m\C^\s*\%(let\|call\?\|if\|elseif\?\|for\|wh\%[ile]\|retu\%[rn]\|exe\%[cute]\|fu\%[nction]!\?\|unl\%[et]!\?\|ec\%[hon]\|echom\%[sg]\|echoe\%[rr]\)\s.*[:.&+]\@1<!\zs\%(\<[abglstwv]:\h\k*\|\<[abglstwv]:\|\<\k*\)\%#', 'priority': 256},
      \   {'cursor_at': '\m\C^\s*[A-Z]\w*!\?\s.*[:.&]\@1<!\zs\%(\<[abglstwv]:\h\k*\|\<[abglstwv]:\|\<\k*\)\%#', 'priority': 0},
      \   {'cursor_at': '\m\C\%(\%([:.&]\@1<![ablstw]:\)\?\<\h\w\{5,}\|g:\h[0-9A-Za-z_#]\{6,}\)\%#', 'priority': 0},
      \ ]
let s:constants.MEMBERCONDITIONLIST = [
      \   {'cursor_at': s:constants.VARNAME . '\.\zs\%(\h\w*\)\?\%#', 'priority': 384},
      \   {'cursor_at': printf('\m\C\<has_key(\s*%s\s*,\s*[''"]\zs\w*\%%#', s:constants.VARNAME), 'priority': 384},
      \ ]
let s:constants.KEYMAPCONDITIONLIST = [
      \   {'cursor_at': '\m\C<\%(P\%[lug>]\|S\%[ID>]\)\S*\%#', 'priority': 256,},
      \   {'cursor_at': '\m\C^\s*\%([nvxsoilc]\?map\|map!\)\s\+\%(<\%(buffer\|nowait\|silent\|special\|script\|expr\|unique\)>\s*\)*\S\+\s\+\zs\%(<\S*\)\?\%#', 'priority': 256,},
      \   {'cursor_at': '\m\C^\s*\%([nvxsoilc]\?u\%[map]\|unm\%[ap]!\)\s\+\zs\%(<\S*\)\?\%#', 'priority': 256,},
      \   {'cursor_at': '\m\C\<normal\s\+.*\zs<\S*\%#', 'priority': 256,},
      \   {'cursor_at': '\m\C\<feedkeys(\%(''\%([^'']*\%(''''\)*\)*[^'']*\|"\%([^"]*\%(\\"\)*\)[^"]*\)\zs<\S*\%#', 'priority': 256,},
      \ ]
let s:constants.FUNCFRAGMENTCONDITIONLIST = insert(map(deepcopy(s:constants.FUNCCONDITIONLIST), 'extend(v:val, {"priority": get(v:val, "priority", 0) + 128}, "force")'), {'cursor_at': '\m\C^\s*fu\%[nction]!\?\s\+\zs\%([gs]:\)\?\k*\%#', 'priority': 384})
let s:constants.VARFRAGMENTCONDITIONLIST = map(deepcopy(s:constants.VARCONDITIONLIST), 'extend(v:val, {"priority": get(v:val, "priority", 0) + 128}, "force")')
lockvar! s:constants

" vim:set ts=2 sts=2 sw=2 tw=0:
" vim:set foldmethod=marker: commentstring="%s:
