scriptencoding utf-8
function! Verdin#basedict#vim#distribute() abort
  let basedict = {}
  let basedict.mapattr = s:mapattr
  let basedict.hicmdopt = s:hicmdopt
  let basedict.hicmdkey = s:hicmdkey
  let basedict.command = s:command
  let basedict.hicmdattr = s:hicmdattr
  let basedict.higroup = s:higroup
  let basedict.exists = s:exists
  let basedict.expandable = s:expandable
  let basedict.expandablemodifier = s:expandablemodifier
  let basedict.vimvar = s:vimvar
  let basedict.feature = s:feature
  let basedict.commandattrnargs = s:commandattrnargs
  let basedict.function = s:function
  let basedict.commandattr = s:commandattr
  let basedict.option = s:option
  let basedict.event = s:event
  let basedict.keys = s:keys
  let basedict.commandattraddr = s:commandattraddr
  let basedict.commandattrcomplete = s:commandattrcomplete
  return basedict
endfunction
let s:mapattr = {
\   'conditionlist': [{
\       'cursor_at': '\m\C^\s*\%([nvxsoilc]\?\%(m\%[ap]\|nor\%[emap]\)\|map!\)\s\+\%(<\a\+>\)*\zs\%(<\a*\)\?\%#',
\       'priority': 256,
\     },{
\       'cursor_at': '\m<\a\+\%#',
\       'priority': 128,
\     },],
\   'index': {
\     '<': [{
\         '__text__': '<expr>',
\         'menu': '[mapattr]',
\         'word': '<expr>',
\       },{
\         '__text__': '<buffer>',
\         'menu': '[mapattr]',
\         'word': '<buffer>',
\       },{
\         '__text__': '<nowait>',
\         'menu': '[mapattr]',
\         'word': '<nowait>',
\       },{
\         '__text__': '<silent>',
\         'menu': '[mapattr]',
\         'word': '<silent>',
\       },{
\         '__text__': '<script>',
\         'menu': '[mapattr]',
\         'word': '<script>',
\       },{
\         '__text__': '<unique>',
\         'menu': '[mapattr]',
\         'word': '<unique>',
\       },{
\         '__text__': '<special>',
\         'menu': '[mapattr]',
\         'word': '<special>',
\       },],
\   },
\   'indexlen': 1,
\   'name': 'mapattr',
\   'wordlist': ['<buffer>','<nowait>','<silent>','<special>','<script>','<expr>','<unique>',],
\ }
lockvar! s:mapattr
let s:hicmdopt = {
\   'conditionlist': [{
\       'cursor_at': '\m\C^\s*hi\%[ghlight]!\?\s\+\zs\%(\h\w*\)\?\%#',
\       'priority': 384,
\     },],
\   'index': {
\     'c': [{
\         '__text__': 'clear',
\         'menu': '[highlight]',
\         'word': 'clear',
\       },],
\     'd': [{
\         '__text__': 'default',
\         'menu': '[highlight]',
\         'word': 'default',
\       },],
\     'l': [{
\         '__text__': 'link',
\         'menu': '[highlight]',
\         'word': 'link',
\       },],
\   },
\   'indexlen': 1,
\   'name': 'highlight',
\   'wordlist': ['default','link','clear',],
\ }
lockvar! s:hicmdopt
let s:hicmdkey = {
\   'conditionlist': [{
\       'cursor_at': '\m\C^\s*hi\%[ghlight]!\?\s\+\%(\%(clear\|default\)\s\+\)\?\h\w*\s\+\%(\S\+=\S\+\s\+\)*\zs\a*\%#',
\       'priority': 384,
\     },],
\   'index': {
\     'c': [{
\         '__text__': 'cterm=',
\         'menu': '[highlight]',
\         'word': 'cterm=',
\       },{
\         '__text__': 'ctermfg=',
\         'menu': '[highlight]',
\         'word': 'ctermfg=',
\       },{
\         '__text__': 'ctermbg=',
\         'menu': '[highlight]',
\         'word': 'ctermbg=',
\       },],
\     'f': [{
\         '__text__': 'font=',
\         'menu': '[highlight]',
\         'word': 'font=',
\       },],
\     'g': [{
\         '__text__': 'gui=',
\         'menu': '[highlight]',
\         'word': 'gui=',
\       },{
\         '__text__': 'guifg=',
\         'menu': '[highlight]',
\         'word': 'guifg=',
\       },{
\         '__text__': 'guibg=',
\         'menu': '[highlight]',
\         'word': 'guibg=',
\       },{
\         '__text__': 'guisp=',
\         'menu': '[highlight]',
\         'word': 'guisp=',
\       },],
\     's': [{
\         '__text__': 'start=',
\         'menu': '[highlight]',
\         'word': 'start=',
\       },{
\         '__text__': 'stop=',
\         'menu': '[highlight]',
\         'word': 'stop=',
\       },],
\     't': [{
\         '__text__': 'term=',
\         'menu': '[highlight]',
\         'word': 'term=',
\       },],
\   },
\   'indexlen': 1,
\   'name': 'highlight',
\   'wordlist': ['term=','cterm=','gui=','ctermfg=','ctermbg=','guifg=','guibg=','guisp=','font=','start=','stop=',],
\ }
lockvar! s:hicmdkey
let s:command = {
\   'conditionlist': [{
\       'cursor_at': '\m\C\%(^\s*\|[^|]|\s\+\)\%(\%(sil\%[ent!]\|noa\%[utocmd]\|undoj\%[oin]\|vert\%[ical]\|lefta\%[bove]\|abo\%[veleft]\|rightb\%[elow]\|bel\%[owright]\|to\%[pleft]\|bo\%[tright]\)\s\+\)*\zs\%(!!\?\|@@\?\|[#&<>=]\|\a\w*\)\?\%#',
\       'priority': 256,
\     },{
\       'cursor_at': '\m\C\%(^\s*\|[^|]|\s\+\)au\%[tocmd]\s\+\%(\S\+\s\+\)\{2,3}\%(nested\s\+\)\?:\?\zs\%(!!\?\|@@\?\|[#&<>=]\|\a\w*\)\?\%#',
\       'priority': 256,
\     },{
\       'cursor_at': '\m\C\%(^\s*\|[^|]|\s\+\)com\%[mand!]\s\+\%(\%(-nargs=[01*?+]\|-complete=\h\w*\%(,\S\+\)\?\|-range\%(=[%[:digit:]]\)\?\|-count=\d\+\|-addr=\h\w*\|-bang\|-bar\|-register\|-buffer\)\s\+\)*[A-Z]\w*\s\+:\?\zs\%(!!\?\|@@\?\|[#&<>=]\|\a\w*\)\?\%#',
\       'priority': 256,
\     },{
\       'cursor_at': '\m\C\<exists([''"]:\zs\%(!!\?\|@@\?\|[#&<>=]\|\a\w*\)\?\%#',
\       'priority': 256,
\     },{
\       'cursor_at': '\m\C^\s*\%([nvxsoilc]\?\%(m\%[ap]\|no\%[remap]\)\|map!\|no\%[remap]!\)\s\+\%(<\%(buffer\|nowait\|silent\|special\|script\|unique\)>\s*\)*\S\+\s\+:\zs\%(!!\?\|@@\?\|[#&<>=]\|\a\w*\)\?\%#',
\       'priority': 256,
\     },{
\       'cursor_at': '\m^\%(\%([^"]*"[^"]*"\)*[^"]*"[^"]*\|\%([^'']*''[^'']*''\)*[^'']*''[^'']*\)\zs\<\a\w\{5,}\%#',
\       'in_comment': 1,
\       'priority': 0,
\     },{
\       'cursor_at': '\m^\%(\%([^"]*"[^"]*"\)*[^"]*"[^"]*\|\%([^'']*''[^'']*''\)*[^'']*''[^'']*\)\zs\<\a\w\{5,}\%#',
\       'in_string': 1,
\       'priority': 0,
\     },],
\   'index': {
\     'Ne': [{
\         '__text__': 'Next',
\         'menu': '[command]',
\         'word': 'Next',
\       },],
\     'ab': [{
\         '__text__': 'abbreviate',
\         'menu': '[command]',
\         'word': 'abbreviate',
\       },{
\         '__text__': 'abclear',
\         'menu': '[command]',
\         'word': 'abclear',
\       },{
\         '__text__': 'aboveleft',
\         'menu': '[command]',
\         'word': 'aboveleft',
\       },],
\     'al': [{
\         '__text__': 'all',
\         'menu': '[command]',
\         'word': 'all',
\       },],
\     'am': [{
\         '__text__': 'amenu',
\         'menu': '[command]',
\         'word': 'amenu',
\       },],
\     'an': [{
\         '__text__': 'anoremenu',
\         'menu': '[command]',
\         'word': 'anoremenu',
\       },],
\     'ap': [{
\         '__text__': 'append',
\         'menu': '[command]',
\         'word': 'append',
\       },],
\     'ar': [{
\         '__text__': 'argadd',
\         'menu': '[command]',
\         'word': 'argadd',
\       },{
\         '__text__': 'argdelete',
\         'menu': '[command]',
\         'word': 'argdelete',
\       },{
\         '__text__': 'argdo',
\         'menu': '[command]',
\         'word': 'argdo',
\       },{
\         '__text__': 'argedit',
\         'menu': '[command]',
\         'word': 'argedit',
\       },{
\         '__text__': 'argglobal',
\         'menu': '[command]',
\         'word': 'argglobal',
\       },{
\         '__text__': 'arglocal',
\         'menu': '[command]',
\         'word': 'arglocal',
\       },{
\         '__text__': 'args',
\         'menu': '[command]',
\         'word': 'args',
\       },{
\         '__text__': 'argument',
\         'menu': '[command]',
\         'word': 'argument',
\       },],
\     'as': [{
\         '__text__': 'ascii',
\         'menu': '[command]',
\         'word': 'ascii',
\       },],
\     'au': [{
\         '__text__': 'augroup',
\         'menu': '[command]',
\         'word': 'augroup',
\       },{
\         '__text__': 'autocmd',
\         'menu': '[command]',
\         'word': 'autocmd',
\       },{
\         '__text__': 'aunmenu',
\         'menu': '[command]',
\         'word': 'aunmenu',
\       },],
\     'bN': [{
\         '__text__': 'bNext',
\         'menu': '[command]',
\         'word': 'bNext',
\       },],
\     'ba': [{
\         '__text__': 'badd',
\         'menu': '[command]',
\         'word': 'badd',
\       },{
\         '__text__': 'ball',
\         'menu': '[command]',
\         'word': 'ball',
\       },],
\     'bd': [{
\         '__text__': 'bdelete',
\         'menu': '[command]',
\         'word': 'bdelete',
\       },],
\     'be': [{
\         '__text__': 'behave',
\         'menu': '[command]',
\         'word': 'behave',
\       },{
\         '__text__': 'belowright',
\         'menu': '[command]',
\         'word': 'belowright',
\       },],
\     'bf': [{
\         '__text__': 'bfirst',
\         'menu': '[command]',
\         'word': 'bfirst',
\       },],
\     'bl': [{
\         '__text__': 'blast',
\         'menu': '[command]',
\         'word': 'blast',
\       },],
\     'bm': [{
\         '__text__': 'bmodified',
\         'menu': '[command]',
\         'word': 'bmodified',
\       },],
\     'bn': [{
\         '__text__': 'bnext',
\         'menu': '[command]',
\         'word': 'bnext',
\       },],
\     'bo': [{
\         '__text__': 'botright',
\         'menu': '[command]',
\         'word': 'botright',
\       },],
\     'bp': [{
\         '__text__': 'bprevious',
\         'menu': '[command]',
\         'word': 'bprevious',
\       },],
\     'br': [{
\         '__text__': 'break',
\         'menu': '[command]',
\         'word': 'break',
\       },{
\         '__text__': 'breakadd',
\         'menu': '[command]',
\         'word': 'breakadd',
\       },{
\         '__text__': 'breakdel',
\         'menu': '[command]',
\         'word': 'breakdel',
\       },{
\         '__text__': 'breaklist',
\         'menu': '[command]',
\         'word': 'breaklist',
\       },{
\         '__text__': 'brewind',
\         'menu': '[command]',
\         'word': 'brewind',
\       },{
\         '__text__': 'browse',
\         'menu': '[command]',
\         'word': 'browse',
\       },],
\     'bu': [{
\         '__text__': 'bufdo',
\         'menu': '[command]',
\         'word': 'bufdo',
\       },{
\         '__text__': 'buffer',
\         'menu': '[command]',
\         'word': 'buffer',
\       },{
\         '__text__': 'buffers',
\         'menu': '[command]',
\         'word': 'buffers',
\       },{
\         '__text__': 'bunload',
\         'menu': '[command]',
\         'word': 'bunload',
\       },],
\     'bw': [{
\         '__text__': 'bwipeout',
\         'menu': '[command]',
\         'word': 'bwipeout',
\       },],
\     'cN': [{
\         '__text__': 'cNext',
\         'menu': '[command]',
\         'word': 'cNext',
\       },{
\         '__text__': 'cNfile',
\         'menu': '[command]',
\         'word': 'cNfile',
\       },],
\     'ca': [{
\         '__text__': 'call',
\         'menu': '[command]',
\         'word': 'call',
\       },{
\         '__text__': 'catch',
\         'menu': '[command]',
\         'word': 'catch',
\       },{
\         '__text__': 'cabbrev',
\         'menu': '[command]',
\         'word': 'cabbrev',
\       },{
\         '__text__': 'cabclear',
\         'menu': '[command]',
\         'word': 'cabclear',
\       },{
\         '__text__': 'caddbuffer',
\         'menu': '[command]',
\         'word': 'caddbuffer',
\       },{
\         '__text__': 'caddexpr',
\         'menu': '[command]',
\         'word': 'caddexpr',
\       },{
\         '__text__': 'caddfile',
\         'menu': '[command]',
\         'word': 'caddfile',
\       },],
\     'cb': [{
\         '__text__': 'cbottom',
\         'menu': '[command]',
\         'word': 'cbottom',
\       },{
\         '__text__': 'cbuffer',
\         'menu': '[command]',
\         'word': 'cbuffer',
\       },],
\     'cc': [{
\         '__text__': 'cc',
\         'menu': '[command]',
\         'word': 'cc',
\       },{
\         '__text__': 'cclose',
\         'menu': '[command]',
\         'word': 'cclose',
\       },],
\     'cd': [{
\         '__text__': 'cd',
\         'menu': '[command]',
\         'word': 'cd',
\       },{
\         '__text__': 'cdo',
\         'menu': '[command]',
\         'word': 'cdo',
\       },],
\     'ce': [{
\         '__text__': 'center',
\         'menu': '[command]',
\         'word': 'center',
\       },{
\         '__text__': 'cexpr',
\         'menu': '[command]',
\         'word': 'cexpr',
\       },],
\     'cf': [{
\         '__text__': 'cfdo',
\         'menu': '[command]',
\         'word': 'cfdo',
\       },{
\         '__text__': 'cfile',
\         'menu': '[command]',
\         'word': 'cfile',
\       },{
\         '__text__': 'cfirst',
\         'menu': '[command]',
\         'word': 'cfirst',
\       },],
\     'cg': [{
\         '__text__': 'cgetbuffer',
\         'menu': '[command]',
\         'word': 'cgetbuffer',
\       },{
\         '__text__': 'cgetexpr',
\         'menu': '[command]',
\         'word': 'cgetexpr',
\       },{
\         '__text__': 'cgetfile',
\         'menu': '[command]',
\         'word': 'cgetfile',
\       },],
\     'ch': [{
\         '__text__': 'change',
\         'menu': '[command]',
\         'word': 'change',
\       },{
\         '__text__': 'changes',
\         'menu': '[command]',
\         'word': 'changes',
\       },{
\         '__text__': 'chdir',
\         'menu': '[command]',
\         'word': 'chdir',
\       },{
\         '__text__': 'checkpath',
\         'menu': '[command]',
\         'word': 'checkpath',
\       },{
\         '__text__': 'checktime',
\         'menu': '[command]',
\         'word': 'checktime',
\       },{
\         '__text__': 'chistory',
\         'menu': '[command]',
\         'word': 'chistory',
\       },],
\     'cl': [{
\         '__text__': 'clast',
\         'menu': '[command]',
\         'word': 'clast',
\       },{
\         '__text__': 'clearjumps',
\         'menu': '[command]',
\         'word': 'clearjumps',
\       },{
\         '__text__': 'clist',
\         'menu': '[command]',
\         'word': 'clist',
\       },{
\         '__text__': 'close',
\         'menu': '[command]',
\         'word': 'close',
\       },],
\     'cm': [{
\         '__text__': 'cmap',
\         'menu': '[command]',
\         'word': 'cmap',
\       },{
\         '__text__': 'cmapclear',
\         'menu': '[command]',
\         'word': 'cmapclear',
\       },{
\         '__text__': 'cmenu',
\         'menu': '[command]',
\         'word': 'cmenu',
\       },],
\     'cn': [{
\         '__text__': 'cnoremap',
\         'menu': '[command]',
\         'word': 'cnoremap',
\       },{
\         '__text__': 'cnewer',
\         'menu': '[command]',
\         'word': 'cnewer',
\       },{
\         '__text__': 'cnext',
\         'menu': '[command]',
\         'word': 'cnext',
\       },{
\         '__text__': 'cnfile',
\         'menu': '[command]',
\         'word': 'cnfile',
\       },{
\         '__text__': 'cnoreabbrev',
\         'menu': '[command]',
\         'word': 'cnoreabbrev',
\       },{
\         '__text__': 'cnoremenu',
\         'menu': '[command]',
\         'word': 'cnoremenu',
\       },],
\     'co': [{
\         '__text__': 'command',
\         'menu': '[command]',
\         'word': 'command',
\       },{
\         '__text__': 'continue',
\         'menu': '[command]',
\         'word': 'continue',
\       },{
\         '__text__': 'compiler',
\         'menu': '[command]',
\         'word': 'compiler',
\       },{
\         '__text__': 'colder',
\         'menu': '[command]',
\         'word': 'colder',
\       },{
\         '__text__': 'colorscheme',
\         'menu': '[command]',
\         'word': 'colorscheme',
\       },{
\         '__text__': 'comclear',
\         'menu': '[command]',
\         'word': 'comclear',
\       },{
\         '__text__': 'confirm',
\         'menu': '[command]',
\         'word': 'confirm',
\       },{
\         '__text__': 'copen',
\         'menu': '[command]',
\         'word': 'copen',
\       },{
\         '__text__': 'copy',
\         'menu': '[command]',
\         'word': 'copy',
\       },],
\     'cp': [{
\         '__text__': 'cpfile',
\         'menu': '[command]',
\         'word': 'cpfile',
\       },{
\         '__text__': 'cprevious',
\         'menu': '[command]',
\         'word': 'cprevious',
\       },],
\     'cq': [{
\         '__text__': 'cquit',
\         'menu': '[command]',
\         'word': 'cquit',
\       },],
\     'cr': [{
\         '__text__': 'crewind',
\         'menu': '[command]',
\         'word': 'crewind',
\       },],
\     'cs': [{
\         '__text__': 'cscope',
\         'menu': '[command]',
\         'word': 'cscope',
\       },{
\         '__text__': 'cstag',
\         'menu': '[command]',
\         'word': 'cstag',
\       },],
\     'cu': [{
\         '__text__': 'cunabbrev',
\         'menu': '[command]',
\         'word': 'cunabbrev',
\       },{
\         '__text__': 'cunmap',
\         'menu': '[command]',
\         'word': 'cunmap',
\       },{
\         '__text__': 'cunmenu',
\         'menu': '[command]',
\         'word': 'cunmenu',
\       },],
\     'cw': [{
\         '__text__': 'cwindow',
\         'menu': '[command]',
\         'word': 'cwindow',
\       },],
\     'de': [{
\         '__text__': 'delfunction',
\         'menu': '[command]',
\         'word': 'delfunction',
\       },{
\         '__text__': 'debug',
\         'menu': '[command]',
\         'word': 'debug',
\       },{
\         '__text__': 'debuggreedy',
\         'menu': '[command]',
\         'word': 'debuggreedy',
\       },{
\         '__text__': 'delcommand',
\         'menu': '[command]',
\         'word': 'delcommand',
\       },{
\         '__text__': 'delete',
\         'menu': '[command]',
\         'word': 'delete',
\       },{
\         '__text__': 'delmarks',
\         'menu': '[command]',
\         'word': 'delmarks',
\       },],
\     'di': [{
\         '__text__': 'diffget',
\         'menu': '[command]',
\         'word': 'diffget',
\       },{
\         '__text__': 'diffoff',
\         'menu': '[command]',
\         'word': 'diffoff',
\       },{
\         '__text__': 'diffpatch',
\         'menu': '[command]',
\         'word': 'diffpatch',
\       },{
\         '__text__': 'diffput',
\         'menu': '[command]',
\         'word': 'diffput',
\       },{
\         '__text__': 'diffsplit',
\         'menu': '[command]',
\         'word': 'diffsplit',
\       },{
\         '__text__': 'diffthis',
\         'menu': '[command]',
\         'word': 'diffthis',
\       },{
\         '__text__': 'diffupdate',
\         'menu': '[command]',
\         'word': 'diffupdate',
\       },{
\         '__text__': 'digraphs',
\         'menu': '[command]',
\         'word': 'digraphs',
\       },{
\         '__text__': 'display',
\         'menu': '[command]',
\         'word': 'display',
\       },],
\     'dj': [{
\         '__text__': 'djump',
\         'menu': '[command]',
\         'word': 'djump',
\       },],
\     'dl': [{
\         '__text__': 'dlist',
\         'menu': '[command]',
\         'word': 'dlist',
\       },],
\     'do': [{
\         '__text__': 'doautoall',
\         'menu': '[command]',
\         'word': 'doautoall',
\       },{
\         '__text__': 'doautocmd',
\         'menu': '[command]',
\         'word': 'doautocmd',
\       },],
\     'dr': [{
\         '__text__': 'drop',
\         'menu': '[command]',
\         'word': 'drop',
\       },],
\     'ds': [{
\         '__text__': 'dsearch',
\         'menu': '[command]',
\         'word': 'dsearch',
\       },{
\         '__text__': 'dsplit',
\         'menu': '[command]',
\         'word': 'dsplit',
\       },],
\     'ea': [{
\         '__text__': 'earlier',
\         'menu': '[command]',
\         'word': 'earlier',
\       },],
\     'ec': [{
\         '__text__': 'echohl',
\         'menu': '[command]',
\         'word': 'echohl',
\       },{
\         '__text__': 'echoerr',
\         'menu': '[command]',
\         'word': 'echoerr',
\       },{
\         '__text__': 'echo',
\         'menu': '[command]',
\         'word': 'echo',
\       },{
\         '__text__': 'echomsg',
\         'menu': '[command]',
\         'word': 'echomsg',
\       },{
\         '__text__': 'echon',
\         'menu': '[command]',
\         'word': 'echon',
\       },],
\     'ed': [{
\         '__text__': 'edit',
\         'menu': '[command]',
\         'word': 'edit',
\       },],
\     'el': [{
\         '__text__': 'else',
\         'menu': '[command]',
\         'word': 'else',
\       },{
\         '__text__': 'elseif',
\         'menu': '[command]',
\         'word': 'elseif',
\       },],
\     'em': [{
\         '__text__': 'emenu',
\         'menu': '[command]',
\         'word': 'emenu',
\       },],
\     'en': [{
\         '__text__': 'endif',
\         'menu': '[command]',
\         'word': 'endif',
\       },{
\         '__text__': 'endfunction',
\         'menu': '[command]',
\         'word': 'endfunction',
\       },{
\         '__text__': 'endfor',
\         'menu': '[command]',
\         'word': 'endfor',
\       },{
\         '__text__': 'endwhile',
\         'menu': '[command]',
\         'word': 'endwhile',
\       },{
\         '__text__': 'endtry',
\         'menu': '[command]',
\         'word': 'endtry',
\       },{
\         '__text__': 'enew',
\         'menu': '[command]',
\         'word': 'enew',
\       },],
\     'ex': [{
\         '__text__': 'execute',
\         'menu': '[command]',
\         'word': 'execute',
\       },{
\         '__text__': 'ex',
\         'menu': '[command]',
\         'word': 'ex',
\       },{
\         '__text__': 'exit',
\         'menu': '[command]',
\         'word': 'exit',
\       },{
\         '__text__': 'exusage',
\         'menu': '[command]',
\         'word': 'exusage',
\       },],
\     'fi': [{
\         '__text__': 'finish',
\         'menu': '[command]',
\         'word': 'finish',
\       },{
\         '__text__': 'finally',
\         'menu': '[command]',
\         'word': 'finally',
\       },{
\         '__text__': 'filetype',
\         'menu': '[command]',
\         'word': 'filetype',
\       },{
\         '__text__': 'file',
\         'menu': '[command]',
\         'word': 'file',
\       },{
\         '__text__': 'files',
\         'menu': '[command]',
\         'word': 'files',
\       },{
\         '__text__': 'filter',
\         'menu': '[command]',
\         'word': 'filter',
\       },{
\         '__text__': 'find',
\         'menu': '[command]',
\         'word': 'find',
\       },{
\         '__text__': 'first',
\         'menu': '[command]',
\         'word': 'first',
\       },{
\         '__text__': 'fixdel',
\         'menu': '[command]',
\         'word': 'fixdel',
\       },],
\     'fo': [{
\         '__text__': 'for',
\         'menu': '[command]',
\         'word': 'for',
\       },{
\         '__text__': 'foldopen',
\         'menu': '[command]',
\         'word': 'foldopen',
\       },{
\         '__text__': 'fold',
\         'menu': '[command]',
\         'word': 'fold',
\       },{
\         '__text__': 'foldclose',
\         'menu': '[command]',
\         'word': 'foldclose',
\       },{
\         '__text__': 'folddoclosed',
\         'menu': '[command]',
\         'word': 'folddoclosed',
\       },{
\         '__text__': 'folddoopen',
\         'menu': '[command]',
\         'word': 'folddoopen',
\       },],
\     'fu': [{
\         '__text__': 'function',
\         'menu': '[command]',
\         'word': 'function',
\       },],
\     'gl': [{
\         '__text__': 'global',
\         'menu': '[command]',
\         'word': 'global',
\       },],
\     'go': [{
\         '__text__': 'goto',
\         'menu': '[command]',
\         'word': 'goto',
\       },],
\     'gr': [{
\         '__text__': 'grep',
\         'menu': '[command]',
\         'word': 'grep',
\       },{
\         '__text__': 'grepadd',
\         'menu': '[command]',
\         'word': 'grepadd',
\       },],
\     'gu': [{
\         '__text__': 'gui',
\         'menu': '[command]',
\         'word': 'gui',
\       },],
\     'gv': [{
\         '__text__': 'gvim',
\         'menu': '[command]',
\         'word': 'gvim',
\       },],
\     'ha': [{
\         '__text__': 'hardcopy',
\         'menu': '[command]',
\         'word': 'hardcopy',
\       },],
\     'he': [{
\         '__text__': 'help',
\         'menu': '[command]',
\         'word': 'help',
\       },{
\         '__text__': 'helpclose',
\         'menu': '[command]',
\         'word': 'helpclose',
\       },{
\         '__text__': 'helpfind',
\         'menu': '[command]',
\         'word': 'helpfind',
\       },{
\         '__text__': 'helpgrep',
\         'menu': '[command]',
\         'word': 'helpgrep',
\       },{
\         '__text__': 'helptags',
\         'menu': '[command]',
\         'word': 'helptags',
\       },],
\     'hi': [{
\         '__text__': 'highlight',
\         'menu': '[command]',
\         'word': 'highlight',
\       },{
\         '__text__': 'hide',
\         'menu': '[command]',
\         'word': 'hide',
\       },{
\         '__text__': 'history',
\         'menu': '[command]',
\         'word': 'history',
\       },],
\     'ia': [{
\         '__text__': 'iabbrev',
\         'menu': '[command]',
\         'word': 'iabbrev',
\       },{
\         '__text__': 'iabclear',
\         'menu': '[command]',
\         'word': 'iabclear',
\       },],
\     'if': [{
\         '__text__': 'if',
\         'menu': '[command]',
\         'word': 'if',
\       },],
\     'ij': [{
\         '__text__': 'ijump',
\         'menu': '[command]',
\         'word': 'ijump',
\       },],
\     'il': [{
\         '__text__': 'ilist',
\         'menu': '[command]',
\         'word': 'ilist',
\       },],
\     'im': [{
\         '__text__': 'imap',
\         'menu': '[command]',
\         'word': 'imap',
\       },{
\         '__text__': 'imapclear',
\         'menu': '[command]',
\         'word': 'imapclear',
\       },{
\         '__text__': 'imenu',
\         'menu': '[command]',
\         'word': 'imenu',
\       },],
\     'in': [{
\         '__text__': 'inoremap',
\         'menu': '[command]',
\         'word': 'inoremap',
\       },{
\         '__text__': 'inoreabbrev',
\         'menu': '[command]',
\         'word': 'inoreabbrev',
\       },{
\         '__text__': 'inoremenu',
\         'menu': '[command]',
\         'word': 'inoremenu',
\       },{
\         '__text__': 'insert',
\         'menu': '[command]',
\         'word': 'insert',
\       },{
\         '__text__': 'intro',
\         'menu': '[command]',
\         'word': 'intro',
\       },],
\     'is': [{
\         '__text__': 'isearch',
\         'menu': '[command]',
\         'word': 'isearch',
\       },{
\         '__text__': 'isplit',
\         'menu': '[command]',
\         'word': 'isplit',
\       },],
\     'iu': [{
\         '__text__': 'iunmap',
\         'menu': '[command]',
\         'word': 'iunmap',
\       },{
\         '__text__': 'iunabbrev',
\         'menu': '[command]',
\         'word': 'iunabbrev',
\       },{
\         '__text__': 'iunmenu',
\         'menu': '[command]',
\         'word': 'iunmenu',
\       },],
\     'jo': [{
\         '__text__': 'join',
\         'menu': '[command]',
\         'word': 'join',
\       },],
\     'ju': [{
\         '__text__': 'jumps',
\         'menu': '[command]',
\         'word': 'jumps',
\       },],
\     'k': [{
\         '__text__': 'k',
\         'menu': '[command]',
\         'word': 'k',
\       },],
\     'ke': [{
\         '__text__': 'keepjumps',
\         'menu': '[command]',
\         'word': 'keepjumps',
\       },{
\         '__text__': 'keepalt',
\         'menu': '[command]',
\         'word': 'keepalt',
\       },{
\         '__text__': 'keepmarks',
\         'menu': '[command]',
\         'word': 'keepmarks',
\       },{
\         '__text__': 'keeppatterns',
\         'menu': '[command]',
\         'word': 'keeppatterns',
\       },],
\     'lN': [{
\         '__text__': 'lNext',
\         'menu': '[command]',
\         'word': 'lNext',
\       },{
\         '__text__': 'lNfile',
\         'menu': '[command]',
\         'word': 'lNfile',
\       },],
\     'la': [{
\         '__text__': 'language',
\         'menu': '[command]',
\         'word': 'language',
\       },{
\         '__text__': 'laddbuffer',
\         'menu': '[command]',
\         'word': 'laddbuffer',
\       },{
\         '__text__': 'laddexpr',
\         'menu': '[command]',
\         'word': 'laddexpr',
\       },{
\         '__text__': 'laddfile',
\         'menu': '[command]',
\         'word': 'laddfile',
\       },{
\         '__text__': 'last',
\         'menu': '[command]',
\         'word': 'last',
\       },{
\         '__text__': 'later',
\         'menu': '[command]',
\         'word': 'later',
\       },],
\     'lb': [{
\         '__text__': 'lbottom',
\         'menu': '[command]',
\         'word': 'lbottom',
\       },{
\         '__text__': 'lbuffer',
\         'menu': '[command]',
\         'word': 'lbuffer',
\       },],
\     'lc': [{
\         '__text__': 'lcd',
\         'menu': '[command]',
\         'word': 'lcd',
\       },{
\         '__text__': 'lchdir',
\         'menu': '[command]',
\         'word': 'lchdir',
\       },{
\         '__text__': 'lclose',
\         'menu': '[command]',
\         'word': 'lclose',
\       },{
\         '__text__': 'lcscope',
\         'menu': '[command]',
\         'word': 'lcscope',
\       },],
\     'ld': [{
\         '__text__': 'ldo',
\         'menu': '[command]',
\         'word': 'ldo',
\       },],
\     'le': [{
\         '__text__': 'let',
\         'menu': '[command]',
\         'word': 'let',
\       },{
\         '__text__': 'left',
\         'menu': '[command]',
\         'word': 'left',
\       },{
\         '__text__': 'leftabove',
\         'menu': '[command]',
\         'word': 'leftabove',
\       },{
\         '__text__': 'lexpr',
\         'menu': '[command]',
\         'word': 'lexpr',
\       },],
\     'lf': [{
\         '__text__': 'lfdo',
\         'menu': '[command]',
\         'word': 'lfdo',
\       },{
\         '__text__': 'lfile',
\         'menu': '[command]',
\         'word': 'lfile',
\       },{
\         '__text__': 'lfirst',
\         'menu': '[command]',
\         'word': 'lfirst',
\       },],
\     'lg': [{
\         '__text__': 'lgetbuffer',
\         'menu': '[command]',
\         'word': 'lgetbuffer',
\       },{
\         '__text__': 'lgetexpr',
\         'menu': '[command]',
\         'word': 'lgetexpr',
\       },{
\         '__text__': 'lgetfile',
\         'menu': '[command]',
\         'word': 'lgetfile',
\       },{
\         '__text__': 'lgrep',
\         'menu': '[command]',
\         'word': 'lgrep',
\       },{
\         '__text__': 'lgrepadd',
\         'menu': '[command]',
\         'word': 'lgrepadd',
\       },],
\     'lh': [{
\         '__text__': 'lhelpgrep',
\         'menu': '[command]',
\         'word': 'lhelpgrep',
\       },{
\         '__text__': 'lhistory',
\         'menu': '[command]',
\         'word': 'lhistory',
\       },],
\     'li': [{
\         '__text__': 'list',
\         'menu': '[command]',
\         'word': 'list',
\       },],
\     'll': [{
\         '__text__': 'll',
\         'menu': '[command]',
\         'word': 'll',
\       },{
\         '__text__': 'llast',
\         'menu': '[command]',
\         'word': 'llast',
\       },{
\         '__text__': 'llist',
\         'menu': '[command]',
\         'word': 'llist',
\       },],
\     'lm': [{
\         '__text__': 'lmake',
\         'menu': '[command]',
\         'word': 'lmake',
\       },{
\         '__text__': 'lmap',
\         'menu': '[command]',
\         'word': 'lmap',
\       },{
\         '__text__': 'lmapclear',
\         'menu': '[command]',
\         'word': 'lmapclear',
\       },],
\     'ln': [{
\         '__text__': 'lnewer',
\         'menu': '[command]',
\         'word': 'lnewer',
\       },{
\         '__text__': 'lnext',
\         'menu': '[command]',
\         'word': 'lnext',
\       },{
\         '__text__': 'lnfile',
\         'menu': '[command]',
\         'word': 'lnfile',
\       },{
\         '__text__': 'lnoremap',
\         'menu': '[command]',
\         'word': 'lnoremap',
\       },],
\     'lo': [{
\         '__text__': 'lockvar',
\         'menu': '[command]',
\         'word': 'lockvar',
\       },{
\         '__text__': 'loadkeymap',
\         'menu': '[command]',
\         'word': 'loadkeymap',
\       },{
\         '__text__': 'loadview',
\         'menu': '[command]',
\         'word': 'loadview',
\       },{
\         '__text__': 'lockmarks',
\         'menu': '[command]',
\         'word': 'lockmarks',
\       },{
\         '__text__': 'lolder',
\         'menu': '[command]',
\         'word': 'lolder',
\       },{
\         '__text__': 'lopen',
\         'menu': '[command]',
\         'word': 'lopen',
\       },],
\     'lp': [{
\         '__text__': 'lpfile',
\         'menu': '[command]',
\         'word': 'lpfile',
\       },{
\         '__text__': 'lprevious',
\         'menu': '[command]',
\         'word': 'lprevious',
\       },],
\     'lr': [{
\         '__text__': 'lrewind',
\         'menu': '[command]',
\         'word': 'lrewind',
\       },],
\     'ls': [{
\         '__text__': 'ls',
\         'menu': '[command]',
\         'word': 'ls',
\       },],
\     'lt': [{
\         '__text__': 'ltag',
\         'menu': '[command]',
\         'word': 'ltag',
\       },],
\     'lu': [{
\         '__text__': 'lua',
\         'menu': '[command]',
\         'word': 'lua',
\       },{
\         '__text__': 'luado',
\         'menu': '[command]',
\         'word': 'luado',
\       },{
\         '__text__': 'luafile',
\         'menu': '[command]',
\         'word': 'luafile',
\       },{
\         '__text__': 'lunmap',
\         'menu': '[command]',
\         'word': 'lunmap',
\       },],
\     'lv': [{
\         '__text__': 'lvimgrep',
\         'menu': '[command]',
\         'word': 'lvimgrep',
\       },{
\         '__text__': 'lvimgrepadd',
\         'menu': '[command]',
\         'word': 'lvimgrepadd',
\       },],
\     'lw': [{
\         '__text__': 'lwindow',
\         'menu': '[command]',
\         'word': 'lwindow',
\       },],
\     'ma': [{
\         '__text__': 'map',
\         'menu': '[command]',
\         'word': 'map',
\       },{
\         '__text__': 'mark',
\         'menu': '[command]',
\         'word': 'mark',
\       },{
\         '__text__': 'make',
\         'menu': '[command]',
\         'word': 'make',
\       },{
\         '__text__': 'mapclear',
\         'menu': '[command]',
\         'word': 'mapclear',
\       },{
\         '__text__': 'marks',
\         'menu': '[command]',
\         'word': 'marks',
\       },{
\         '__text__': 'match',
\         'menu': '[command]',
\         'word': 'match',
\       },],
\     'me': [{
\         '__text__': 'menu',
\         'menu': '[command]',
\         'word': 'menu',
\       },{
\         '__text__': 'menutranslate',
\         'menu': '[command]',
\         'word': 'menutranslate',
\       },{
\         '__text__': 'messages',
\         'menu': '[command]',
\         'word': 'messages',
\       },],
\     'mk': [{
\         '__text__': 'mkexrc',
\         'menu': '[command]',
\         'word': 'mkexrc',
\       },{
\         '__text__': 'mksession',
\         'menu': '[command]',
\         'word': 'mksession',
\       },{
\         '__text__': 'mkspell',
\         'menu': '[command]',
\         'word': 'mkspell',
\       },{
\         '__text__': 'mkview',
\         'menu': '[command]',
\         'word': 'mkview',
\       },{
\         '__text__': 'mkvimrc',
\         'menu': '[command]',
\         'word': 'mkvimrc',
\       },],
\     'mo': [{
\         '__text__': 'mode',
\         'menu': '[command]',
\         'word': 'mode',
\       },{
\         '__text__': 'move',
\         'menu': '[command]',
\         'word': 'move',
\       },],
\     'mz': [{
\         '__text__': 'mzfile',
\         'menu': '[command]',
\         'word': 'mzfile',
\       },{
\         '__text__': 'mzscheme',
\         'menu': '[command]',
\         'word': 'mzscheme',
\       },],
\     'nb': [{
\         '__text__': 'nbclose',
\         'menu': '[command]',
\         'word': 'nbclose',
\       },{
\         '__text__': 'nbkey',
\         'menu': '[command]',
\         'word': 'nbkey',
\       },{
\         '__text__': 'nbstart',
\         'menu': '[command]',
\         'word': 'nbstart',
\       },],
\     'ne': [{
\         '__text__': 'new',
\         'menu': '[command]',
\         'word': 'new',
\       },{
\         '__text__': 'next',
\         'menu': '[command]',
\         'word': 'next',
\       },],
\     'nm': [{
\         '__text__': 'nmap',
\         'menu': '[command]',
\         'word': 'nmap',
\       },{
\         '__text__': 'nmapclear',
\         'menu': '[command]',
\         'word': 'nmapclear',
\       },{
\         '__text__': 'nmenu',
\         'menu': '[command]',
\         'word': 'nmenu',
\       },],
\     'nn': [{
\         '__text__': 'nnoremap',
\         'menu': '[command]',
\         'word': 'nnoremap',
\       },{
\         '__text__': 'nnoremenu',
\         'menu': '[command]',
\         'word': 'nnoremenu',
\       },],
\     'no': [{
\         '__text__': 'normal',
\         'menu': '[command]',
\         'word': 'normal',
\       },{
\         '__text__': 'noremap',
\         'menu': '[command]',
\         'word': 'noremap',
\       },{
\         '__text__': 'noautocmd',
\         'menu': '[command]',
\         'word': 'noautocmd',
\       },{
\         '__text__': 'nohlsearch',
\         'menu': '[command]',
\         'word': 'nohlsearch',
\       },{
\         '__text__': 'noreabbrev',
\         'menu': '[command]',
\         'word': 'noreabbrev',
\       },{
\         '__text__': 'noremenu',
\         'menu': '[command]',
\         'word': 'noremenu',
\       },{
\         '__text__': 'noswapfile',
\         'menu': '[command]',
\         'word': 'noswapfile',
\       },],
\     'nu': [{
\         '__text__': 'number',
\         'menu': '[command]',
\         'word': 'number',
\       },{
\         '__text__': 'nunmap',
\         'menu': '[command]',
\         'word': 'nunmap',
\       },{
\         '__text__': 'nunmenu',
\         'menu': '[command]',
\         'word': 'nunmenu',
\       },],
\     'ol': [{
\         '__text__': 'oldfiles',
\         'menu': '[command]',
\         'word': 'oldfiles',
\       },],
\     'om': [{
\         '__text__': 'omap',
\         'menu': '[command]',
\         'word': 'omap',
\       },{
\         '__text__': 'omapclear',
\         'menu': '[command]',
\         'word': 'omapclear',
\       },{
\         '__text__': 'omenu',
\         'menu': '[command]',
\         'word': 'omenu',
\       },],
\     'on': [{
\         '__text__': 'onoremap',
\         'menu': '[command]',
\         'word': 'onoremap',
\       },{
\         '__text__': 'only',
\         'menu': '[command]',
\         'word': 'only',
\       },{
\         '__text__': 'onoremenu',
\         'menu': '[command]',
\         'word': 'onoremenu',
\       },],
\     'op': [{
\         '__text__': 'open',
\         'menu': '[command]',
\         'word': 'open',
\       },{
\         '__text__': 'options',
\         'menu': '[command]',
\         'word': 'options',
\       },],
\     'ou': [{
\         '__text__': 'ounmap',
\         'menu': '[command]',
\         'word': 'ounmap',
\       },{
\         '__text__': 'ounmenu',
\         'menu': '[command]',
\         'word': 'ounmenu',
\       },],
\     'ow': [{
\         '__text__': 'ownsyntax',
\         'menu': '[command]',
\         'word': 'ownsyntax',
\       },],
\     'pa': [{
\         '__text__': 'packadd',
\         'menu': '[command]',
\         'word': 'packadd',
\       },{
\         '__text__': 'packloadall',
\         'menu': '[command]',
\         'word': 'packloadall',
\       },],
\     'pc': [{
\         '__text__': 'pclose',
\         'menu': '[command]',
\         'word': 'pclose',
\       },],
\     'pe': [{
\         '__text__': 'pedit',
\         'menu': '[command]',
\         'word': 'pedit',
\       },{
\         '__text__': 'perl',
\         'menu': '[command]',
\         'word': 'perl',
\       },{
\         '__text__': 'perldo',
\         'menu': '[command]',
\         'word': 'perldo',
\       },],
\     'po': [{
\         '__text__': 'pop',
\         'menu': '[command]',
\         'word': 'pop',
\       },{
\         '__text__': 'popup',
\         'menu': '[command]',
\         'word': 'popup',
\       },],
\     'pp': [{
\         '__text__': 'ppop',
\         'menu': '[command]',
\         'word': 'ppop',
\       },],
\     'pr': [{
\         '__text__': 'preserve',
\         'menu': '[command]',
\         'word': 'preserve',
\       },{
\         '__text__': 'previous',
\         'menu': '[command]',
\         'word': 'previous',
\       },{
\         '__text__': 'print',
\         'menu': '[command]',
\         'word': 'print',
\       },{
\         '__text__': 'profdel',
\         'menu': '[command]',
\         'word': 'profdel',
\       },{
\         '__text__': 'profile',
\         'menu': '[command]',
\         'word': 'profile',
\       },{
\         '__text__': 'promptfind',
\         'menu': '[command]',
\         'word': 'promptfind',
\       },{
\         '__text__': 'promptrepl',
\         'menu': '[command]',
\         'word': 'promptrepl',
\       },],
\     'ps': [{
\         '__text__': 'psearch',
\         'menu': '[command]',
\         'word': 'psearch',
\       },],
\     'pt': [{
\         '__text__': 'ptNext',
\         'menu': '[command]',
\         'word': 'ptNext',
\       },{
\         '__text__': 'ptag',
\         'menu': '[command]',
\         'word': 'ptag',
\       },{
\         '__text__': 'ptfirst',
\         'menu': '[command]',
\         'word': 'ptfirst',
\       },{
\         '__text__': 'ptjump',
\         'menu': '[command]',
\         'word': 'ptjump',
\       },{
\         '__text__': 'ptlast',
\         'menu': '[command]',
\         'word': 'ptlast',
\       },{
\         '__text__': 'ptnext',
\         'menu': '[command]',
\         'word': 'ptnext',
\       },{
\         '__text__': 'ptprevious',
\         'menu': '[command]',
\         'word': 'ptprevious',
\       },{
\         '__text__': 'ptrewind',
\         'menu': '[command]',
\         'word': 'ptrewind',
\       },{
\         '__text__': 'ptselect',
\         'menu': '[command]',
\         'word': 'ptselect',
\       },],
\     'pu': [{
\         '__text__': 'put',
\         'menu': '[command]',
\         'word': 'put',
\       },],
\     'pw': [{
\         '__text__': 'pwd',
\         'menu': '[command]',
\         'word': 'pwd',
\       },],
\     'py': [{
\         '__text__': 'python',
\         'menu': '[command]',
\         'word': 'python',
\       },{
\         '__text__': 'py3',
\         'menu': '[command]',
\         'word': 'py3',
\       },{
\         '__text__': 'py3do',
\         'menu': '[command]',
\         'word': 'py3do',
\       },{
\         '__text__': 'py3file',
\         'menu': '[command]',
\         'word': 'py3file',
\       },{
\         '__text__': 'pydo',
\         'menu': '[command]',
\         'word': 'pydo',
\       },{
\         '__text__': 'pyfile',
\         'menu': '[command]',
\         'word': 'pyfile',
\       },{
\         '__text__': 'python3',
\         'menu': '[command]',
\         'word': 'python3',
\       },{
\         '__text__': 'pythonx',
\         'menu': '[command]',
\         'word': 'pythonx',
\       },{
\         '__text__': 'pyx',
\         'menu': '[command]',
\         'word': 'pyx',
\       },{
\         '__text__': 'pyxdo',
\         'menu': '[command]',
\         'word': 'pyxdo',
\       },{
\         '__text__': 'pyxfile',
\         'menu': '[command]',
\         'word': 'pyxfile',
\       },],
\     'qa': [{
\         '__text__': 'qall',
\         'menu': '[command]',
\         'word': 'qall',
\       },],
\     'qu': [{
\         '__text__': 'quit',
\         'menu': '[command]',
\         'word': 'quit',
\       },{
\         '__text__': 'quitall',
\         'menu': '[command]',
\         'word': 'quitall',
\       },],
\     're': [{
\         '__text__': 'return',
\         'menu': '[command]',
\         'word': 'return',
\       },{
\         '__text__': 'redraw',
\         'menu': '[command]',
\         'word': 'redraw',
\       },{
\         '__text__': 'read',
\         'menu': '[command]',
\         'word': 'read',
\       },{
\         '__text__': 'recover',
\         'menu': '[command]',
\         'word': 'recover',
\       },{
\         '__text__': 'redir',
\         'menu': '[command]',
\         'word': 'redir',
\       },{
\         '__text__': 'redo',
\         'menu': '[command]',
\         'word': 'redo',
\       },{
\         '__text__': 'redrawstatus',
\         'menu': '[command]',
\         'word': 'redrawstatus',
\       },{
\         '__text__': 'registers',
\         'menu': '[command]',
\         'word': 'registers',
\       },{
\         '__text__': 'resize',
\         'menu': '[command]',
\         'word': 'resize',
\       },{
\         '__text__': 'retab',
\         'menu': '[command]',
\         'word': 'retab',
\       },{
\         '__text__': 'rewind',
\         'menu': '[command]',
\         'word': 'rewind',
\       },],
\     'ri': [{
\         '__text__': 'right',
\         'menu': '[command]',
\         'word': 'right',
\       },{
\         '__text__': 'rightbelow',
\         'menu': '[command]',
\         'word': 'rightbelow',
\       },],
\     'ru': [{
\         '__text__': 'runtime',
\         'menu': '[command]',
\         'word': 'runtime',
\       },{
\         '__text__': 'ruby',
\         'menu': '[command]',
\         'word': 'ruby',
\       },{
\         '__text__': 'rubydo',
\         'menu': '[command]',
\         'word': 'rubydo',
\       },{
\         '__text__': 'rubyfile',
\         'menu': '[command]',
\         'word': 'rubyfile',
\       },{
\         '__text__': 'rundo',
\         'menu': '[command]',
\         'word': 'rundo',
\       },],
\     'rv': [{
\         '__text__': 'rviminfo',
\         'menu': '[command]',
\         'word': 'rviminfo',
\       },],
\     'sN': [{
\         '__text__': 'sNext',
\         'menu': '[command]',
\         'word': 'sNext',
\       },],
\     'sa': [{
\         '__text__': 'sall',
\         'menu': '[command]',
\         'word': 'sall',
\       },{
\         '__text__': 'sandbox',
\         'menu': '[command]',
\         'word': 'sandbox',
\       },{
\         '__text__': 'sargument',
\         'menu': '[command]',
\         'word': 'sargument',
\       },{
\         '__text__': 'saveas',
\         'menu': '[command]',
\         'word': 'saveas',
\       },],
\     'sb': [{
\         '__text__': 'sbNext',
\         'menu': '[command]',
\         'word': 'sbNext',
\       },{
\         '__text__': 'sball',
\         'menu': '[command]',
\         'word': 'sball',
\       },{
\         '__text__': 'sbfirst',
\         'menu': '[command]',
\         'word': 'sbfirst',
\       },{
\         '__text__': 'sblast',
\         'menu': '[command]',
\         'word': 'sblast',
\       },{
\         '__text__': 'sbmodified',
\         'menu': '[command]',
\         'word': 'sbmodified',
\       },{
\         '__text__': 'sbnext',
\         'menu': '[command]',
\         'word': 'sbnext',
\       },{
\         '__text__': 'sbprevious',
\         'menu': '[command]',
\         'word': 'sbprevious',
\       },{
\         '__text__': 'sbrewind',
\         'menu': '[command]',
\         'word': 'sbrewind',
\       },{
\         '__text__': 'sbuffer',
\         'menu': '[command]',
\         'word': 'sbuffer',
\       },],
\     'sc': [{
\         '__text__': 'scriptencoding',
\         'menu': '[command]',
\         'word': 'scriptencoding',
\       },{
\         '__text__': 'scriptnames',
\         'menu': '[command]',
\         'word': 'scriptnames',
\       },{
\         '__text__': 'scscope',
\         'menu': '[command]',
\         'word': 'scscope',
\       },],
\     'se': [{
\         '__text__': 'setlocal',
\         'menu': '[command]',
\         'word': 'setlocal',
\       },{
\         '__text__': 'set',
\         'menu': '[command]',
\         'word': 'set',
\       },{
\         '__text__': 'setfiletype',
\         'menu': '[command]',
\         'word': 'setfiletype',
\       },{
\         '__text__': 'setglobal',
\         'menu': '[command]',
\         'word': 'setglobal',
\       },],
\     'sf': [{
\         '__text__': 'sfind',
\         'menu': '[command]',
\         'word': 'sfind',
\       },{
\         '__text__': 'sfirst',
\         'menu': '[command]',
\         'word': 'sfirst',
\       },],
\     'sh': [{
\         '__text__': 'shell',
\         'menu': '[command]',
\         'word': 'shell',
\       },],
\     'si': [{
\         '__text__': 'silent',
\         'menu': '[command]',
\         'word': 'silent',
\       },{
\         '__text__': 'sign',
\         'menu': '[command]',
\         'word': 'sign',
\       },{
\         '__text__': 'simalt',
\         'menu': '[command]',
\         'word': 'simalt',
\       },],
\     'sl': [{
\         '__text__': 'sleep',
\         'menu': '[command]',
\         'word': 'sleep',
\       },{
\         '__text__': 'slast',
\         'menu': '[command]',
\         'word': 'slast',
\       },],
\     'sm': [{
\         '__text__': 'smagic',
\         'menu': '[command]',
\         'word': 'smagic',
\       },{
\         '__text__': 'smap',
\         'menu': '[command]',
\         'word': 'smap',
\       },{
\         '__text__': 'smapclear',
\         'menu': '[command]',
\         'word': 'smapclear',
\       },{
\         '__text__': 'smenu',
\         'menu': '[command]',
\         'word': 'smenu',
\       },{
\         '__text__': 'smile',
\         'menu': '[command]',
\         'word': 'smile',
\       },],
\     'sn': [{
\         '__text__': 'snext',
\         'menu': '[command]',
\         'word': 'snext',
\       },{
\         '__text__': 'snomagic',
\         'menu': '[command]',
\         'word': 'snomagic',
\       },{
\         '__text__': 'snoremap',
\         'menu': '[command]',
\         'word': 'snoremap',
\       },{
\         '__text__': 'snoremenu',
\         'menu': '[command]',
\         'word': 'snoremenu',
\       },],
\     'so': [{
\         '__text__': 'source',
\         'menu': '[command]',
\         'word': 'source',
\       },{
\         '__text__': 'sort',
\         'menu': '[command]',
\         'word': 'sort',
\       },],
\     'sp': [{
\         '__text__': 'spelldump',
\         'menu': '[command]',
\         'word': 'spelldump',
\       },{
\         '__text__': 'spellgood',
\         'menu': '[command]',
\         'word': 'spellgood',
\       },{
\         '__text__': 'spellinfo',
\         'menu': '[command]',
\         'word': 'spellinfo',
\       },{
\         '__text__': 'spellrepall',
\         'menu': '[command]',
\         'word': 'spellrepall',
\       },{
\         '__text__': 'spellundo',
\         'menu': '[command]',
\         'word': 'spellundo',
\       },{
\         '__text__': 'spellwrong',
\         'menu': '[command]',
\         'word': 'spellwrong',
\       },{
\         '__text__': 'split',
\         'menu': '[command]',
\         'word': 'split',
\       },{
\         '__text__': 'sprevious',
\         'menu': '[command]',
\         'word': 'sprevious',
\       },],
\     'sr': [{
\         '__text__': 'srewind',
\         'menu': '[command]',
\         'word': 'srewind',
\       },],
\     'st': [{
\         '__text__': 'startinsert',
\         'menu': '[command]',
\         'word': 'startinsert',
\       },{
\         '__text__': 'stag',
\         'menu': '[command]',
\         'word': 'stag',
\       },{
\         '__text__': 'startgreplace',
\         'menu': '[command]',
\         'word': 'startgreplace',
\       },{
\         '__text__': 'startreplace',
\         'menu': '[command]',
\         'word': 'startreplace',
\       },{
\         '__text__': 'stjump',
\         'menu': '[command]',
\         'word': 'stjump',
\       },{
\         '__text__': 'stop',
\         'menu': '[command]',
\         'word': 'stop',
\       },{
\         '__text__': 'stopinsert',
\         'menu': '[command]',
\         'word': 'stopinsert',
\       },{
\         '__text__': 'stselect',
\         'menu': '[command]',
\         'word': 'stselect',
\       },],
\     'su': [{
\         '__text__': 'sunmap',
\         'menu': '[command]',
\         'word': 'sunmap',
\       },{
\         '__text__': 'substitute',
\         'menu': '[command]',
\         'word': 'substitute',
\       },{
\         '__text__': 'sunhide',
\         'menu': '[command]',
\         'word': 'sunhide',
\       },{
\         '__text__': 'sunmenu',
\         'menu': '[command]',
\         'word': 'sunmenu',
\       },{
\         '__text__': 'suspend',
\         'menu': '[command]',
\         'word': 'suspend',
\       },],
\     'sv': [{
\         '__text__': 'sview',
\         'menu': '[command]',
\         'word': 'sview',
\       },],
\     'sw': [{
\         '__text__': 'swapname',
\         'menu': '[command]',
\         'word': 'swapname',
\       },],
\     'sy': [{
\         '__text__': 'syntax',
\         'menu': '[command]',
\         'word': 'syntax',
\       },{
\         '__text__': 'syncbind',
\         'menu': '[command]',
\         'word': 'syncbind',
\       },{
\         '__text__': 'syntime',
\         'menu': '[command]',
\         'word': 'syntime',
\       },],
\     't': [{
\         '__text__': 't',
\         'menu': '[command]',
\         'word': 't',
\       },],
\     'tN': [{
\         '__text__': 'tNext',
\         'menu': '[command]',
\         'word': 'tNext',
\       },],
\     'ta': [{
\         '__text__': 'tabnew',
\         'menu': '[command]',
\         'word': 'tabnew',
\       },{
\         '__text__': 'tab',
\         'menu': '[command]',
\         'word': 'tab',
\       },{
\         '__text__': 'tabNext',
\         'menu': '[command]',
\         'word': 'tabNext',
\       },{
\         '__text__': 'tabclose',
\         'menu': '[command]',
\         'word': 'tabclose',
\       },{
\         '__text__': 'tabdo',
\         'menu': '[command]',
\         'word': 'tabdo',
\       },{
\         '__text__': 'tabedit',
\         'menu': '[command]',
\         'word': 'tabedit',
\       },{
\         '__text__': 'tabfind',
\         'menu': '[command]',
\         'word': 'tabfind',
\       },{
\         '__text__': 'tabfirst',
\         'menu': '[command]',
\         'word': 'tabfirst',
\       },{
\         '__text__': 'tablast',
\         'menu': '[command]',
\         'word': 'tablast',
\       },{
\         '__text__': 'tabmove',
\         'menu': '[command]',
\         'word': 'tabmove',
\       },{
\         '__text__': 'tabnext',
\         'menu': '[command]',
\         'word': 'tabnext',
\       },{
\         '__text__': 'tabonly',
\         'menu': '[command]',
\         'word': 'tabonly',
\       },{
\         '__text__': 'tabprevious',
\         'menu': '[command]',
\         'word': 'tabprevious',
\       },{
\         '__text__': 'tabrewind',
\         'menu': '[command]',
\         'word': 'tabrewind',
\       },{
\         '__text__': 'tabs',
\         'menu': '[command]',
\         'word': 'tabs',
\       },{
\         '__text__': 'tag',
\         'menu': '[command]',
\         'word': 'tag',
\       },{
\         '__text__': 'tags',
\         'menu': '[command]',
\         'word': 'tags',
\       },],
\     'tc': [{
\         '__text__': 'tcl',
\         'menu': '[command]',
\         'word': 'tcl',
\       },{
\         '__text__': 'tcldo',
\         'menu': '[command]',
\         'word': 'tcldo',
\       },{
\         '__text__': 'tclfile',
\         'menu': '[command]',
\         'word': 'tclfile',
\       },],
\     'te': [{
\         '__text__': 'tearoff',
\         'menu': '[command]',
\         'word': 'tearoff',
\       },{
\         '__text__': 'terminal',
\         'menu': '[command]',
\         'word': 'terminal',
\       },],
\     'tf': [{
\         '__text__': 'tfirst',
\         'menu': '[command]',
\         'word': 'tfirst',
\       },],
\     'th': [{
\         '__text__': 'throw',
\         'menu': '[command]',
\         'word': 'throw',
\       },],
\     'tj': [{
\         '__text__': 'tjump',
\         'menu': '[command]',
\         'word': 'tjump',
\       },],
\     'tl': [{
\         '__text__': 'tlast',
\         'menu': '[command]',
\         'word': 'tlast',
\       },],
\     'tm': [{
\         '__text__': 'tnoremap',
\         'menu': '[command]',
\         'word': 'tnoremap',
\       },{
\         '__text__': 'tmap',
\         'menu': '[command]',
\         'word': 'tmap',
\       },{
\         '__text__': 'tmapclear',
\         'menu': '[command]',
\         'word': 'tmapclear',
\       },{
\         '__text__': 'tmenu',
\         'menu': '[command]',
\         'word': 'tmenu',
\       },],
\     'tn': [{
\         '__text__': 'tnext',
\         'menu': '[command]',
\         'word': 'tnext',
\       },],
\     'to': [{
\         '__text__': 'topleft',
\         'menu': '[command]',
\         'word': 'topleft',
\       },],
\     'tp': [{
\         '__text__': 'tprevious',
\         'menu': '[command]',
\         'word': 'tprevious',
\       },],
\     'tr': [{
\         '__text__': 'try',
\         'menu': '[command]',
\         'word': 'try',
\       },{
\         '__text__': 'trewind',
\         'menu': '[command]',
\         'word': 'trewind',
\       },],
\     'ts': [{
\         '__text__': 'tselect',
\         'menu': '[command]',
\         'word': 'tselect',
\       },],
\     'tu': [{
\         '__text__': 'tunmap',
\         'menu': '[command]',
\         'word': 'tunmap',
\       },{
\         '__text__': 'tunmenu',
\         'menu': '[command]',
\         'word': 'tunmenu',
\       },],
\     'un': [{
\         '__text__': 'unlet',
\         'menu': '[command]',
\         'word': 'unlet',
\       },{
\         '__text__': 'unlockvar',
\         'menu': '[command]',
\         'word': 'unlockvar',
\       },{
\         '__text__': 'unabbreviate',
\         'menu': '[command]',
\         'word': 'unabbreviate',
\       },{
\         '__text__': 'undo',
\         'menu': '[command]',
\         'word': 'undo',
\       },{
\         '__text__': 'undojoin',
\         'menu': '[command]',
\         'word': 'undojoin',
\       },{
\         '__text__': 'undolist',
\         'menu': '[command]',
\         'word': 'undolist',
\       },{
\         '__text__': 'unhide',
\         'menu': '[command]',
\         'word': 'unhide',
\       },{
\         '__text__': 'unmap',
\         'menu': '[command]',
\         'word': 'unmap',
\       },{
\         '__text__': 'unmenu',
\         'menu': '[command]',
\         'word': 'unmenu',
\       },{
\         '__text__': 'unsilent',
\         'menu': '[command]',
\         'word': 'unsilent',
\       },],
\     'up': [{
\         '__text__': 'update',
\         'menu': '[command]',
\         'word': 'update',
\       },],
\     've': [{
\         '__text__': 'vertical',
\         'menu': '[command]',
\         'word': 'vertical',
\       },{
\         '__text__': 'version',
\         'menu': '[command]',
\         'word': 'version',
\       },{
\         '__text__': 'verbose',
\         'menu': '[command]',
\         'word': 'verbose',
\       },],
\     'vg': [{
\         '__text__': 'vglobal',
\         'menu': '[command]',
\         'word': 'vglobal',
\       },],
\     'vi': [{
\         '__text__': 'view',
\         'menu': '[command]',
\         'word': 'view',
\       },{
\         '__text__': 'vimgrep',
\         'menu': '[command]',
\         'word': 'vimgrep',
\       },{
\         '__text__': 'vimgrepadd',
\         'menu': '[command]',
\         'word': 'vimgrepadd',
\       },{
\         '__text__': 'visual',
\         'menu': '[command]',
\         'word': 'visual',
\       },{
\         '__text__': 'viusage',
\         'menu': '[command]',
\         'word': 'viusage',
\       },],
\     'vm': [{
\         '__text__': 'vmap',
\         'menu': '[command]',
\         'word': 'vmap',
\       },{
\         '__text__': 'vmapclear',
\         'menu': '[command]',
\         'word': 'vmapclear',
\       },{
\         '__text__': 'vmenu',
\         'menu': '[command]',
\         'word': 'vmenu',
\       },],
\     'vn': [{
\         '__text__': 'vnoremap',
\         'menu': '[command]',
\         'word': 'vnoremap',
\       },{
\         '__text__': 'vnew',
\         'menu': '[command]',
\         'word': 'vnew',
\       },{
\         '__text__': 'vnoremenu',
\         'menu': '[command]',
\         'word': 'vnoremenu',
\       },],
\     'vs': [{
\         '__text__': 'vsplit',
\         'menu': '[command]',
\         'word': 'vsplit',
\       },],
\     'vu': [{
\         '__text__': 'vunmap',
\         'menu': '[command]',
\         'word': 'vunmap',
\       },{
\         '__text__': 'vunmenu',
\         'menu': '[command]',
\         'word': 'vunmenu',
\       },],
\     'wN': [{
\         '__text__': 'wNext',
\         'menu': '[command]',
\         'word': 'wNext',
\       },],
\     'wa': [{
\         '__text__': 'wall',
\         'menu': '[command]',
\         'word': 'wall',
\       },],
\     'wh': [{
\         '__text__': 'while',
\         'menu': '[command]',
\         'word': 'while',
\       },],
\     'wi': [{
\         '__text__': 'wincmd',
\         'menu': '[command]',
\         'word': 'wincmd',
\       },{
\         '__text__': 'windo',
\         'menu': '[command]',
\         'word': 'windo',
\       },{
\         '__text__': 'winpos',
\         'menu': '[command]',
\         'word': 'winpos',
\       },{
\         '__text__': 'winsize',
\         'menu': '[command]',
\         'word': 'winsize',
\       },],
\     'wn': [{
\         '__text__': 'wnext',
\         'menu': '[command]',
\         'word': 'wnext',
\       },],
\     'wp': [{
\         '__text__': 'wprevious',
\         'menu': '[command]',
\         'word': 'wprevious',
\       },],
\     'wq': [{
\         '__text__': 'wq',
\         'menu': '[command]',
\         'word': 'wq',
\       },{
\         '__text__': 'wqall',
\         'menu': '[command]',
\         'word': 'wqall',
\       },],
\     'wr': [{
\         '__text__': 'write',
\         'menu': '[command]',
\         'word': 'write',
\       },],
\     'ws': [{
\         '__text__': 'wsverb',
\         'menu': '[command]',
\         'word': 'wsverb',
\       },],
\     'wu': [{
\         '__text__': 'wundo',
\         'menu': '[command]',
\         'word': 'wundo',
\       },],
\     'wv': [{
\         '__text__': 'wviminfo',
\         'menu': '[command]',
\         'word': 'wviminfo',
\       },],
\     'xa': [{
\         '__text__': 'xall',
\         'menu': '[command]',
\         'word': 'xall',
\       },],
\     'xi': [{
\         '__text__': 'xit',
\         'menu': '[command]',
\         'word': 'xit',
\       },],
\     'xm': [{
\         '__text__': 'xmap',
\         'menu': '[command]',
\         'word': 'xmap',
\       },{
\         '__text__': 'xmapclear',
\         'menu': '[command]',
\         'word': 'xmapclear',
\       },{
\         '__text__': 'xmenu',
\         'menu': '[command]',
\         'word': 'xmenu',
\       },],
\     'xn': [{
\         '__text__': 'xnoremap',
\         'menu': '[command]',
\         'word': 'xnoremap',
\       },{
\         '__text__': 'xnoremenu',
\         'menu': '[command]',
\         'word': 'xnoremenu',
\       },],
\     'xu': [{
\         '__text__': 'xunmap',
\         'menu': '[command]',
\         'word': 'xunmap',
\       },{
\         '__text__': 'xunmenu',
\         'menu': '[command]',
\         'word': 'xunmenu',
\       },],
\     'ya': [{
\         '__text__': 'yank',
\         'menu': '[command]',
\         'word': 'yank',
\       },],
\     'z': [{
\         '__text__': 'z',
\         'menu': '[command]',
\         'word': 'z',
\       },],
\   },
\   'indexlen': 2,
\   'name': 'command',
\   'wordlist': ['Next','abbreviate','abclear','aboveleft','all','amenu','anoremenu','append','argadd','argdelete','argdo','argedit','argglobal','arglocal','args','argument','ascii','augroup','aunmenu','autocmd','bNext','badd','ball','bdelete','behave','belowright','bfirst','blast','bmodified','bnext','botright','bprevious','break','breakadd','breakdel','breaklist','brewind','browse','bufdo','buffer','buffers','bunload','bwipeout','cNext','cNfile','cabbrev','cabclear','caddbuffer','caddexpr','caddfile','call','catch','cbottom','cbuffer','cc','cclose','cd','cdo','center','cexpr','cfdo','cfile','cfirst','cgetbuffer','cgetexpr','cgetfile','change','changes','chdir','checkpath','checktime','chistory','clast','clearjumps','clist','close','cmap','cmapclear','cmenu','cnewer','cnext','cnfile','cnoreabbrev','cnoremap','cnoremenu','colder','colorscheme','comclear','command','compiler','confirm','continue','copen','copy','cpfile','cprevious','cquit','crewind','cscope','cstag','cunabbrev','cunmap','cunmenu','cwindow','debug','debuggreedy','delcommand','delete','delfunction','delmarks','diffget','diffoff','diffpatch','diffput','diffsplit','diffthis','diffupdate','digraphs','display','djump','dlist','doautoall','doautocmd','drop','dsearch','dsplit','earlier','echo','echoerr','echohl','echomsg','echon','edit','else','elseif','emenu','endfor','endfunction','endif','endtry','endwhile','enew','ex','execute','exit','exusage','file','files','filetype','filter','finally','find','finish','first','fixdel','fold','foldclose','folddoclosed','folddoopen','foldopen','for','function','global','goto','grep','grepadd','gui','gvim','hardcopy','help','helpclose','helpfind','helpgrep','helptags','hide','highlight','history','iabbrev','iabclear','if','ijump','ilist','imap','imapclear','imenu','inoreabbrev','inoremap','inoremenu','insert','intro','isearch','isplit','iunabbrev','iunmap','iunmenu','join','jumps','k','keepalt','keepjumps','keepmarks','keeppatterns','lNext','lNfile','laddbuffer','laddexpr','laddfile','language','last','later','lbottom','lbuffer','lcd','lchdir','lclose','lcscope','ldo','left','leftabove','let','lexpr','lfdo','lfile','lfirst','lgetbuffer','lgetexpr','lgetfile','lgrep','lgrepadd','lhelpgrep','lhistory','list','ll','llast','llist','lmake','lmap','lmapclear','lnewer','lnext','lnfile','lnoremap','loadkeymap','loadview','lockmarks','lockvar','lolder','lopen','lpfile','lprevious','lrewind','ls','ltag','lua','luado','luafile','lunmap','lvimgrep','lvimgrepadd','lwindow','make','map','mapclear','mark','marks','match','menu','menutranslate','messages','mkexrc','mksession','mkspell','mkview','mkvimrc','mode','move','mzfile','mzscheme','nbclose','nbkey','nbstart','new','next','nmap','nmapclear','nmenu','nnoremap','nnoremenu','noautocmd','nohlsearch','noreabbrev','noremap','noremenu','normal','noswapfile','number','nunmap','nunmenu','oldfiles','omap','omapclear','omenu','only','onoremap','onoremenu','open','options','ounmap','ounmenu','ownsyntax','packadd','packloadall','pclose','pedit','perl','perldo','pop','popup','ppop','preserve','previous','print','profdel','profile','promptfind','promptrepl','psearch','ptNext','ptag','ptfirst','ptjump','ptlast','ptnext','ptprevious','ptrewind','ptselect','put','pwd','py3','py3do','py3file','pydo','pyfile','python','python3','pythonx','pyx','pyxdo','pyxfile','qall','quit','quitall','read','recover','redir','redo','redraw','redrawstatus','registers','resize','retab','return','rewind','right','rightbelow','ruby','rubydo','rubyfile','rundo','runtime','rviminfo','sNext','sall','sandbox','sargument','saveas','sbNext','sball','sbfirst','sblast','sbmodified','sbnext','sbprevious','sbrewind','sbuffer','scriptencoding','scriptnames','scscope','set','setfiletype','setglobal','setlocal','sfind','sfirst','shell','sign','silent','simalt','slast','sleep','smagic','smap','smapclear','smenu','smile','snext','snomagic','snoremap','snoremenu','sort','source','spelldump','spellgood','spellinfo','spellrepall','spellundo','spellwrong','split','sprevious','srewind','stag','startgreplace','startinsert','startreplace','stjump','stop','stopinsert','stselect','substitute','sunhide','sunmap','sunmenu','suspend','sview','swapname','syncbind','syntax','syntime','t','tNext','tab','tabNext','tabclose','tabdo','tabedit','tabfind','tabfirst','tablast','tabmove','tabnew','tabnext','tabonly','tabprevious','tabrewind','tabs','tag','tags','tcl','tcldo','tclfile','tearoff','terminal','tfirst','throw','tjump','tlast','tmap','tmapclear','tmenu','tnext','tnoremap','topleft','tprevious','trewind','try','tselect','tunmap','tunmenu','unabbreviate','undo','undojoin','undolist','unhide','unlet','unlockvar','unmap','unmenu','unsilent','update','verbose','version','vertical','vglobal','view','vimgrep','vimgrepadd','visual','viusage','vmap','vmapclear','vmenu','vnew','vnoremap','vnoremenu','vsplit','vunmap','vunmenu','wNext','wall','while','wincmd','windo','winpos','winsize','wnext','wprevious','wq','wqall','write','wsverb','wundo','wviminfo','xall','xit','xmap','xmapclear','xmenu','xnoremap','xnoremenu','xunmap','xunmenu','yank','z',],
\ }
lockvar! s:command
let s:hicmdattr = {
\   'conditionlist': [{
\       'cursor_at': '\m\C^\s*hi\%[ghlight]!\?\s\+\%(\%(clear\|default\)\s\+\)\?\h\w*\s\+\%(\S\+=\S\+\s\+\)*\%(c\?term\|gui\)=\zs\S*\%#',
\       'priority': 384,
\     },],
\   'index': {
\     'N': [{
\         '__text__': 'NONE',
\         'menu': '[highlight]',
\         'word': 'NONE',
\       },],
\     'b': [{
\         '__text__': 'bold',
\         'menu': '[highlight]',
\         'word': 'bold',
\       },],
\     'i': [{
\         '__text__': 'inverse',
\         'menu': '[highlight]',
\         'word': 'inverse',
\       },{
\         '__text__': 'italic',
\         'menu': '[highlight]',
\         'word': 'italic',
\       },],
\     'r': [{
\         '__text__': 'reverse',
\         'menu': '[highlight]',
\         'word': 'reverse',
\       },],
\     's': [{
\         '__text__': 'standout',
\         'menu': '[highlight]',
\         'word': 'standout',
\       },],
\     'u': [{
\         '__text__': 'underline',
\         'menu': '[highlight]',
\         'word': 'underline',
\       },{
\         '__text__': 'undercurl',
\         'menu': '[highlight]',
\         'word': 'undercurl',
\       },],
\   },
\   'indexlen': 1,
\   'name': 'highlight',
\   'wordlist': ['bold','underline','undercurl','reverse','inverse','italic','standout','NONE',],
\ }
lockvar! s:hicmdattr
let s:higroup = {
\   'conditionlist': [{
\       'cursor_at': '\m\C^\s*hi\%[ghlight]!\?\s\+\%(\%(clear\|default\)\s\+\)\?\zs\%(\h\w*\)\?\%#',
\       'priority': 128,
\     },{
\       'cursor_at': '\m\C^\s*hi\%[ghlight]!\?\s\+\%(default\s\+\)\?link\s\+\%(\h\w*\s\+\)\?\zs\%(\h\w*\)\?\%#',
\       'priority': 128,
\     },{
\       'cursor_at': '\m\C\<matchadd\%(pos\)\?([''"]\zs\%(\h\w*\)\?\%#',
\       'priority': 256,
\     },{
\       'cursor_at': '\m\C^\s*[23]\?mat\%[ch]\s\+\zs\%(\h\w*\)\?\%#',
\       'priority': 256,
\     },{
\       'cursor_at': '\m^\%(\%([^"]*"[^"]*"\)*[^"]*"[^"]*\|\%([^'']*''[^'']*''\)*[^'']*''[^'']*\)\zs\<\a\{6,}\%#',
\       'in_string': 1,
\       'priority': 0,
\     },{
\       'cursor_at': '\m^\%(\%([^"]*"[^"]*"\)*[^"]*"[^"]*\|\%([^'']*''[^'']*''\)*[^'']*''[^'']*\)\zs\<\a\{6,}\%#',
\       'in_comment': 1,
\       'priority': 0,
\     },],
\   'index': {
\     'Bo': [{
\         '__text__': 'Boolean',
\         'menu': '[higroup]',
\         'word': 'Boolean',
\       },],
\     'Ch': [{
\         '__text__': 'Character',
\         'menu': '[higroup]',
\         'word': 'Character',
\       },],
\     'Co': [{
\         '__text__': 'Comment',
\         'menu': '[higroup]',
\         'word': 'Comment',
\       },{
\         '__text__': 'Conceal',
\         'menu': '[higroup]',
\         'word': 'Conceal',
\       },{
\         '__text__': 'Constant',
\         'menu': '[higroup]',
\         'word': 'Constant',
\       },{
\         '__text__': 'ColorColumn',
\         'menu': '[higroup]',
\         'word': 'ColorColumn',
\       },{
\         '__text__': 'Conditional',
\         'menu': '[higroup]',
\         'word': 'Conditional',
\       },],
\     'Cu': [{
\         '__text__': 'Cursor',
\         'menu': '[higroup]',
\         'word': 'Cursor',
\       },{
\         '__text__': 'CursorIM',
\         'menu': '[higroup]',
\         'word': 'CursorIM',
\       },{
\         '__text__': 'CursorLine',
\         'menu': '[higroup]',
\         'word': 'CursorLine',
\       },{
\         '__text__': 'CursorColumn',
\         'menu': '[higroup]',
\         'word': 'CursorColumn',
\       },{
\         '__text__': 'CursorLineNr',
\         'menu': '[higroup]',
\         'word': 'CursorLineNr',
\       },],
\     'De': [{
\         '__text__': 'Debug',
\         'menu': '[higroup]',
\         'word': 'Debug',
\       },{
\         '__text__': 'Define',
\         'menu': '[higroup]',
\         'word': 'Define',
\       },{
\         '__text__': 'Delimiter',
\         'menu': '[higroup]',
\         'word': 'Delimiter',
\       },],
\     'Di': [{
\         '__text__': 'DiffAdd',
\         'menu': '[higroup]',
\         'word': 'DiffAdd',
\       },{
\         '__text__': 'DiffText',
\         'menu': '[higroup]',
\         'word': 'DiffText',
\       },{
\         '__text__': 'Directory',
\         'menu': '[higroup]',
\         'word': 'Directory',
\       },{
\         '__text__': 'DiffChange',
\         'menu': '[higroup]',
\         'word': 'DiffChange',
\       },{
\         '__text__': 'DiffDelete',
\         'menu': '[higroup]',
\         'word': 'DiffDelete',
\       },],
\     'En': [{
\         '__text__': 'EndOfBuffer',
\         'menu': '[higroup]',
\         'word': 'EndOfBuffer',
\       },],
\     'Er': [{
\         '__text__': 'Error',
\         'menu': '[higroup]',
\         'word': 'Error',
\       },{
\         '__text__': 'ErrorMsg',
\         'menu': '[higroup]',
\         'word': 'ErrorMsg',
\       },],
\     'Ex': [{
\         '__text__': 'Exception',
\         'menu': '[higroup]',
\         'word': 'Exception',
\       },],
\     'Fl': [{
\         '__text__': 'Float',
\         'menu': '[higroup]',
\         'word': 'Float',
\       },],
\     'Fo': [{
\         '__text__': 'Folded',
\         'menu': '[higroup]',
\         'word': 'Folded',
\       },{
\         '__text__': 'FoldColumn',
\         'menu': '[higroup]',
\         'word': 'FoldColumn',
\       },],
\     'Fu': [{
\         '__text__': 'Function',
\         'menu': '[higroup]',
\         'word': 'Function',
\       },],
\     'Id': [{
\         '__text__': 'Identifier',
\         'menu': '[higroup]',
\         'word': 'Identifier',
\       },],
\     'Ig': [{
\         '__text__': 'Ignore',
\         'menu': '[higroup]',
\         'word': 'Ignore',
\       },],
\     'In': [{
\         '__text__': 'Include',
\         'menu': '[higroup]',
\         'word': 'Include',
\       },{
\         '__text__': 'IncSearch',
\         'menu': '[higroup]',
\         'word': 'IncSearch',
\       },],
\     'Ke': [{
\         '__text__': 'Keyword',
\         'menu': '[higroup]',
\         'word': 'Keyword',
\       },],
\     'La': [{
\         '__text__': 'Label',
\         'menu': '[higroup]',
\         'word': 'Label',
\       },],
\     'Li': [{
\         '__text__': 'LineNr',
\         'menu': '[higroup]',
\         'word': 'LineNr',
\       },],
\     'Ma': [{
\         '__text__': 'Macro',
\         'menu': '[higroup]',
\         'word': 'Macro',
\       },{
\         '__text__': 'MatchParen',
\         'menu': '[higroup]',
\         'word': 'MatchParen',
\       },],
\     'Me': [{
\         '__text__': 'Menu',
\         'menu': '[higroup]',
\         'word': 'Menu',
\       },],
\     'Mo': [{
\         '__text__': 'ModeMsg',
\         'menu': '[higroup]',
\         'word': 'ModeMsg',
\       },{
\         '__text__': 'MoreMsg',
\         'menu': '[higroup]',
\         'word': 'MoreMsg',
\       },],
\     'NO': [{
\         '__text__': 'NONE',
\         'menu': '[higroup]',
\         'word': 'NONE',
\       },],
\     'No': [{
\         '__text__': 'Normal',
\         'menu': '[higroup]',
\         'word': 'Normal',
\       },{
\         '__text__': 'NonText',
\         'menu': '[higroup]',
\         'word': 'NonText',
\       },],
\     'Nu': [{
\         '__text__': 'Number',
\         'menu': '[higroup]',
\         'word': 'Number',
\       },],
\     'Op': [{
\         '__text__': 'Operator',
\         'menu': '[higroup]',
\         'word': 'Operator',
\       },],
\     'Pm': [{
\         '__text__': 'Pmenu',
\         'menu': '[higroup]',
\         'word': 'Pmenu',
\       },{
\         '__text__': 'PmenuSel',
\         'menu': '[higroup]',
\         'word': 'PmenuSel',
\       },{
\         '__text__': 'PmenuSbar',
\         'menu': '[higroup]',
\         'word': 'PmenuSbar',
\       },{
\         '__text__': 'PmenuThumb',
\         'menu': '[higroup]',
\         'word': 'PmenuThumb',
\       },],
\     'Pr': [{
\         '__text__': 'PreProc',
\         'menu': '[higroup]',
\         'word': 'PreProc',
\       },{
\         '__text__': 'PreCondit',
\         'menu': '[higroup]',
\         'word': 'PreCondit',
\       },],
\     'Qu': [{
\         '__text__': 'Question',
\         'menu': '[higroup]',
\         'word': 'Question',
\       },],
\     'Re': [{
\         '__text__': 'Repeat',
\         'menu': '[higroup]',
\         'word': 'Repeat',
\       },],
\     'Sc': [{
\         '__text__': 'Scrollbar',
\         'menu': '[higroup]',
\         'word': 'Scrollbar',
\       },],
\     'Se': [{
\         '__text__': 'Search',
\         'menu': '[higroup]',
\         'word': 'Search',
\       },],
\     'Si': [{
\         '__text__': 'SignColumn',
\         'menu': '[higroup]',
\         'word': 'SignColumn',
\       },],
\     'Sp': [{
\         '__text__': 'Special',
\         'menu': '[higroup]',
\         'word': 'Special',
\       },{
\         '__text__': 'SpellBad',
\         'menu': '[higroup]',
\         'word': 'SpellBad',
\       },{
\         '__text__': 'SpellCap',
\         'menu': '[higroup]',
\         'word': 'SpellCap',
\       },{
\         '__text__': 'SpellRare',
\         'menu': '[higroup]',
\         'word': 'SpellRare',
\       },{
\         '__text__': 'SpecialKey',
\         'menu': '[higroup]',
\         'word': 'SpecialKey',
\       },{
\         '__text__': 'SpellLocal',
\         'menu': '[higroup]',
\         'word': 'SpellLocal',
\       },{
\         '__text__': 'SpecialChar',
\         'menu': '[higroup]',
\         'word': 'SpecialChar',
\       },{
\         '__text__': 'SpecialComment',
\         'menu': '[higroup]',
\         'word': 'SpecialComment',
\       },],
\     'St': [{
\         '__text__': 'String',
\         'menu': '[higroup]',
\         'word': 'String',
\       },{
\         '__text__': 'Statement',
\         'menu': '[higroup]',
\         'word': 'Statement',
\       },{
\         '__text__': 'Structure',
\         'menu': '[higroup]',
\         'word': 'Structure',
\       },{
\         '__text__': 'StatusLine',
\         'menu': '[higroup]',
\         'word': 'StatusLine',
\       },{
\         '__text__': 'StatusLineNC',
\         'menu': '[higroup]',
\         'word': 'StatusLineNC',
\       },{
\         '__text__': 'StorageClass',
\         'menu': '[higroup]',
\         'word': 'StorageClass',
\       },],
\     'Ta': [{
\         '__text__': 'Tag',
\         'menu': '[higroup]',
\         'word': 'Tag',
\       },{
\         '__text__': 'TabLine',
\         'menu': '[higroup]',
\         'word': 'TabLine',
\       },{
\         '__text__': 'TabLineSel',
\         'menu': '[higroup]',
\         'word': 'TabLineSel',
\       },{
\         '__text__': 'TabLineFill',
\         'menu': '[higroup]',
\         'word': 'TabLineFill',
\       },],
\     'Ti': [{
\         '__text__': 'Title',
\         'menu': '[higroup]',
\         'word': 'Title',
\       },],
\     'To': [{
\         '__text__': 'Todo',
\         'menu': '[higroup]',
\         'word': 'Todo',
\       },{
\         '__text__': 'Tooltip',
\         'menu': '[higroup]',
\         'word': 'Tooltip',
\       },],
\     'Ty': [{
\         '__text__': 'Type',
\         'menu': '[higroup]',
\         'word': 'Type',
\       },{
\         '__text__': 'Typedef',
\         'menu': '[higroup]',
\         'word': 'Typedef',
\       },],
\     'Un': [{
\         '__text__': 'Underlined',
\         'menu': '[higroup]',
\         'word': 'Underlined',
\       },],
\     'Ve': [{
\         '__text__': 'VertSplit',
\         'menu': '[higroup]',
\         'word': 'VertSplit',
\       },],
\     'Vi': [{
\         '__text__': 'Visual',
\         'menu': '[higroup]',
\         'word': 'Visual',
\       },{
\         '__text__': 'VisualNOS',
\         'menu': '[higroup]',
\         'word': 'VisualNOS',
\       },],
\     'Wa': [{
\         '__text__': 'WarningMsg',
\         'menu': '[higroup]',
\         'word': 'WarningMsg',
\       },],
\     'Wi': [{
\         '__text__': 'WildMenu',
\         'menu': '[higroup]',
\         'word': 'WildMenu',
\       },],
\     'lC': [{
\         '__text__': 'lCursor',
\         'menu': '[higroup]',
\         'word': 'lCursor',
\       },],
\   },
\   'indexlen': 2,
\   'name': 'higroup',
\   'wordlist': ['Boolean','Character','ColorColumn','Comment','Conceal','Conditional','Constant','Cursor','CursorColumn','CursorIM','CursorLine','CursorLineNr','Debug','Define','Delimiter','DiffAdd','DiffChange','DiffDelete','DiffText','Directory','EndOfBuffer','Error','ErrorMsg','Exception','Float','FoldColumn','Folded','Function','Identifier','Ignore','IncSearch','Include','Keyword','Label','LineNr','Macro','MatchParen','Menu','ModeMsg','MoreMsg','NONE','NonText','Normal','Number','Operator','Pmenu','PmenuSbar','PmenuSel','PmenuThumb','PreCondit','PreProc','Question','Repeat','Scrollbar','Search','SignColumn','Special','SpecialChar','SpecialComment','SpecialKey','SpellBad','SpellCap','SpellLocal','SpellRare','Statement','StatusLine','StatusLineNC','StorageClass','String','Structure','TabLine','TabLineFill','TabLineSel','Tag','Title','Todo','Tooltip','Type','Typedef','Underlined','VertSplit','Visual','VisualNOS','WarningMsg','WildMenu','lCursor',],
\ }
lockvar! s:higroup
let s:exists = {
\   'conditionlist': [{
\       'cursor_at': '\m\C\<exists([''"]\zs\%([&+$*:]\|##\?\)\?\%#',
\       'priority': 384,
\     },],
\   'index': {
\     '&': [{
\         '__text__': '&',
\         'menu': '[exists] &existing-option',
\         'word': '&',
\       },],
\     '+': [{
\         '__text__': '+',
\         'menu': '[exists] +available-option',
\         'word': '+',
\       },],
\     '$': [{
\         '__text__': '$',
\         'menu': '[exists] $ENVNAME',
\         'word': '$',
\       },],
\     '*': [{
\         '__text__': '*',
\         'menu': '[exists] *funcname',
\         'word': '*',
\       },],
\     ':': [{
\         '__text__': ':',
\         'menu': '[exists] :cmdname',
\         'word': ':',
\       },],
\     '#': [{
\         '__text__': '#',
\         'menu': '[exists] #Event/#Group',
\         'word': '#',
\       },{
\         '__text__': '##',
\         'menu': '[exists] ##SupportedEvent',
\         'word': '##',
\       },],
\   },
\   'indexlen': 1,
\   'name': 'exists',
\   'wordlist': [{
\       '__text__': '&',
\       'menu': '[exists] &existing-option',
\       'word': '&',
\     },{
\       '__text__': '+',
\       'menu': '[exists] +available-option',
\       'word': '+',
\     },{
\       '__text__': '$',
\       'menu': '[exists] $ENVNAME',
\       'word': '$',
\     },{
\       '__text__': '*',
\       'menu': '[exists] *funcname',
\       'word': '*',
\     },{
\       '__text__': ':',
\       'menu': '[exists] :cmdname',
\       'word': ':',
\     },{
\       '__text__': '#',
\       'menu': '[exists] #Event/#Group',
\       'word': '#',
\     },{
\       '__text__': '##',
\       'menu': '[exists] ##SupportedEvent',
\       'word': '##',
\     },],
\ }
lockvar! s:exists
let s:expandable = {
\   'conditionlist': [{
\       'cursor_at': '\m\Cexpand([''"]\zs\%(%\|#\d*\|<\a*\)\?\%#',
\       'priority': 256,
\     },],
\   'index': {
\     '#': [{
\         '__text__': '#',
\         'menu': '[expand]',
\         'word': '#',
\       },],
\     '%': [{
\         '__text__': '%',
\         'menu': '[expand]',
\         'word': '%',
\       },],
\     '<': [{
\         '__text__': '<abuf>',
\         'menu': '[expand]',
\         'word': '<abuf>',
\       },{
\         '__text__': '<cfile>',
\         'menu': '[expand]',
\         'word': '<cfile>',
\       },{
\         '__text__': '<afile>',
\         'menu': '[expand]',
\         'word': '<afile>',
\       },{
\         '__text__': '<sfile>',
\         'menu': '[expand]',
\         'word': '<sfile>',
\       },{
\         '__text__': '<slnum>',
\         'menu': '[expand]',
\         'word': '<slnum>',
\       },{
\         '__text__': '<cword>',
\         'menu': '[expand]',
\         'word': '<cword>',
\       },{
\         '__text__': '<cWORD>',
\         'menu': '[expand]',
\         'word': '<cWORD>',
\       },{
\         '__text__': '<client>',
\         'menu': '[expand]',
\         'word': '<client>',
\       },],
\   },
\   'indexlen': 1,
\   'name': 'expand',
\   'wordlist': ['%','#','<cfile>','<afile>','<abuf>','<sfile>','<slnum>','<cword>','<cWORD>','<client>',],
\ }
lockvar! s:expandable
let s:expandablemodifier = {
\   'conditionlist': [{
\       'cursor_at': '\m\Cexpand([''"]\%(%\|#\d*\|<\a*\)\%(:[phtre]\)*\zs:[phtre]\?\%#',
\       'priority': 256,
\     },],
\   'index': {
\     ':': [{
\         '__text__': ':p',
\         'menu': '[expand]',
\         'word': ':p',
\       },{
\         '__text__': ':h',
\         'menu': '[expand]',
\         'word': ':h',
\       },{
\         '__text__': ':t',
\         'menu': '[expand]',
\         'word': ':t',
\       },{
\         '__text__': ':r',
\         'menu': '[expand]',
\         'word': ':r',
\       },{
\         '__text__': ':e',
\         'menu': '[expand]',
\         'word': ':e',
\       },],
\   },
\   'indexlen': 1,
\   'name': 'expand',
\   'wordlist': [':p',':h',':t',':r',':e',],
\ }
lockvar! s:expandablemodifier
let s:vimvar = {
\   'conditionlist': [{
\       'cursor_at': '\m\Cv:\w*\%#',
\       'priority': 256,
\     },],
\   'index': {
\     'v:b': [{
\         '__text__': 'v:beval_col',
\         'menu': '[vimvar]',
\         'word': 'v:beval_col',
\       },{
\         '__text__': 'v:beval_lnum',
\         'menu': '[vimvar]',
\         'word': 'v:beval_lnum',
\       },{
\         '__text__': 'v:beval_text',
\         'menu': '[vimvar]',
\         'word': 'v:beval_text',
\       },{
\         '__text__': 'v:beval_bufnr',
\         'menu': '[vimvar]',
\         'word': 'v:beval_bufnr',
\       },{
\         '__text__': 'v:beval_winid',
\         'menu': '[vimvar]',
\         'word': 'v:beval_winid',
\       },{
\         '__text__': 'v:beval_winnr',
\         'menu': '[vimvar]',
\         'word': 'v:beval_winnr',
\       },],
\     'v:c': [{
\         '__text__': 'v:char',
\         'menu': '[vimvar]',
\         'word': 'v:char',
\       },{
\         '__text__': 'v:count',
\         'menu': '[vimvar]',
\         'word': 'v:count',
\       },{
\         '__text__': 'v:ctype',
\         'menu': '[vimvar]',
\         'word': 'v:ctype',
\       },{
\         '__text__': 'v:cmdarg',
\         'menu': '[vimvar]',
\         'word': 'v:cmdarg',
\       },{
\         '__text__': 'v:count1',
\         'menu': '[vimvar]',
\         'word': 'v:count1',
\       },{
\         '__text__': 'v:cmdbang',
\         'menu': '[vimvar]',
\         'word': 'v:cmdbang',
\       },{
\         '__text__': 'v:charconvert_to',
\         'menu': '[vimvar]',
\         'word': 'v:charconvert_to',
\       },{
\         '__text__': 'v:completed_item',
\         'menu': '[vimvar]',
\         'word': 'v:completed_item',
\       },{
\         '__text__': 'v:charconvert_from',
\         'menu': '[vimvar]',
\         'word': 'v:charconvert_from',
\       },],
\     'v:d': [{
\         '__text__': 'v:dying',
\         'menu': '[vimvar]',
\         'word': 'v:dying',
\       },],
\     'v:e': [{
\         '__text__': 'v:event',
\         'menu': '[vimvar]',
\         'word': 'v:event',
\       },{
\         '__text__': 'v:errmsg',
\         'menu': '[vimvar]',
\         'word': 'v:errmsg',
\       },{
\         '__text__': 'v:errors',
\         'menu': '[vimvar]',
\         'word': 'v:errors',
\       },{
\         '__text__': 'v:exception',
\         'menu': '[vimvar]',
\         'word': 'v:exception',
\       },],
\     'v:f': [{
\         '__text__': 'v:false',
\         'menu': '[vimvar]',
\         'word': 'v:false',
\       },{
\         '__text__': 'v:fname',
\         'menu': '[vimvar]',
\         'word': 'v:fname',
\       },{
\         '__text__': 'v:foldend',
\         'menu': '[vimvar]',
\         'word': 'v:foldend',
\       },{
\         '__text__': 'v:fname_in',
\         'menu': '[vimvar]',
\         'word': 'v:fname_in',
\       },{
\         '__text__': 'v:fname_new',
\         'menu': '[vimvar]',
\         'word': 'v:fname_new',
\       },{
\         '__text__': 'v:fname_out',
\         'menu': '[vimvar]',
\         'word': 'v:fname_out',
\       },{
\         '__text__': 'v:foldlevel',
\         'menu': '[vimvar]',
\         'word': 'v:foldlevel',
\       },{
\         '__text__': 'v:foldstart',
\         'menu': '[vimvar]',
\         'word': 'v:foldstart',
\       },{
\         '__text__': 'v:fcs_choice',
\         'menu': '[vimvar]',
\         'word': 'v:fcs_choice',
\       },{
\         '__text__': 'v:fcs_reason',
\         'menu': '[vimvar]',
\         'word': 'v:fcs_reason',
\       },{
\         '__text__': 'v:fname_diff',
\         'menu': '[vimvar]',
\         'word': 'v:fname_diff',
\       },{
\         '__text__': 'v:folddashes',
\         'menu': '[vimvar]',
\         'word': 'v:folddashes',
\       },],
\     'v:h': [{
\         '__text__': 'v:hlsearch',
\         'menu': '[vimvar]',
\         'word': 'v:hlsearch',
\       },],
\     'v:i': [{
\         '__text__': 'v:insertmode',
\         'menu': '[vimvar]',
\         'word': 'v:insertmode',
\       },],
\     'v:k': [{
\         '__text__': 'v:key',
\         'menu': '[vimvar]',
\         'word': 'v:key',
\       },],
\     'v:l': [{
\         '__text__': 'v:lang',
\         'menu': '[vimvar]',
\         'word': 'v:lang',
\       },{
\         '__text__': 'v:lnum',
\         'menu': '[vimvar]',
\         'word': 'v:lnum',
\       },{
\         '__text__': 'v:lc_time',
\         'menu': '[vimvar]',
\         'word': 'v:lc_time',
\       },],
\     'v:m': [{
\         '__text__': 'v:mouse_col',
\         'menu': '[vimvar]',
\         'word': 'v:mouse_col',
\       },{
\         '__text__': 'v:mouse_win',
\         'menu': '[vimvar]',
\         'word': 'v:mouse_win',
\       },{
\         '__text__': 'v:mouse_lnum',
\         'menu': '[vimvar]',
\         'word': 'v:mouse_lnum',
\       },{
\         '__text__': 'v:mouse_winid',
\         'menu': '[vimvar]',
\         'word': 'v:mouse_winid',
\       },],
\     'v:n': [{
\         '__text__': 'v:none',
\         'menu': '[vimvar]',
\         'word': 'v:none',
\       },{
\         '__text__': 'v:null',
\         'menu': '[vimvar]',
\         'word': 'v:null',
\       },],
\     'v:o': [{
\         '__text__': 'v:oldfiles',
\         'menu': '[vimvar]',
\         'word': 'v:oldfiles',
\       },{
\         '__text__': 'v:operator',
\         'menu': '[vimvar]',
\         'word': 'v:operator',
\       },{
\         '__text__': 'v:option_new',
\         'menu': '[vimvar]',
\         'word': 'v:option_new',
\       },{
\         '__text__': 'v:option_old',
\         'menu': '[vimvar]',
\         'word': 'v:option_old',
\       },{
\         '__text__': 'v:option_type',
\         'menu': '[vimvar]',
\         'word': 'v:option_type',
\       },],
\     'v:p': [{
\         '__text__': 'v:progname',
\         'menu': '[vimvar]',
\         'word': 'v:progname',
\       },{
\         '__text__': 'v:progpath',
\         'menu': '[vimvar]',
\         'word': 'v:progpath',
\       },{
\         '__text__': 'v:prevcount',
\         'menu': '[vimvar]',
\         'word': 'v:prevcount',
\       },{
\         '__text__': 'v:profiling',
\         'menu': '[vimvar]',
\         'word': 'v:profiling',
\       },],
\     'v:r': [{
\         '__text__': 'v:register',
\         'menu': '[vimvar]',
\         'word': 'v:register',
\       },],
\     'v:s': [{
\         '__text__': 'v:swapname',
\         'menu': '[vimvar]',
\         'word': 'v:swapname',
\       },{
\         '__text__': 'v:statusmsg',
\         'menu': '[vimvar]',
\         'word': 'v:statusmsg',
\       },{
\         '__text__': 'v:servername',
\         'menu': '[vimvar]',
\         'word': 'v:servername',
\       },{
\         '__text__': 'v:swapchoice',
\         'menu': '[vimvar]',
\         'word': 'v:swapchoice',
\       },{
\         '__text__': 'v:scrollstart',
\         'menu': '[vimvar]',
\         'word': 'v:scrollstart',
\       },{
\         '__text__': 'v:shell_error',
\         'menu': '[vimvar]',
\         'word': 'v:shell_error',
\       },{
\         '__text__': 'v:swapcommand',
\         'menu': '[vimvar]',
\         'word': 'v:swapcommand',
\       },{
\         '__text__': 'v:searchforward',
\         'menu': '[vimvar]',
\         'word': 'v:searchforward',
\       },],
\     'v:t': [{
\         '__text__': 'v:true',
\         'menu': '[vimvar]',
\         'word': 'v:true',
\       },{
\         '__text__': 'v:t_job',
\         'menu': '[vimvar]',
\         'word': 'v:t_job',
\       },{
\         '__text__': 'v:t_bool',
\         'menu': '[vimvar]',
\         'word': 'v:t_bool',
\       },{
\         '__text__': 'v:t_dict',
\         'menu': '[vimvar]',
\         'word': 'v:t_dict',
\       },{
\         '__text__': 'v:t_func',
\         'menu': '[vimvar]',
\         'word': 'v:t_func',
\       },{
\         '__text__': 'v:t_list',
\         'menu': '[vimvar]',
\         'word': 'v:t_list',
\       },{
\         '__text__': 'v:t_none',
\         'menu': '[vimvar]',
\         'word': 'v:t_none',
\       },{
\         '__text__': 'v:t_float',
\         'menu': '[vimvar]',
\         'word': 'v:t_float',
\       },{
\         '__text__': 'v:testing',
\         'menu': '[vimvar]',
\         'word': 'v:testing',
\       },{
\         '__text__': 'v:t_number',
\         'menu': '[vimvar]',
\         'word': 'v:t_number',
\       },{
\         '__text__': 'v:t_string',
\         'menu': '[vimvar]',
\         'word': 'v:t_string',
\       },{
\         '__text__': 'v:t_channel',
\         'menu': '[vimvar]',
\         'word': 'v:t_channel',
\       },{
\         '__text__': 'v:termu7resp',
\         'menu': '[vimvar]',
\         'word': 'v:termu7resp',
\       },{
\         '__text__': 'v:throwpoint',
\         'menu': '[vimvar]',
\         'word': 'v:throwpoint',
\       },{
\         '__text__': 'v:termrbgresp',
\         'menu': '[vimvar]',
\         'word': 'v:termrbgresp',
\       },{
\         '__text__': 'v:termrfgresp',
\         'menu': '[vimvar]',
\         'word': 'v:termrfgresp',
\       },{
\         '__text__': 'v:termresponse',
\         'menu': '[vimvar]',
\         'word': 'v:termresponse',
\       },{
\         '__text__': 'v:this_session',
\         'menu': '[vimvar]',
\         'word': 'v:this_session',
\       },{
\         '__text__': 'v:termblinkresp',
\         'menu': '[vimvar]',
\         'word': 'v:termblinkresp',
\       },{
\         '__text__': 'v:termstyleresp',
\         'menu': '[vimvar]',
\         'word': 'v:termstyleresp',
\       },],
\     'v:v': [{
\         '__text__': 'v:val',
\         'menu': '[vimvar]',
\         'word': 'v:val',
\       },{
\         '__text__': 'v:version',
\         'menu': '[vimvar]',
\         'word': 'v:version',
\       },{
\         '__text__': 'v:vim_did_enter',
\         'menu': '[vimvar]',
\         'word': 'v:vim_did_enter',
\       },],
\     'v:w': [{
\         '__text__': 'v:windowid',
\         'menu': '[vimvar]',
\         'word': 'v:windowid',
\       },{
\         '__text__': 'v:warningmsg',
\         'menu': '[vimvar]',
\         'word': 'v:warningmsg',
\       },],
\   },
\   'indexlen': 3,
\   'name': 'vimvar',
\   'wordlist': ['v:beval_bufnr','v:beval_col','v:beval_lnum','v:beval_text','v:beval_winid','v:beval_winnr','v:char','v:charconvert_from','v:charconvert_to','v:cmdarg','v:cmdbang','v:completed_item','v:count','v:count1','v:ctype','v:dying','v:errmsg','v:errors','v:event','v:exception','v:false','v:fcs_choice','v:fcs_reason','v:fname','v:fname_diff','v:fname_in','v:fname_new','v:fname_out','v:folddashes','v:foldend','v:foldlevel','v:foldstart','v:hlsearch','v:insertmode','v:key','v:lang','v:lc_time','v:lnum','v:mouse_col','v:mouse_lnum','v:mouse_win','v:mouse_winid','v:none','v:null','v:oldfiles','v:operator','v:option_new','v:option_old','v:option_type','v:prevcount','v:profiling','v:progname','v:progpath','v:register','v:scrollstart','v:searchforward','v:servername','v:shell_error','v:statusmsg','v:swapchoice','v:swapcommand','v:swapname','v:t_bool','v:t_channel','v:t_dict','v:t_float','v:t_func','v:t_job','v:t_list','v:t_none','v:t_number','v:t_string','v:termblinkresp','v:termrbgresp','v:termresponse','v:termrfgresp','v:termstyleresp','v:termu7resp','v:testing','v:this_session','v:throwpoint','v:true','v:val','v:version','v:vim_did_enter','v:warningmsg','v:windowid',],
\ }
lockvar! s:vimvar
let s:feature = {
\   'conditionlist': [{
\       'cursor_at': '\<has([''"]\zs\w*\%#',
\       'priority': 384,
\     },],
\   'index': {
\     'a': [{
\         '__text__': 'acl',
\         'menu': '[feature]',
\         'word': 'acl',
\       },{
\         '__text__': 'all_builtin_terms',
\         'menu': '[feature]',
\         'word': 'all_builtin_terms',
\       },{
\         '__text__': 'amiga',
\         'menu': '[feature]',
\         'word': 'amiga',
\       },{
\         '__text__': 'arabic',
\         'menu': '[feature]',
\         'word': 'arabic',
\       },{
\         '__text__': 'arp',
\         'menu': '[feature]',
\         'word': 'arp',
\       },{
\         '__text__': 'autocmd',
\         'menu': '[feature]',
\         'word': 'autocmd',
\       },{
\         '__text__': 'autoservername',
\         'menu': '[feature]',
\         'word': 'autoservername',
\       },],
\     'b': [{
\         '__text__': 'balloon_eval',
\         'menu': '[feature]',
\         'word': 'balloon_eval',
\       },{
\         '__text__': 'balloon_multiline',
\         'menu': '[feature]',
\         'word': 'balloon_multiline',
\       },{
\         '__text__': 'beos',
\         'menu': '[feature]',
\         'word': 'beos',
\       },{
\         '__text__': 'browse',
\         'menu': '[feature]',
\         'word': 'browse',
\       },{
\         '__text__': 'browsefilter',
\         'menu': '[feature]',
\         'word': 'browsefilter',
\       },{
\         '__text__': 'builtin_terms',
\         'menu': '[feature]',
\         'word': 'builtin_terms',
\       },{
\         '__text__': 'byte_offset',
\         'menu': '[feature]',
\         'word': 'byte_offset',
\       },],
\     'c': [{
\         '__text__': 'cindent',
\         'menu': '[feature]',
\         'word': 'cindent',
\       },{
\         '__text__': 'clientserver',
\         'menu': '[feature]',
\         'word': 'clientserver',
\       },{
\         '__text__': 'clipboard',
\         'menu': '[feature]',
\         'word': 'clipboard',
\       },{
\         '__text__': 'cmdline_compl',
\         'menu': '[feature]',
\         'word': 'cmdline_compl',
\       },{
\         '__text__': 'cmdline_hist',
\         'menu': '[feature]',
\         'word': 'cmdline_hist',
\       },{
\         '__text__': 'cmdline_info',
\         'menu': '[feature]',
\         'word': 'cmdline_info',
\       },{
\         '__text__': 'comments',
\         'menu': '[feature]',
\         'word': 'comments',
\       },{
\         '__text__': 'compatible',
\         'menu': '[feature]',
\         'word': 'compatible',
\       },{
\         '__text__': 'cryptv',
\         'menu': '[feature]',
\         'word': 'cryptv',
\       },{
\         '__text__': 'cscope',
\         'menu': '[feature]',
\         'word': 'cscope',
\       },],
\     'd': [{
\         '__text__': 'debug',
\         'menu': '[feature]',
\         'word': 'debug',
\       },{
\         '__text__': 'dialog_con',
\         'menu': '[feature]',
\         'word': 'dialog_con',
\       },{
\         '__text__': 'dialog_gui',
\         'menu': '[feature]',
\         'word': 'dialog_gui',
\       },{
\         '__text__': 'diff',
\         'menu': '[feature]',
\         'word': 'diff',
\       },{
\         '__text__': 'digraphs',
\         'menu': '[feature]',
\         'word': 'digraphs',
\       },{
\         '__text__': 'directx',
\         'menu': '[feature]',
\         'word': 'directx',
\       },{
\         '__text__': 'dnd',
\         'menu': '[feature]',
\         'word': 'dnd',
\       },],
\     'e': [{
\         '__text__': 'ebcdic',
\         'menu': '[feature]',
\         'word': 'ebcdic',
\       },{
\         '__text__': 'emacs_tags',
\         'menu': '[feature]',
\         'word': 'emacs_tags',
\       },{
\         '__text__': 'eval',
\         'menu': '[feature]',
\         'word': 'eval',
\       },{
\         '__text__': 'ex_extra',
\         'menu': '[feature]',
\         'word': 'ex_extra',
\       },{
\         '__text__': 'extra_search',
\         'menu': '[feature]',
\         'word': 'extra_search',
\       },],
\     'f': [{
\         '__text__': 'farsi',
\         'menu': '[feature]',
\         'word': 'farsi',
\       },{
\         '__text__': 'file_in_path',
\         'menu': '[feature]',
\         'word': 'file_in_path',
\       },{
\         '__text__': 'filterpipe',
\         'menu': '[feature]',
\         'word': 'filterpipe',
\       },{
\         '__text__': 'find_in_path',
\         'menu': '[feature]',
\         'word': 'find_in_path',
\       },{
\         '__text__': 'float',
\         'menu': '[feature]',
\         'word': 'float',
\       },{
\         '__text__': 'fname_case',
\         'menu': '[feature]',
\         'word': 'fname_case',
\       },{
\         '__text__': 'folding',
\         'menu': '[feature]',
\         'word': 'folding',
\       },{
\         '__text__': 'footer',
\         'menu': '[feature]',
\         'word': 'footer',
\       },{
\         '__text__': 'fork',
\         'menu': '[feature]',
\         'word': 'fork',
\       },],
\     'g': [{
\         '__text__': 'gettext',
\         'menu': '[feature]',
\         'word': 'gettext',
\       },{
\         '__text__': 'gui',
\         'menu': '[feature]',
\         'word': 'gui',
\       },{
\         '__text__': 'gui_athena',
\         'menu': '[feature]',
\         'word': 'gui_athena',
\       },{
\         '__text__': 'gui_gnome',
\         'menu': '[feature]',
\         'word': 'gui_gnome',
\       },{
\         '__text__': 'gui_gtk',
\         'menu': '[feature]',
\         'word': 'gui_gtk',
\       },{
\         '__text__': 'gui_gtk2',
\         'menu': '[feature]',
\         'word': 'gui_gtk2',
\       },{
\         '__text__': 'gui_gtk3',
\         'menu': '[feature]',
\         'word': 'gui_gtk3',
\       },{
\         '__text__': 'gui_mac',
\         'menu': '[feature]',
\         'word': 'gui_mac',
\       },{
\         '__text__': 'gui_motif',
\         'menu': '[feature]',
\         'word': 'gui_motif',
\       },{
\         '__text__': 'gui_photon',
\         'menu': '[feature]',
\         'word': 'gui_photon',
\       },{
\         '__text__': 'gui_running',
\         'menu': '[feature]',
\         'word': 'gui_running',
\       },{
\         '__text__': 'gui_win32',
\         'menu': '[feature]',
\         'word': 'gui_win32',
\       },{
\         '__text__': 'gui_win32s',
\         'menu': '[feature]',
\         'word': 'gui_win32s',
\       },],
\     'h': [{
\         '__text__': 'hangul_input',
\         'menu': '[feature]',
\         'word': 'hangul_input',
\       },],
\     'i': [{
\         '__text__': 'iconv',
\         'menu': '[feature]',
\         'word': 'iconv',
\       },{
\         '__text__': 'insert_expand',
\         'menu': '[feature]',
\         'word': 'insert_expand',
\       },],
\     'j': [{
\         '__text__': 'jumplist',
\         'menu': '[feature]',
\         'word': 'jumplist',
\       },],
\     'k': [{
\         '__text__': 'keymap',
\         'menu': '[feature]',
\         'word': 'keymap',
\       },],
\     'l': [{
\         '__text__': 'lambda',
\         'menu': '[feature]',
\         'word': 'lambda',
\       },{
\         '__text__': 'langmap',
\         'menu': '[feature]',
\         'word': 'langmap',
\       },{
\         '__text__': 'libcall',
\         'menu': '[feature]',
\         'word': 'libcall',
\       },{
\         '__text__': 'linebreak',
\         'menu': '[feature]',
\         'word': 'linebreak',
\       },{
\         '__text__': 'lispindent',
\         'menu': '[feature]',
\         'word': 'lispindent',
\       },{
\         '__text__': 'listcmds',
\         'menu': '[feature]',
\         'word': 'listcmds',
\       },{
\         '__text__': 'localmap',
\         'menu': '[feature]',
\         'word': 'localmap',
\       },{
\         '__text__': 'lua',
\         'menu': '[feature]',
\         'word': 'lua',
\       },],
\     'm': [{
\         '__text__': 'mac',
\         'menu': '[feature]',
\         'word': 'mac',
\       },{
\         '__text__': 'macunix',
\         'menu': '[feature]',
\         'word': 'macunix',
\       },{
\         '__text__': 'menu',
\         'menu': '[feature]',
\         'word': 'menu',
\       },{
\         '__text__': 'mksession',
\         'menu': '[feature]',
\         'word': 'mksession',
\       },{
\         '__text__': 'modify_fname',
\         'menu': '[feature]',
\         'word': 'modify_fname',
\       },{
\         '__text__': 'mouse',
\         'menu': '[feature]',
\         'word': 'mouse',
\       },{
\         '__text__': 'mouse_dec',
\         'menu': '[feature]',
\         'word': 'mouse_dec',
\       },{
\         '__text__': 'mouse_gpm',
\         'menu': '[feature]',
\         'word': 'mouse_gpm',
\       },{
\         '__text__': 'mouse_netterm',
\         'menu': '[feature]',
\         'word': 'mouse_netterm',
\       },{
\         '__text__': 'mouse_pterm',
\         'menu': '[feature]',
\         'word': 'mouse_pterm',
\       },{
\         '__text__': 'mouse_sysmouse',
\         'menu': '[feature]',
\         'word': 'mouse_sysmouse',
\       },{
\         '__text__': 'mouse_sgr',
\         'menu': '[feature]',
\         'word': 'mouse_sgr',
\       },{
\         '__text__': 'mouse_urxvt',
\         'menu': '[feature]',
\         'word': 'mouse_urxvt',
\       },{
\         '__text__': 'mouse_xterm',
\         'menu': '[feature]',
\         'word': 'mouse_xterm',
\       },{
\         '__text__': 'mouseshape',
\         'menu': '[feature]',
\         'word': 'mouseshape',
\       },{
\         '__text__': 'multi_byte',
\         'menu': '[feature]',
\         'word': 'multi_byte',
\       },{
\         '__text__': 'multi_byte_encoding',
\         'menu': '[feature]',
\         'word': 'multi_byte_encoding',
\       },{
\         '__text__': 'multi_byte_ime',
\         'menu': '[feature]',
\         'word': 'multi_byte_ime',
\       },{
\         '__text__': 'multi_lang',
\         'menu': '[feature]',
\         'word': 'multi_lang',
\       },{
\         '__text__': 'mzscheme',
\         'menu': '[feature]',
\         'word': 'mzscheme',
\       },],
\     'n': [{
\         '__text__': 'netbeans_enabled',
\         'menu': '[feature]',
\         'word': 'netbeans_enabled',
\       },{
\         '__text__': 'netbeans_intg',
\         'menu': '[feature]',
\         'word': 'netbeans_intg',
\       },{
\         '__text__': 'num64',
\         'menu': '[feature]',
\         'word': 'num64',
\       },],
\     'o': [{
\         '__text__': 'ole',
\         'menu': '[feature]',
\         'word': 'ole',
\       },{
\         '__text__': 'osx',
\         'menu': '[feature]',
\         'word': 'osx',
\       },{
\         '__text__': 'osxdarwin',
\         'menu': '[feature]',
\         'word': 'osxdarwin',
\       },],
\     'p': [{
\         '__text__': 'packages',
\         'menu': '[feature]',
\         'word': 'packages',
\       },{
\         '__text__': 'path_extra',
\         'menu': '[feature]',
\         'word': 'path_extra',
\       },{
\         '__text__': 'perl',
\         'menu': '[feature]',
\         'word': 'perl',
\       },{
\         '__text__': 'persistent_undo',
\         'menu': '[feature]',
\         'word': 'persistent_undo',
\       },{
\         '__text__': 'postscript',
\         'menu': '[feature]',
\         'word': 'postscript',
\       },{
\         '__text__': 'printer',
\         'menu': '[feature]',
\         'word': 'printer',
\       },{
\         '__text__': 'profile',
\         'menu': '[feature]',
\         'word': 'profile',
\       },{
\         '__text__': 'python',
\         'menu': '[feature]',
\         'word': 'python',
\       },{
\         '__text__': 'python_compiled',
\         'menu': '[feature]',
\         'word': 'python_compiled',
\       },{
\         '__text__': 'python_dynamic',
\         'menu': '[feature]',
\         'word': 'python_dynamic',
\       },{
\         '__text__': 'python3',
\         'menu': '[feature]',
\         'word': 'python3',
\       },{
\         '__text__': 'python3_compiled',
\         'menu': '[feature]',
\         'word': 'python3_compiled',
\       },{
\         '__text__': 'python3_dynamic',
\         'menu': '[feature]',
\         'word': 'python3_dynamic',
\       },{
\         '__text__': 'pythonx',
\         'menu': '[feature]',
\         'word': 'pythonx',
\       },],
\     'q': [{
\         '__text__': 'qnx',
\         'menu': '[feature]',
\         'word': 'qnx',
\       },{
\         '__text__': 'quickfix',
\         'menu': '[feature]',
\         'word': 'quickfix',
\       },],
\     'r': [{
\         '__text__': 'reltime',
\         'menu': '[feature]',
\         'word': 'reltime',
\       },{
\         '__text__': 'rightleft',
\         'menu': '[feature]',
\         'word': 'rightleft',
\       },{
\         '__text__': 'ruby',
\         'menu': '[feature]',
\         'word': 'ruby',
\       },],
\     's': [{
\         '__text__': 'scrollbind',
\         'menu': '[feature]',
\         'word': 'scrollbind',
\       },{
\         '__text__': 'showcmd',
\         'menu': '[feature]',
\         'word': 'showcmd',
\       },{
\         '__text__': 'signs',
\         'menu': '[feature]',
\         'word': 'signs',
\       },{
\         '__text__': 'smartindent',
\         'menu': '[feature]',
\         'word': 'smartindent',
\       },{
\         '__text__': 'spell',
\         'menu': '[feature]',
\         'word': 'spell',
\       },{
\         '__text__': 'startuptime',
\         'menu': '[feature]',
\         'word': 'startuptime',
\       },{
\         '__text__': 'statusline',
\         'menu': '[feature]',
\         'word': 'statusline',
\       },{
\         '__text__': 'sun_workshop',
\         'menu': '[feature]',
\         'word': 'sun_workshop',
\       },{
\         '__text__': 'syntax',
\         'menu': '[feature]',
\         'word': 'syntax',
\       },{
\         '__text__': 'syntax_items',
\         'menu': '[feature]',
\         'word': 'syntax_items',
\       },{
\         '__text__': 'system',
\         'menu': '[feature]',
\         'word': 'system',
\       },],
\     't': [{
\         '__text__': 'tag_binary',
\         'menu': '[feature]',
\         'word': 'tag_binary',
\       },{
\         '__text__': 'tag_old_static',
\         'menu': '[feature]',
\         'word': 'tag_old_static',
\       },{
\         '__text__': 'tag_any_white',
\         'menu': '[feature]',
\         'word': 'tag_any_white',
\       },{
\         '__text__': 'tcl',
\         'menu': '[feature]',
\         'word': 'tcl',
\       },{
\         '__text__': 'termguicolors',
\         'menu': '[feature]',
\         'word': 'termguicolors',
\       },{
\         '__text__': 'terminal',
\         'menu': '[feature]',
\         'word': 'terminal',
\       },{
\         '__text__': 'terminfo',
\         'menu': '[feature]',
\         'word': 'terminfo',
\       },{
\         '__text__': 'termresponse',
\         'menu': '[feature]',
\         'word': 'termresponse',
\       },{
\         '__text__': 'textobjects',
\         'menu': '[feature]',
\         'word': 'textobjects',
\       },{
\         '__text__': 'tgetent',
\         'menu': '[feature]',
\         'word': 'tgetent',
\       },{
\         '__text__': 'timers',
\         'menu': '[feature]',
\         'word': 'timers',
\       },{
\         '__text__': 'title',
\         'menu': '[feature]',
\         'word': 'title',
\       },{
\         '__text__': 'toolbar',
\         'menu': '[feature]',
\         'word': 'toolbar',
\       },{
\         '__text__': 'ttyin',
\         'menu': '[feature]',
\         'word': 'ttyin',
\       },{
\         '__text__': 'ttyout',
\         'menu': '[feature]',
\         'word': 'ttyout',
\       },],
\     'u': [{
\         '__text__': 'unix',
\         'menu': '[feature]',
\         'word': 'unix',
\       },{
\         '__text__': 'unnamedplus',
\         'menu': '[feature]',
\         'word': 'unnamedplus',
\       },{
\         '__text__': 'user_commands',
\         'menu': '[feature]',
\         'word': 'user_commands',
\       },],
\     'v': [{
\         '__text__': 'vcon',
\         'menu': '[feature]',
\         'word': 'vcon',
\       },{
\         '__text__': 'vertsplit',
\         'menu': '[feature]',
\         'word': 'vertsplit',
\       },{
\         '__text__': 'vim_starting',
\         'menu': '[feature]',
\         'word': 'vim_starting',
\       },{
\         '__text__': 'viminfo',
\         'menu': '[feature]',
\         'word': 'viminfo',
\       },{
\         '__text__': 'virtualedit',
\         'menu': '[feature]',
\         'word': 'virtualedit',
\       },{
\         '__text__': 'visual',
\         'menu': '[feature]',
\         'word': 'visual',
\       },{
\         '__text__': 'visualextra',
\         'menu': '[feature]',
\         'word': 'visualextra',
\       },{
\         '__text__': 'vms',
\         'menu': '[feature]',
\         'word': 'vms',
\       },{
\         '__text__': 'vreplace',
\         'menu': '[feature]',
\         'word': 'vreplace',
\       },],
\     'w': [{
\         '__text__': 'wildignore',
\         'menu': '[feature]',
\         'word': 'wildignore',
\       },{
\         '__text__': 'wildmenu',
\         'menu': '[feature]',
\         'word': 'wildmenu',
\       },{
\         '__text__': 'win32',
\         'menu': '[feature]',
\         'word': 'win32',
\       },{
\         '__text__': 'win32unix',
\         'menu': '[feature]',
\         'word': 'win32unix',
\       },{
\         '__text__': 'win64',
\         'menu': '[feature]',
\         'word': 'win64',
\       },{
\         '__text__': 'win95',
\         'menu': '[feature]',
\         'word': 'win95',
\       },{
\         '__text__': 'winaltkeys',
\         'menu': '[feature]',
\         'word': 'winaltkeys',
\       },{
\         '__text__': 'windows',
\         'menu': '[feature]',
\         'word': 'windows',
\       },{
\         '__text__': 'writebackup',
\         'menu': '[feature]',
\         'word': 'writebackup',
\       },],
\     'x': [{
\         '__text__': 'xfontset',
\         'menu': '[feature]',
\         'word': 'xfontset',
\       },{
\         '__text__': 'xim',
\         'menu': '[feature]',
\         'word': 'xim',
\       },{
\         '__text__': 'xpm',
\         'menu': '[feature]',
\         'word': 'xpm',
\       },{
\         '__text__': 'xpm_w32',
\         'menu': '[feature]',
\         'word': 'xpm_w32',
\       },{
\         '__text__': 'xsmp',
\         'menu': '[feature]',
\         'word': 'xsmp',
\       },{
\         '__text__': 'xsmp_interact',
\         'menu': '[feature]',
\         'word': 'xsmp_interact',
\       },{
\         '__text__': 'xterm_clipboard',
\         'menu': '[feature]',
\         'word': 'xterm_clipboard',
\       },{
\         '__text__': 'xterm_save',
\         'menu': '[feature]',
\         'word': 'xterm_save',
\       },{
\         '__text__': 'x11',
\         'menu': '[feature]',
\         'word': 'x11',
\       },],
\   },
\   'indexlen': 1,
\   'name': 'feature',
\   'wordlist': ['acl','all_builtin_terms','amiga','arabic','arp','autocmd','autoservername','balloon_eval','balloon_multiline','beos','browse','browsefilter','builtin_terms','byte_offset','cindent','clientserver','clipboard','cmdline_compl','cmdline_hist','cmdline_info','comments','compatible','cryptv','cscope','debug','dialog_con','dialog_gui','diff','digraphs','directx','dnd','ebcdic','emacs_tags','eval','ex_extra','extra_search','farsi','file_in_path','filterpipe','find_in_path','float','fname_case','folding','footer','fork','gettext','gui','gui_athena','gui_gnome','gui_gtk','gui_gtk2','gui_gtk3','gui_mac','gui_motif','gui_photon','gui_running','gui_win32','gui_win32s','hangul_input','iconv','insert_expand','jumplist','keymap','lambda','langmap','libcall','linebreak','lispindent','listcmds','localmap','lua','mac','macunix','menu','mksession','modify_fname','mouse','mouse_dec','mouse_gpm','mouse_netterm','mouse_pterm','mouse_sysmouse','mouse_sgr','mouse_urxvt','mouse_xterm','mouseshape','multi_byte','multi_byte_encoding','multi_byte_ime','multi_lang','mzscheme','netbeans_enabled','netbeans_intg','num64','ole','osx','osxdarwin','packages','path_extra','perl','persistent_undo','postscript','printer','profile','python','python_compiled','python_dynamic','python3','python3_compiled','python3_dynamic','pythonx','qnx','quickfix','reltime','rightleft','ruby','scrollbind','showcmd','signs','smartindent','spell','startuptime','statusline','sun_workshop','syntax','syntax_items','system','tag_binary','tag_old_static','tag_any_white','tcl','termguicolors','terminal','terminfo','termresponse','textobjects','tgetent','timers','title','toolbar','ttyin','ttyout','unix','unnamedplus','user_commands','vcon','vertsplit','vim_starting','viminfo','virtualedit','visual','visualextra','vms','vreplace','wildignore','wildmenu','win32','win32unix','win64','win95','winaltkeys','windows','writebackup','xfontset','xim','xpm','xpm_w32','xsmp','xsmp_interact','xterm_clipboard','xterm_save','x11',],
\ }
lockvar! s:feature
let s:commandattrnargs = {
\   'conditionlist': [{
\       'cursor_at': '\m\C^\s*command!\?\s\+\%(\%(-complete=\h\w*\%(,\S\+\)\?\|-range\%(=[%[:digit:]]\)\?\|-count=\d\+\|-addr=\h\w*\|-bang\|-bar\|-register\|-buffer\)\s\+\)*-nargs\zs\%(=[01*?+]\?\)\?\%#',
\       'priority': 256,
\     },],
\   'index': {
\     '=': [{
\         '__text__': '=0',
\         'menu': '[commandattr]',
\         'word': '=0',
\       },{
\         '__text__': '=1',
\         'menu': '[commandattr]',
\         'word': '=1',
\       },{
\         '__text__': '=*',
\         'menu': '[commandattr]',
\         'word': '=*',
\       },{
\         '__text__': '=?',
\         'menu': '[commandattr]',
\         'word': '=?',
\       },{
\         '__text__': '=+',
\         'menu': '[commandattr]',
\         'word': '=+',
\       },],
\   },
\   'indexlen': 1,
\   'name': 'commandattr',
\   'wordlist': ['=0','=1','=*','=?','=+',],
\ }
lockvar! s:commandattrnargs
let s:function = {
\   'conditionlist': [{
\       'cursor_at': '\m\C\<call\s\+\zs\<\%([gs]:\)\?\k*\%#',
\       'not_in_comment': 1,
\       'not_in_string': 1,
\       'priority': 384,
\     },{
\       'cursor_at': '\m\C\<call\s\+.*\zs\<\%([gs]:\)\?\k*\%#',
\       'not_in_comment': 1,
\       'not_in_string': 1,
\       'priority': 128,
\     },{
\       'cursor_at': '\m\C<[Cc]-[Rr]>=\zs\%([gs]:\|\%([gs]:\)\?\h\k*\)\?\%#',
\       'priority': 256,
\     },{
\       'cursor_at': '\m\C\<\%(call([''"]\|exists([''"]\*\)\zs\<\%([gs]:\|\%([gs]:\)\?\h\k*\)\?\%#',
\       'priority': 256,
\     },{
\       'cursor_at': '\m\C^\s*\%([nvxsoilc]\?\%(m\%[ap]\|no\%[remap]\)\|map!\|no\%[remap]!\)\s\+\%(<\%(buffer\|nowait\|silent\|special\|script\|unique\)>\s*\)*<expr>\s*\%(<\%(buffer\|nowait\|silent\|special\|script\|unique\)>\s*\)*\S\+\s\+\zs\%(\S*\)\?\%#',
\       'not_in_comment': 1,
\       'not_in_string': 1,
\       'priority': 256,
\     },{
\       'cursor_at': '\m\C^\s*let\s\+[^=]\{-}=\%(.*[^.:]\)\?\zs\<\%([gs]:\)\?\k*\%#',
\       'not_in_comment': 1,
\       'not_in_string': 1,
\       'priority': 128,
\     },{
\       'cursor_at': '\m\C\%(^\s*\|[^|]|\s\+\)com\%[mand!]\s\+\%(\%(-nargs=[01*?+]\|-range\%(=[%[:digit:]]\)\?\|-count=\d\+\|-addr=\h\w*\|-bang\|-bar\|-register\|-buffer\)\s\+\)*-complete=custom\%(list\)\?,\zs\S*\%#',
\       'priority': 256,
\     },{
\       'cursor_at': '\m\C^\s*\%(if\|elseif\?\|for\|wh\%[ile]\|retu\%[rn]\|exe\%[cute]\|ec\%[hon]\|echom\%[sg]\|echoe\%[rr]\)\s.*[:.&]\@1<!\zs\%(\<[gs]:\h\k*\|\<[gs]:\|\<\k*\)\%#',
\       'not_in_comment': 1,
\       'not_in_string': 1,
\       'priority': 128,
\     },{
\       'cursor_at': '\m\C^\s*[A-Z]\w*!\?\s.*[:.&]\@1<!\zs\%(\<[gs]:\h\k*\|\<[gs]:\|\<\k*\)\%#',
\       'not_in_comment': 1,
\       'not_in_string': 1,
\       'priority': 0,
\     },{
\       'cursor_at': '\m\C\%(<S\%[ID>]\|<SID>\h\w*\)\%#',
\       'priority': 0,
\     },{
\       'cursor_at': '\m\C\<\%([gs]:\h\k\{5,}\|\%([gs]:\)\?\h\k\{5,}\)\%#',
\       'in_string': 1,
\       'priority': 0,
\     },{
\       'cursor_at': '\m\C\<\%([gs]:\h\k\{5,}\|\%([gs]:\)\?\h\k\{5,}\)\%#',
\       'in_comment': 1,
\       'priority': 0,
\     },],
\   'index': {
\     'ab': [{
\         '__func__': 1,
\         '__text__': 'abs',
\         'abbr': 'abs({expr})',
\         'menu': '[function]',
\         'word': 'abs',
\       },],
\     'ac': [{
\         '__func__': 1,
\         '__text__': 'acos',
\         'abbr': 'acos({expr})',
\         'menu': '[function]',
\         'word': 'acos',
\       },],
\     'ad': [{
\         '__func__': 1,
\         '__text__': 'add',
\         'abbr': 'add({list}, {item})',
\         'menu': '[function]',
\         'word': 'add',
\       },],
\     'an': [{
\         '__func__': 1,
\         '__text__': 'and',
\         'abbr': 'and({expr}, {expr})',
\         'menu': '[function]',
\         'word': 'and',
\       },],
\     'ap': [{
\         '__func__': 1,
\         '__text__': 'append',
\         'abbr': 'append({lnum}, {string})',
\         'menu': '[function]',
\         'word': 'append',
\       },],
\     'ar': [{
\         '__func__': 1,
\         '__text__': 'argc',
\         'abbr': 'argc()',
\         'menu': '[function]',
\         'word': 'argc',
\       },{
\         '__func__': 1,
\         '__text__': 'argidx',
\         'abbr': 'argidx()',
\         'menu': '[function]',
\         'word': 'argidx',
\       },{
\         '__func__': 1,
\         '__text__': 'arglistid',
\         'abbr': 'arglistid([{winnr} [, {tabnr}]])',
\         'menu': '[function]',
\         'word': 'arglistid',
\       },{
\         '__func__': 1,
\         '__text__': 'argv',
\         'abbr': 'argv({nr})',
\         'menu': '[function]',
\         'word': 'argv',
\       },],
\     'as': [{
\         '__func__': 1,
\         '__text__': 'asin',
\         'abbr': 'asin({expr})',
\         'menu': '[function]',
\         'word': 'asin',
\       },{
\         '__func__': 1,
\         '__text__': 'assert_beeps',
\         'abbr': 'assert_beeps({cmd})',
\         'menu': '[function]',
\         'word': 'assert_beeps',
\       },{
\         '__func__': 1,
\         '__text__': 'assert_equal',
\         'abbr': 'assert_equal({exp}, {act} [, {msg}])',
\         'menu': '[function]',
\         'word': 'assert_equal',
\       },{
\         '__func__': 1,
\         '__text__': 'assert_equalfile',
\         'abbr': 'assert_equalfile({fname-one}, {fname-two})',
\         'menu': '[function]',
\         'word': 'assert_equalfile',
\       },{
\         '__func__': 1,
\         '__text__': 'assert_exception',
\         'abbr': 'assert_exception({error} [, {msg}])',
\         'menu': '[function]',
\         'word': 'assert_exception',
\       },{
\         '__func__': 1,
\         '__text__': 'assert_fails',
\         'abbr': 'assert_fails({cmd} [, {error}])',
\         'menu': '[function]',
\         'word': 'assert_fails',
\       },{
\         '__func__': 1,
\         '__text__': 'assert_false',
\         'abbr': 'assert_false({actual} [, {msg}])',
\         'menu': '[function]',
\         'word': 'assert_false',
\       },{
\         '__func__': 1,
\         '__text__': 'assert_inrange',
\         'abbr': 'assert_inrange({lower}, {upper}, {actual} [, {msg}])',
\         'menu': '[function]',
\         'word': 'assert_inrange',
\       },{
\         '__func__': 1,
\         '__text__': 'assert_match',
\         'abbr': 'assert_match({pat}, {text} [, {msg}])',
\         'menu': '[function]',
\         'word': 'assert_match',
\       },{
\         '__func__': 1,
\         '__text__': 'assert_notequal',
\         'abbr': 'assert_notequal({exp}, {act} [, {msg}])',
\         'menu': '[function]',
\         'word': 'assert_notequal',
\       },{
\         '__func__': 1,
\         '__text__': 'assert_notmatch',
\         'abbr': 'assert_notmatch({pat}, {text} [, {msg}])',
\         'menu': '[function]',
\         'word': 'assert_notmatch',
\       },{
\         '__func__': 1,
\         '__text__': 'assert_report',
\         'abbr': 'assert_report({msg})',
\         'menu': '[function]',
\         'word': 'assert_report',
\       },{
\         '__func__': 1,
\         '__text__': 'assert_true',
\         'abbr': 'assert_true({actual} [, {msg}])',
\         'menu': '[function]',
\         'word': 'assert_true',
\       },],
\     'at': [{
\         '__func__': 1,
\         '__text__': 'atan',
\         'abbr': 'atan({expr})',
\         'menu': '[function]',
\         'word': 'atan',
\       },{
\         '__func__': 1,
\         '__text__': 'atan2',
\         'abbr': 'atan2({expr1}, {expr2})',
\         'menu': '[function]',
\         'word': 'atan2',
\       },],
\     'ba': [{
\         '__func__': 1,
\         '__text__': 'balloon_show',
\         'abbr': 'balloon_show({expr})',
\         'menu': '[function]',
\         'word': 'balloon_show',
\       },],
\     'br': [{
\         '__func__': 1,
\         '__text__': 'browse',
\         'abbr': 'browse({save}, {title}, {initdir}, {default})',
\         'menu': '[function]',
\         'word': 'browse',
\       },{
\         '__func__': 1,
\         '__text__': 'browsedir',
\         'abbr': 'browsedir({title}, {initdir})',
\         'menu': '[function]',
\         'word': 'browsedir',
\       },],
\     'bu': [{
\         '__func__': 1,
\         '__text__': 'bufexists',
\         'abbr': 'bufexists({expr})',
\         'menu': '[function]',
\         'word': 'bufexists',
\       },{
\         '__text__': 'buffer_exists',
\         'menu': '[function]',
\         'word': 'buffer_exists',
\       },{
\         '__text__': 'buffer_name',
\         'menu': '[function]',
\         'word': 'buffer_name',
\       },{
\         '__text__': 'buffer_number',
\         'menu': '[function]',
\         'word': 'buffer_number',
\       },{
\         '__func__': 1,
\         '__text__': 'buflisted',
\         'abbr': 'buflisted({expr})',
\         'menu': '[function]',
\         'word': 'buflisted',
\       },{
\         '__func__': 1,
\         '__text__': 'bufloaded',
\         'abbr': 'bufloaded({expr})',
\         'menu': '[function]',
\         'word': 'bufloaded',
\       },{
\         '__func__': 1,
\         '__text__': 'bufname',
\         'abbr': 'bufname({expr})',
\         'menu': '[function]',
\         'word': 'bufname',
\       },{
\         '__func__': 1,
\         '__text__': 'bufnr',
\         'abbr': 'bufnr({expr} [, {create}])',
\         'menu': '[function]',
\         'word': 'bufnr',
\       },{
\         '__func__': 1,
\         '__text__': 'bufwinid',
\         'abbr': 'bufwinid({expr})',
\         'menu': '[function]',
\         'word': 'bufwinid',
\       },{
\         '__func__': 1,
\         '__text__': 'bufwinnr',
\         'abbr': 'bufwinnr({expr})',
\         'menu': '[function]',
\         'word': 'bufwinnr',
\       },],
\     'by': [{
\         '__func__': 1,
\         '__text__': 'byte2line',
\         'abbr': 'byte2line({byte})',
\         'menu': '[function]',
\         'word': 'byte2line',
\       },{
\         '__func__': 1,
\         '__text__': 'byteidx',
\         'abbr': 'byteidx({expr}, {nr})',
\         'menu': '[function]',
\         'word': 'byteidx',
\       },{
\         '__func__': 1,
\         '__text__': 'byteidxcomp',
\         'abbr': 'byteidxcomp({expr}, {nr})',
\         'menu': '[function]',
\         'word': 'byteidxcomp',
\       },],
\     'ca': [{
\         '__func__': 1,
\         '__text__': 'call',
\         'abbr': 'call({func}, {arglist} [, {dict}])',
\         'menu': '[function]',
\         'word': 'call',
\       },],
\     'ce': [{
\         '__func__': 1,
\         '__text__': 'ceil',
\         'abbr': 'ceil({expr})',
\         'menu': '[function]',
\         'word': 'ceil',
\       },],
\     'ch': [{
\         '__func__': 1,
\         '__text__': 'ch_canread',
\         'abbr': 'ch_canread({handle})',
\         'menu': '[function]',
\         'word': 'ch_canread',
\       },{
\         '__func__': 1,
\         '__text__': 'ch_close',
\         'abbr': 'ch_close({handle})',
\         'menu': '[function]',
\         'word': 'ch_close',
\       },{
\         '__func__': 1,
\         '__text__': 'ch_close_in',
\         'abbr': 'ch_close_in({handle})',
\         'menu': '[function]',
\         'word': 'ch_close_in',
\       },{
\         '__func__': 1,
\         '__text__': 'ch_evalexpr',
\         'abbr': 'ch_evalexpr({handle}, {expr} [, {options}])',
\         'menu': '[function]',
\         'word': 'ch_evalexpr',
\       },{
\         '__func__': 1,
\         '__text__': 'ch_evalraw',
\         'abbr': 'ch_evalraw({handle}, {string} [, {options}])',
\         'menu': '[function]',
\         'word': 'ch_evalraw',
\       },{
\         '__func__': 1,
\         '__text__': 'ch_getbufnr',
\         'abbr': 'ch_getbufnr({handle}, {what})',
\         'menu': '[function]',
\         'word': 'ch_getbufnr',
\       },{
\         '__func__': 1,
\         '__text__': 'ch_getjob',
\         'abbr': 'ch_getjob({channel})',
\         'menu': '[function]',
\         'word': 'ch_getjob',
\       },{
\         '__func__': 1,
\         '__text__': 'ch_info',
\         'abbr': 'ch_info({handle})',
\         'menu': '[function]',
\         'word': 'ch_info',
\       },{
\         '__func__': 1,
\         '__text__': 'ch_log',
\         'abbr': 'ch_log({msg} [, {handle}])',
\         'menu': '[function]',
\         'word': 'ch_log',
\       },{
\         '__func__': 1,
\         '__text__': 'ch_logfile',
\         'abbr': 'ch_logfile({fname} [, {mode}])',
\         'menu': '[function]',
\         'word': 'ch_logfile',
\       },{
\         '__func__': 1,
\         '__text__': 'ch_open',
\         'abbr': 'ch_open({address} [, {options}])',
\         'menu': '[function]',
\         'word': 'ch_open',
\       },{
\         '__func__': 1,
\         '__text__': 'ch_read',
\         'abbr': 'ch_read({handle} [, {options}])',
\         'menu': '[function]',
\         'word': 'ch_read',
\       },{
\         '__func__': 1,
\         '__text__': 'ch_readraw',
\         'abbr': 'ch_readraw({handle} [, {options}])',
\         'menu': '[function]',
\         'word': 'ch_readraw',
\       },{
\         '__func__': 1,
\         '__text__': 'ch_sendexpr',
\         'abbr': 'ch_sendexpr({handle}, {expr} [, {options}])',
\         'menu': '[function]',
\         'word': 'ch_sendexpr',
\       },{
\         '__func__': 1,
\         '__text__': 'ch_sendraw',
\         'abbr': 'ch_sendraw({handle}, {string} [, {options}])',
\         'menu': '[function]',
\         'word': 'ch_sendraw',
\       },{
\         '__func__': 1,
\         '__text__': 'ch_setoptions',
\         'abbr': 'ch_setoptions({handle}, {options})',
\         'menu': '[function]',
\         'word': 'ch_setoptions',
\       },{
\         '__func__': 1,
\         '__text__': 'ch_status',
\         'abbr': 'ch_status({handle} [, {options}])',
\         'menu': '[function]',
\         'word': 'ch_status',
\       },{
\         '__func__': 1,
\         '__text__': 'changenr',
\         'abbr': 'changenr()',
\         'menu': '[function]',
\         'word': 'changenr',
\       },{
\         '__func__': 1,
\         '__text__': 'char2nr',
\         'abbr': 'char2nr({expr} [, {utf8}])',
\         'menu': '[function]',
\         'word': 'char2nr',
\       },],
\     'ci': [{
\         '__func__': 1,
\         '__text__': 'cindent',
\         'abbr': 'cindent({lnum})',
\         'menu': '[function]',
\         'word': 'cindent',
\       },],
\     'cl': [{
\         '__func__': 1,
\         '__text__': 'clearmatches',
\         'abbr': 'clearmatches()',
\         'menu': '[function]',
\         'word': 'clearmatches',
\       },],
\     'co': [{
\         '__func__': 1,
\         '__text__': 'col',
\         'abbr': 'col({expr})',
\         'menu': '[function]',
\         'word': 'col',
\       },{
\         '__func__': 1,
\         '__text__': 'complete',
\         'abbr': 'complete({startcol}, {matches})',
\         'menu': '[function]',
\         'word': 'complete',
\       },{
\         '__func__': 1,
\         '__text__': 'complete_add',
\         'abbr': 'complete_add({expr})',
\         'menu': '[function]',
\         'word': 'complete_add',
\       },{
\         '__func__': 1,
\         '__text__': 'complete_check',
\         'abbr': 'complete_check()',
\         'menu': '[function]',
\         'word': 'complete_check',
\       },{
\         '__func__': 1,
\         '__text__': 'confirm',
\         'abbr': 'confirm({msg} [, {choices} [, {default} [, {type}]]])',
\         'menu': '[function]',
\         'word': 'confirm',
\       },{
\         '__func__': 1,
\         '__text__': 'copy',
\         'abbr': 'copy({expr})',
\         'menu': '[function]',
\         'word': 'copy',
\       },{
\         '__func__': 1,
\         '__text__': 'cos',
\         'abbr': 'cos({expr})',
\         'menu': '[function]',
\         'word': 'cos',
\       },{
\         '__func__': 1,
\         '__text__': 'cosh',
\         'abbr': 'cosh({expr})',
\         'menu': '[function]',
\         'word': 'cosh',
\       },{
\         '__func__': 1,
\         '__text__': 'count',
\         'abbr': 'count({list}, {expr} [, {ic} [, {start}]])',
\         'menu': '[function]',
\         'word': 'count',
\       },],
\     'cs': [{
\         '__func__': 1,
\         '__text__': 'cscope_connection',
\         'abbr': 'cscope_connection([{num}, {dbpath} [, {prepend}]])',
\         'menu': '[function]',
\         'word': 'cscope_connection',
\       },],
\     'cu': [{
\         '__func__': 1,
\         '__text__': 'cursor',
\         'abbr': 'cursor({lnum}, {col} [, {off}])',
\         'menu': '[function]',
\         'word': 'cursor',
\       },],
\     'de': [{
\         '__func__': 1,
\         '__text__': 'deepcopy',
\         'abbr': 'deepcopy({expr} [, {noref}])',
\         'menu': '[function]',
\         'word': 'deepcopy',
\       },{
\         '__func__': 1,
\         '__text__': 'delete',
\         'abbr': 'delete({fname} [, {flags}])',
\         'menu': '[function]',
\         'word': 'delete',
\       },],
\     'di': [{
\         '__func__': 1,
\         '__text__': 'did_filetype',
\         'abbr': 'did_filetype()',
\         'menu': '[function]',
\         'word': 'did_filetype',
\       },{
\         '__func__': 1,
\         '__text__': 'diff_filler',
\         'abbr': 'diff_filler({lnum})',
\         'menu': '[function]',
\         'word': 'diff_filler',
\       },{
\         '__func__': 1,
\         '__text__': 'diff_hlID',
\         'abbr': 'diff_hlID({lnum}, {col})',
\         'menu': '[function]',
\         'word': 'diff_hlID',
\       },],
\     'em': [{
\         '__func__': 1,
\         '__text__': 'empty',
\         'abbr': 'empty({expr})',
\         'menu': '[function]',
\         'word': 'empty',
\       },],
\     'es': [{
\         '__func__': 1,
\         '__text__': 'escape',
\         'abbr': 'escape({string}, {chars})',
\         'menu': '[function]',
\         'word': 'escape',
\       },],
\     'ev': [{
\         '__func__': 1,
\         '__text__': 'eval',
\         'abbr': 'eval({string})',
\         'menu': '[function]',
\         'word': 'eval',
\       },{
\         '__func__': 1,
\         '__text__': 'eventhandler',
\         'abbr': 'eventhandler()',
\         'menu': '[function]',
\         'word': 'eventhandler',
\       },],
\     'ex': [{
\         '__func__': 1,
\         '__text__': 'executable',
\         'abbr': 'executable({expr})',
\         'menu': '[function]',
\         'word': 'executable',
\       },{
\         '__func__': 1,
\         '__text__': 'execute',
\         'abbr': 'execute({command})',
\         'menu': '[function]',
\         'word': 'execute',
\       },{
\         '__func__': 1,
\         '__text__': 'exepath',
\         'abbr': 'exepath({expr})',
\         'menu': '[function]',
\         'word': 'exepath',
\       },{
\         '__func__': 1,
\         '__text__': 'exists',
\         'abbr': 'exists({expr})',
\         'menu': '[function]',
\         'word': 'exists',
\       },{
\         '__func__': 1,
\         '__text__': 'exp',
\         'abbr': 'exp({expr})',
\         'menu': '[function]',
\         'word': 'exp',
\       },{
\         '__func__': 1,
\         '__text__': 'expand',
\         'abbr': 'expand({expr} [, {nosuf} [, {list}]])',
\         'menu': '[function]',
\         'word': 'expand',
\       },{
\         '__func__': 1,
\         '__text__': 'extend',
\         'abbr': 'extend({expr1}, {expr2} [, {expr3}])',
\         'menu': '[function]',
\         'word': 'extend',
\       },],
\     'fe': [{
\         '__func__': 1,
\         '__text__': 'feedkeys',
\         'abbr': 'feedkeys({string} [, {mode}])',
\         'menu': '[function]',
\         'word': 'feedkeys',
\       },],
\     'fi': [{
\         '__text__': 'file_readable',
\         'menu': '[function]',
\         'word': 'file_readable',
\       },{
\         '__func__': 1,
\         '__text__': 'filereadable',
\         'abbr': 'filereadable({file})',
\         'menu': '[function]',
\         'word': 'filereadable',
\       },{
\         '__func__': 1,
\         '__text__': 'filewritable',
\         'abbr': 'filewritable({file})',
\         'menu': '[function]',
\         'word': 'filewritable',
\       },{
\         '__func__': 1,
\         '__text__': 'filter',
\         'abbr': 'filter({expr1}, {expr2})',
\         'menu': '[function]',
\         'word': 'filter',
\       },{
\         '__func__': 1,
\         '__text__': 'finddir',
\         'abbr': 'finddir({name} [, {path} [, {count}]])',
\         'menu': '[function]',
\         'word': 'finddir',
\       },{
\         '__func__': 1,
\         '__text__': 'findfile',
\         'abbr': 'findfile({name} [, {path} [, {count}]])',
\         'menu': '[function]',
\         'word': 'findfile',
\       },],
\     'fl': [{
\         '__func__': 1,
\         '__text__': 'float2nr',
\         'abbr': 'float2nr({expr})',
\         'menu': '[function]',
\         'word': 'float2nr',
\       },{
\         '__func__': 1,
\         '__text__': 'floor',
\         'abbr': 'floor({expr})',
\         'menu': '[function]',
\         'word': 'floor',
\       },],
\     'fm': [{
\         '__func__': 1,
\         '__text__': 'fmod',
\         'abbr': 'fmod({expr1}, {expr2})',
\         'menu': '[function]',
\         'word': 'fmod',
\       },],
\     'fn': [{
\         '__func__': 1,
\         '__text__': 'fnameescape',
\         'abbr': 'fnameescape({fname})',
\         'menu': '[function]',
\         'word': 'fnameescape',
\       },{
\         '__func__': 1,
\         '__text__': 'fnamemodify',
\         'abbr': 'fnamemodify({fname}, {mods})',
\         'menu': '[function]',
\         'word': 'fnamemodify',
\       },],
\     'fo': [{
\         '__func__': 1,
\         '__text__': 'foldclosed',
\         'abbr': 'foldclosed({lnum})',
\         'menu': '[function]',
\         'word': 'foldclosed',
\       },{
\         '__func__': 1,
\         '__text__': 'foldclosedend',
\         'abbr': 'foldclosedend({lnum})',
\         'menu': '[function]',
\         'word': 'foldclosedend',
\       },{
\         '__func__': 1,
\         '__text__': 'foldlevel',
\         'abbr': 'foldlevel({lnum})',
\         'menu': '[function]',
\         'word': 'foldlevel',
\       },{
\         '__func__': 1,
\         '__text__': 'foldtext',
\         'abbr': 'foldtext()',
\         'menu': '[function]',
\         'word': 'foldtext',
\       },{
\         '__func__': 1,
\         '__text__': 'foldtextresult',
\         'abbr': 'foldtextresult({lnum})',
\         'menu': '[function]',
\         'word': 'foldtextresult',
\       },{
\         '__func__': 1,
\         '__text__': 'foreground',
\         'abbr': 'foreground()',
\         'menu': '[function]',
\         'word': 'foreground',
\       },],
\     'fu': [{
\         '__func__': 1,
\         '__text__': 'funcref',
\         'abbr': 'funcref({name} [, {arglist}] [, {dict}])',
\         'menu': '[function]',
\         'word': 'funcref',
\       },{
\         '__func__': 1,
\         '__text__': 'function',
\         'abbr': 'function({name} [, {arglist}] [, {dict}])',
\         'menu': '[function]',
\         'word': 'function',
\       },],
\     'ga': [{
\         '__func__': 1,
\         '__text__': 'garbagecollect',
\         'abbr': 'garbagecollect([{atexit}])',
\         'menu': '[function]',
\         'word': 'garbagecollect',
\       },],
\     'ge': [{
\         '__func__': 1,
\         '__text__': 'get',
\         'abbr': 'get({list}, {idx} [, {def}])',
\         'menu': '[function]',
\         'word': 'get',
\       },{
\         '__func__': 1,
\         '__text__': 'getbufinfo',
\         'abbr': 'getbufinfo([{expr}])',
\         'menu': '[function]',
\         'word': 'getbufinfo',
\       },{
\         '__func__': 1,
\         '__text__': 'getbufline',
\         'abbr': 'getbufline({expr}, {lnum} [, {end}])',
\         'menu': '[function]',
\         'word': 'getbufline',
\       },{
\         '__func__': 1,
\         '__text__': 'getbufvar',
\         'abbr': 'getbufvar({expr}, {varname} [, {def}])',
\         'menu': '[function]',
\         'word': 'getbufvar',
\       },{
\         '__func__': 1,
\         '__text__': 'getchangelist',
\         'abbr': 'getchangelist({expr})',
\         'menu': '[function]',
\         'word': 'getchangelist',
\       },{
\         '__func__': 1,
\         '__text__': 'getchar',
\         'abbr': 'getchar([expr])',
\         'menu': '[function]',
\         'word': 'getchar',
\       },{
\         '__func__': 1,
\         '__text__': 'getcharmod',
\         'abbr': 'getcharmod()',
\         'menu': '[function]',
\         'word': 'getcharmod',
\       },{
\         '__func__': 1,
\         '__text__': 'getcharsearch',
\         'abbr': 'getcharsearch()',
\         'menu': '[function]',
\         'word': 'getcharsearch',
\       },{
\         '__func__': 1,
\         '__text__': 'getcmdline',
\         'abbr': 'getcmdline()',
\         'menu': '[function]',
\         'word': 'getcmdline',
\       },{
\         '__func__': 1,
\         '__text__': 'getcmdpos',
\         'abbr': 'getcmdpos()',
\         'menu': '[function]',
\         'word': 'getcmdpos',
\       },{
\         '__func__': 1,
\         '__text__': 'getcmdtype',
\         'abbr': 'getcmdtype()',
\         'menu': '[function]',
\         'word': 'getcmdtype',
\       },{
\         '__func__': 1,
\         '__text__': 'getcmdwintype',
\         'abbr': 'getcmdwintype()',
\         'menu': '[function]',
\         'word': 'getcmdwintype',
\       },{
\         '__func__': 1,
\         '__text__': 'getcompletion',
\         'abbr': 'getcompletion({pat}, {type} [, {filtered}])',
\         'menu': '[function]',
\         'word': 'getcompletion',
\       },{
\         '__func__': 1,
\         '__text__': 'getcurpos',
\         'abbr': 'getcurpos()',
\         'menu': '[function]',
\         'word': 'getcurpos',
\       },{
\         '__func__': 1,
\         '__text__': 'getcwd',
\         'abbr': 'getcwd([{winnr} [, {tabnr}]])',
\         'menu': '[function]',
\         'word': 'getcwd',
\       },{
\         '__func__': 1,
\         '__text__': 'getfontname',
\         'abbr': 'getfontname([{name}])',
\         'menu': '[function]',
\         'word': 'getfontname',
\       },{
\         '__func__': 1,
\         '__text__': 'getfperm',
\         'abbr': 'getfperm({fname})',
\         'menu': '[function]',
\         'word': 'getfperm',
\       },{
\         '__func__': 1,
\         '__text__': 'getfsize',
\         'abbr': 'getfsize({fname})',
\         'menu': '[function]',
\         'word': 'getfsize',
\       },{
\         '__func__': 1,
\         '__text__': 'getftime',
\         'abbr': 'getftime({fname})',
\         'menu': '[function]',
\         'word': 'getftime',
\       },{
\         '__func__': 1,
\         '__text__': 'getftype',
\         'abbr': 'getftype({fname})',
\         'menu': '[function]',
\         'word': 'getftype',
\       },{
\         '__func__': 1,
\         '__text__': 'getjumplist',
\         'abbr': 'getjumplist([{winnr} [, {tabnr}]])',
\         'menu': '[function]',
\         'word': 'getjumplist',
\       },{
\         '__func__': 1,
\         '__text__': 'getline',
\         'abbr': 'getline({lnum})',
\         'menu': '[function]',
\         'word': 'getline',
\       },{
\         '__func__': 1,
\         '__text__': 'getloclist',
\         'abbr': 'getloclist({nr} [, {what}])',
\         'menu': '[function]',
\         'word': 'getloclist',
\       },{
\         '__func__': 1,
\         '__text__': 'getmatches',
\         'abbr': 'getmatches()',
\         'menu': '[function]',
\         'word': 'getmatches',
\       },{
\         '__func__': 1,
\         '__text__': 'getpid',
\         'abbr': 'getpid()',
\         'menu': '[function]',
\         'word': 'getpid',
\       },{
\         '__func__': 1,
\         '__text__': 'getpos',
\         'abbr': 'getpos({expr})',
\         'menu': '[function]',
\         'word': 'getpos',
\       },{
\         '__func__': 1,
\         '__text__': 'getqflist',
\         'abbr': 'getqflist([{what}])',
\         'menu': '[function]',
\         'word': 'getqflist',
\       },{
\         '__func__': 1,
\         '__text__': 'getreg',
\         'abbr': 'getreg([{regname} [, 1 [, {list}]]])',
\         'menu': '[function]',
\         'word': 'getreg',
\       },{
\         '__func__': 1,
\         '__text__': 'getregtype',
\         'abbr': 'getregtype([{regname}])',
\         'menu': '[function]',
\         'word': 'getregtype',
\       },{
\         '__func__': 1,
\         '__text__': 'gettabinfo',
\         'abbr': 'gettabinfo([{expr}])',
\         'menu': '[function]',
\         'word': 'gettabinfo',
\       },{
\         '__func__': 1,
\         '__text__': 'gettabvar',
\         'abbr': 'gettabvar({nr}, {varname} [, {def}])',
\         'menu': '[function]',
\         'word': 'gettabvar',
\       },{
\         '__func__': 1,
\         '__text__': 'gettabwinvar',
\         'abbr': 'gettabwinvar({tabnr}, {winnr}, {name} [, {def}])',
\         'menu': '[function]',
\         'word': 'gettabwinvar',
\       },{
\         '__func__': 1,
\         '__text__': 'getwininfo',
\         'abbr': 'getwininfo([{winid}])',
\         'menu': '[function]',
\         'word': 'getwininfo',
\       },{
\         '__func__': 1,
\         '__text__': 'getwinpos',
\         'abbr': 'getwinpos([{tmeout}])',
\         'menu': '[function]',
\         'word': 'getwinpos',
\       },{
\         '__func__': 1,
\         '__text__': 'getwinposx',
\         'abbr': 'getwinposx()',
\         'menu': '[function]',
\         'word': 'getwinposx',
\       },{
\         '__func__': 1,
\         '__text__': 'getwinposy',
\         'abbr': 'getwinposy()',
\         'menu': '[function]',
\         'word': 'getwinposy',
\       },{
\         '__func__': 1,
\         '__text__': 'getwinvar',
\         'abbr': 'getwinvar({nr}, {varname} [, {def}])',
\         'menu': '[function]',
\         'word': 'getwinvar',
\       },],
\     'gl': [{
\         '__func__': 1,
\         '__text__': 'glob',
\         'abbr': 'glob({expr} [, {nosuf} [, {list} [, {alllinks}]]])',
\         'menu': '[function]',
\         'word': 'glob',
\       },{
\         '__func__': 1,
\         '__text__': 'glob2regpat',
\         'abbr': 'glob2regpat({expr})',
\         'menu': '[function]',
\         'word': 'glob2regpat',
\       },{
\         '__func__': 1,
\         '__text__': 'globpath',
\         'abbr': 'globpath({path}, {expr} [, {nosuf} [, {list} [, {alllinks}]]])',
\         'menu': '[function]',
\         'word': 'globpath',
\       },],
\     'ha': [{
\         '__func__': 1,
\         '__text__': 'has',
\         'abbr': 'has({feature})',
\         'menu': '[function]',
\         'word': 'has',
\       },{
\         '__func__': 1,
\         '__text__': 'has_key',
\         'abbr': 'has_key({dict}, {key})',
\         'menu': '[function]',
\         'word': 'has_key',
\       },{
\         '__func__': 1,
\         '__text__': 'haslocaldir',
\         'abbr': 'haslocaldir([{winnr} [, {tabnr}]])',
\         'menu': '[function]',
\         'word': 'haslocaldir',
\       },{
\         '__func__': 1,
\         '__text__': 'hasmapto',
\         'abbr': 'hasmapto({what} [, {mode} [, {abbr}]])',
\         'menu': '[function]',
\         'word': 'hasmapto',
\       },],
\     'hi': [{
\         '__text__': 'highlightID',
\         'menu': '[function]',
\         'word': 'highlightID',
\       },{
\         '__text__': 'highlight_exists',
\         'menu': '[function]',
\         'word': 'highlight_exists',
\       },{
\         '__func__': 1,
\         '__text__': 'histadd',
\         'abbr': 'histadd({history}, {item})',
\         'menu': '[function]',
\         'word': 'histadd',
\       },{
\         '__func__': 1,
\         '__text__': 'histdel',
\         'abbr': 'histdel({history} [, {item}])',
\         'menu': '[function]',
\         'word': 'histdel',
\       },{
\         '__func__': 1,
\         '__text__': 'histget',
\         'abbr': 'histget({history} [, {index}])',
\         'menu': '[function]',
\         'word': 'histget',
\       },{
\         '__func__': 1,
\         '__text__': 'histnr',
\         'abbr': 'histnr({history})',
\         'menu': '[function]',
\         'word': 'histnr',
\       },],
\     'hl': [{
\         '__func__': 1,
\         '__text__': 'hlID',
\         'abbr': 'hlID({name})',
\         'menu': '[function]',
\         'word': 'hlID',
\       },{
\         '__func__': 1,
\         '__text__': 'hlexists',
\         'abbr': 'hlexists({name})',
\         'menu': '[function]',
\         'word': 'hlexists',
\       },],
\     'ho': [{
\         '__func__': 1,
\         '__text__': 'hostname',
\         'abbr': 'hostname()',
\         'menu': '[function]',
\         'word': 'hostname',
\       },],
\     'ic': [{
\         '__func__': 1,
\         '__text__': 'iconv',
\         'abbr': 'iconv({expr}, {from}, {to})',
\         'menu': '[function]',
\         'word': 'iconv',
\       },],
\     'in': [{
\         '__func__': 1,
\         '__text__': 'indent',
\         'abbr': 'indent({lnum})',
\         'menu': '[function]',
\         'word': 'indent',
\       },{
\         '__func__': 1,
\         '__text__': 'index',
\         'abbr': 'index({list}, {expr} [, {start} [, {ic}]])',
\         'menu': '[function]',
\         'word': 'index',
\       },{
\         '__func__': 1,
\         '__text__': 'input',
\         'abbr': 'input({prompt} [, {text} [, {completion}]])',
\         'menu': '[function]',
\         'word': 'input',
\       },{
\         '__func__': 1,
\         '__text__': 'inputdialog',
\         'abbr': 'inputdialog({prompt} [, {text} [, {completion}]])',
\         'menu': '[function]',
\         'word': 'inputdialog',
\       },{
\         '__func__': 1,
\         '__text__': 'inputlist',
\         'abbr': 'inputlist({textlist})',
\         'menu': '[function]',
\         'word': 'inputlist',
\       },{
\         '__func__': 1,
\         '__text__': 'inputrestore',
\         'abbr': 'inputrestore()',
\         'menu': '[function]',
\         'word': 'inputrestore',
\       },{
\         '__func__': 1,
\         '__text__': 'inputsave',
\         'abbr': 'inputsave()',
\         'menu': '[function]',
\         'word': 'inputsave',
\       },{
\         '__func__': 1,
\         '__text__': 'inputsecret',
\         'abbr': 'inputsecret({prompt} [, {text}])',
\         'menu': '[function]',
\         'word': 'inputsecret',
\       },{
\         '__func__': 1,
\         '__text__': 'insert',
\         'abbr': 'insert({list}, {item} [, {idx}])',
\         'menu': '[function]',
\         'word': 'insert',
\       },{
\         '__func__': 1,
\         '__text__': 'invert',
\         'abbr': 'invert({expr})',
\         'menu': '[function]',
\         'word': 'invert',
\       },],
\     'is': [{
\         '__func__': 1,
\         '__text__': 'isdirectory',
\         'abbr': 'isdirectory({directory})',
\         'menu': '[function]',
\         'word': 'isdirectory',
\       },{
\         '__func__': 1,
\         '__text__': 'islocked',
\         'abbr': 'islocked({expr})',
\         'menu': '[function]',
\         'word': 'islocked',
\       },{
\         '__func__': 1,
\         '__text__': 'isnan',
\         'abbr': 'isnan({expr})',
\         'menu': '[function]',
\         'word': 'isnan',
\       },],
\     'it': [{
\         '__func__': 1,
\         '__text__': 'items',
\         'abbr': 'items({dict})',
\         'menu': '[function]',
\         'word': 'items',
\       },],
\     'jo': [{
\         '__func__': 1,
\         '__text__': 'job_getchannel',
\         'abbr': 'job_getchannel({job})',
\         'menu': '[function]',
\         'word': 'job_getchannel',
\       },{
\         '__func__': 1,
\         '__text__': 'job_info',
\         'abbr': 'job_info({job})',
\         'menu': '[function]',
\         'word': 'job_info',
\       },{
\         '__func__': 1,
\         '__text__': 'job_setoptions',
\         'abbr': 'job_setoptions({job}, {options})',
\         'menu': '[function]',
\         'word': 'job_setoptions',
\       },{
\         '__func__': 1,
\         '__text__': 'job_start',
\         'abbr': 'job_start({command} [, {options}])',
\         'menu': '[function]',
\         'word': 'job_start',
\       },{
\         '__func__': 1,
\         '__text__': 'job_status',
\         'abbr': 'job_status({job})',
\         'menu': '[function]',
\         'word': 'job_status',
\       },{
\         '__func__': 1,
\         '__text__': 'job_stop',
\         'abbr': 'job_stop({job} [, {how}])',
\         'menu': '[function]',
\         'word': 'job_stop',
\       },{
\         '__func__': 1,
\         '__text__': 'join',
\         'abbr': 'join({list} [, {sep}])',
\         'menu': '[function]',
\         'word': 'join',
\       },],
\     'js': [{
\         '__func__': 1,
\         '__text__': 'js_decode',
\         'abbr': 'js_decode({string})',
\         'menu': '[function]',
\         'word': 'js_decode',
\       },{
\         '__func__': 1,
\         '__text__': 'js_encode',
\         'abbr': 'js_encode({expr})',
\         'menu': '[function]',
\         'word': 'js_encode',
\       },{
\         '__func__': 1,
\         '__text__': 'json_decode',
\         'abbr': 'json_decode({string})',
\         'menu': '[function]',
\         'word': 'json_decode',
\       },{
\         '__func__': 1,
\         '__text__': 'json_encode',
\         'abbr': 'json_encode({expr})',
\         'menu': '[function]',
\         'word': 'json_encode',
\       },],
\     'ke': [{
\         '__func__': 1,
\         '__text__': 'keys',
\         'abbr': 'keys({dict})',
\         'menu': '[function]',
\         'word': 'keys',
\       },],
\     'la': [{
\         '__text__': 'last_buffer_nr',
\         'menu': '[function]',
\         'word': 'last_buffer_nr',
\       },],
\     'le': [{
\         '__func__': 1,
\         '__text__': 'len',
\         'abbr': 'len({expr})',
\         'menu': '[function]',
\         'word': 'len',
\       },],
\     'li': [{
\         '__func__': 1,
\         '__text__': 'libcall',
\         'abbr': 'libcall({lib}, {func}, {arg})',
\         'menu': '[function]',
\         'word': 'libcall',
\       },{
\         '__func__': 1,
\         '__text__': 'libcallnr',
\         'abbr': 'libcallnr({lib}, {func}, {arg})',
\         'menu': '[function]',
\         'word': 'libcallnr',
\       },{
\         '__func__': 1,
\         '__text__': 'line',
\         'abbr': 'line({expr})',
\         'menu': '[function]',
\         'word': 'line',
\       },{
\         '__func__': 1,
\         '__text__': 'line2byte',
\         'abbr': 'line2byte({lnum})',
\         'menu': '[function]',
\         'word': 'line2byte',
\       },{
\         '__func__': 1,
\         '__text__': 'lispindent',
\         'abbr': 'lispindent({lnum})',
\         'menu': '[function]',
\         'word': 'lispindent',
\       },],
\     'lo': [{
\         '__func__': 1,
\         '__text__': 'localtime',
\         'abbr': 'localtime()',
\         'menu': '[function]',
\         'word': 'localtime',
\       },{
\         '__func__': 1,
\         '__text__': 'log',
\         'abbr': 'log({expr})',
\         'menu': '[function]',
\         'word': 'log',
\       },{
\         '__func__': 1,
\         '__text__': 'log10',
\         'abbr': 'log10({expr})',
\         'menu': '[function]',
\         'word': 'log10',
\       },],
\     'lu': [{
\         '__func__': 1,
\         '__text__': 'luaeval',
\         'abbr': 'luaeval({expr} [, {expr}])',
\         'menu': '[function]',
\         'word': 'luaeval',
\       },],
\     'ma': [{
\         '__func__': 1,
\         '__text__': 'map',
\         'abbr': 'map({expr1}, {expr2})',
\         'menu': '[function]',
\         'word': 'map',
\       },{
\         '__func__': 1,
\         '__text__': 'maparg',
\         'abbr': 'maparg({name} [, {mode} [, {abbr} [, {dict}]]])',
\         'menu': '[function]',
\         'word': 'maparg',
\       },{
\         '__func__': 1,
\         '__text__': 'mapcheck',
\         'abbr': 'mapcheck({name} [, {mode} [, {abbr}]])',
\         'menu': '[function]',
\         'word': 'mapcheck',
\       },{
\         '__func__': 1,
\         '__text__': 'match',
\         'abbr': 'match({expr}, {pat} [, {start} [, {count}]])',
\         'menu': '[function]',
\         'word': 'match',
\       },{
\         '__func__': 1,
\         '__text__': 'matchadd',
\         'abbr': 'matchadd({group}, {pattern} [, {priority} [, {id} [, {dict}]]])',
\         'menu': '[function]',
\         'word': 'matchadd',
\       },{
\         '__func__': 1,
\         '__text__': 'matchaddpos',
\         'abbr': 'matchaddpos({group}, {pos} [, {priority} [, {id} [, {dict}]]])',
\         'menu': '[function]',
\         'word': 'matchaddpos',
\       },{
\         '__func__': 1,
\         '__text__': 'matcharg',
\         'abbr': 'matcharg({nr})',
\         'menu': '[function]',
\         'word': 'matcharg',
\       },{
\         '__func__': 1,
\         '__text__': 'matchdelete',
\         'abbr': 'matchdelete({id})',
\         'menu': '[function]',
\         'word': 'matchdelete',
\       },{
\         '__func__': 1,
\         '__text__': 'matchend',
\         'abbr': 'matchend({expr}, {pat} [, {start} [, {count}]])',
\         'menu': '[function]',
\         'word': 'matchend',
\       },{
\         '__func__': 1,
\         '__text__': 'matchlist',
\         'abbr': 'matchlist({expr}, {pat} [, {start} [, {count}]])',
\         'menu': '[function]',
\         'word': 'matchlist',
\       },{
\         '__func__': 1,
\         '__text__': 'matchstr',
\         'abbr': 'matchstr({expr}, {pat} [, {start} [, {count}]])',
\         'menu': '[function]',
\         'word': 'matchstr',
\       },{
\         '__func__': 1,
\         '__text__': 'matchstrpos',
\         'abbr': 'matchstrpos({expr}, {pat} [, {start} [, {count}]])',
\         'menu': '[function]',
\         'word': 'matchstrpos',
\       },{
\         '__func__': 1,
\         '__text__': 'max',
\         'abbr': 'max({expr})',
\         'menu': '[function]',
\         'word': 'max',
\       },],
\     'mi': [{
\         '__func__': 1,
\         '__text__': 'min',
\         'abbr': 'min({expr})',
\         'menu': '[function]',
\         'word': 'min',
\       },],
\     'mk': [{
\         '__func__': 1,
\         '__text__': 'mkdir',
\         'abbr': 'mkdir({name} [, {path} [, {prot}]])',
\         'menu': '[function]',
\         'word': 'mkdir',
\       },],
\     'mo': [{
\         '__func__': 1,
\         '__text__': 'mode',
\         'abbr': 'mode([expr])',
\         'menu': '[function]',
\         'word': 'mode',
\       },],
\     'ne': [{
\         '__func__': 1,
\         '__text__': 'nextnonblank',
\         'abbr': 'nextnonblank({lnum})',
\         'menu': '[function]',
\         'word': 'nextnonblank',
\       },],
\     'nr': [{
\         '__func__': 1,
\         '__text__': 'nr2char',
\         'abbr': 'nr2char({expr} [, {utf8}])',
\         'menu': '[function]',
\         'word': 'nr2char',
\       },],
\     'or': [{
\         '__func__': 1,
\         '__text__': 'or',
\         'abbr': 'or({expr}, {expr})',
\         'menu': '[function]',
\         'word': 'or',
\       },],
\     'pa': [{
\         '__func__': 1,
\         '__text__': 'pathshorten',
\         'abbr': 'pathshorten({expr})',
\         'menu': '[function]',
\         'word': 'pathshorten',
\       },],
\     'po': [{
\         '__func__': 1,
\         '__text__': 'pow',
\         'abbr': 'pow({x}, {y})',
\         'menu': '[function]',
\         'word': 'pow',
\       },],
\     'pr': [{
\         '__func__': 1,
\         '__text__': 'prevnonblank',
\         'abbr': 'prevnonblank({lnum})',
\         'menu': '[function]',
\         'word': 'prevnonblank',
\       },{
\         '__func__': 1,
\         '__text__': 'printf',
\         'abbr': 'printf({fmt}, {expr1}...)',
\         'menu': '[function]',
\         'word': 'printf',
\       },],
\     'pu': [{
\         '__func__': 1,
\         '__text__': 'pumvisible',
\         'abbr': 'pumvisible()',
\         'menu': '[function]',
\         'word': 'pumvisible',
\       },],
\     'py': [{
\         '__func__': 1,
\         '__text__': 'py3eval',
\         'abbr': 'py3eval({expr})',
\         'menu': '[function]',
\         'word': 'py3eval',
\       },{
\         '__func__': 1,
\         '__text__': 'pyeval',
\         'abbr': 'pyeval({expr})',
\         'menu': '[function]',
\         'word': 'pyeval',
\       },{
\         '__func__': 1,
\         '__text__': 'pyxeval',
\         'abbr': 'pyxeval({expr})',
\         'menu': '[function]',
\         'word': 'pyxeval',
\       },],
\     'ra': [{
\         '__func__': 1,
\         '__text__': 'range',
\         'abbr': 'range({expr} [, {max} [, {stride}]])',
\         'menu': '[function]',
\         'word': 'range',
\       },],
\     're': [{
\         '__func__': 1,
\         '__text__': 'readfile',
\         'abbr': 'readfile({fname} [, {binary} [, {max}]])',
\         'menu': '[function]',
\         'word': 'readfile',
\       },{
\         '__func__': 1,
\         '__text__': 'reltime',
\         'abbr': 'reltime([{start} [, {end}]])',
\         'menu': '[function]',
\         'word': 'reltime',
\       },{
\         '__func__': 1,
\         '__text__': 'reltimefloat',
\         'abbr': 'reltimefloat({time})',
\         'menu': '[function]',
\         'word': 'reltimefloat',
\       },{
\         '__func__': 1,
\         '__text__': 'reltimestr',
\         'abbr': 'reltimestr({time})',
\         'menu': '[function]',
\         'word': 'reltimestr',
\       },{
\         '__func__': 1,
\         '__text__': 'remote_expr',
\         'abbr': 'remote_expr({server}, {string} [, {idvar} [, {timeout}]])',
\         'menu': '[function]',
\         'word': 'remote_expr',
\       },{
\         '__func__': 1,
\         '__text__': 'remote_foreground',
\         'abbr': 'remote_foreground({server})',
\         'menu': '[function]',
\         'word': 'remote_foreground',
\       },{
\         '__func__': 1,
\         '__text__': 'remote_peek',
\         'abbr': 'remote_peek({serverid} [, {retvar}])',
\         'menu': '[function]',
\         'word': 'remote_peek',
\       },{
\         '__func__': 1,
\         '__text__': 'remote_read',
\         'abbr': 'remote_read({serverid} [, {timeout}])',
\         'menu': '[function]',
\         'word': 'remote_read',
\       },{
\         '__func__': 1,
\         '__text__': 'remote_send',
\         'abbr': 'remote_send({server}, {string} [, {idvar}])',
\         'menu': '[function]',
\         'word': 'remote_send',
\       },{
\         '__func__': 1,
\         '__text__': 'remote_startserver',
\         'abbr': 'remote_startserver({name})',
\         'menu': '[function]',
\         'word': 'remote_startserver',
\       },{
\         '__func__': 1,
\         '__text__': 'remove',
\         'abbr': 'remove({list}, {idx} [, {end}])',
\         'menu': '[function]',
\         'word': 'remove',
\       },{
\         '__func__': 1,
\         '__text__': 'rename',
\         'abbr': 'rename({from}, {to})',
\         'menu': '[function]',
\         'word': 'rename',
\       },{
\         '__func__': 1,
\         '__text__': 'repeat',
\         'abbr': 'repeat({expr}, {count})',
\         'menu': '[function]',
\         'word': 'repeat',
\       },{
\         '__func__': 1,
\         '__text__': 'resolve',
\         'abbr': 'resolve({filename})',
\         'menu': '[function]',
\         'word': 'resolve',
\       },{
\         '__func__': 1,
\         '__text__': 'reverse',
\         'abbr': 'reverse({list})',
\         'menu': '[function]',
\         'word': 'reverse',
\       },],
\     'ro': [{
\         '__func__': 1,
\         '__text__': 'round',
\         'abbr': 'round({expr})',
\         'menu': '[function]',
\         'word': 'round',
\       },],
\     'sc': [{
\         '__func__': 1,
\         '__text__': 'screenattr',
\         'abbr': 'screenattr({row}, {col})',
\         'menu': '[function]',
\         'word': 'screenattr',
\       },{
\         '__func__': 1,
\         '__text__': 'screenchar',
\         'abbr': 'screenchar({row}, {col})',
\         'menu': '[function]',
\         'word': 'screenchar',
\       },{
\         '__func__': 1,
\         '__text__': 'screencol',
\         'abbr': 'screencol()',
\         'menu': '[function]',
\         'word': 'screencol',
\       },{
\         '__func__': 1,
\         '__text__': 'screenrow',
\         'abbr': 'screenrow()',
\         'menu': '[function]',
\         'word': 'screenrow',
\       },],
\     'se': [{
\         '__func__': 1,
\         '__text__': 'search',
\         'abbr': 'search({pattern} [, {flags} [, {stopline} [, {timeout}]]])',
\         'menu': '[function]',
\         'word': 'search',
\       },{
\         '__func__': 1,
\         '__text__': 'searchdecl',
\         'abbr': 'searchdecl({name} [, {global} [, {thisblock}]])',
\         'menu': '[function]',
\         'word': 'searchdecl',
\       },{
\         '__func__': 1,
\         '__text__': 'searchpair',
\         'abbr': 'searchpair({start}, {middle}, {end} [, {flags} [, {skip} [...]]])',
\         'menu': '[function]',
\         'word': 'searchpair',
\       },{
\         '__func__': 1,
\         '__text__': 'searchpairpos',
\         'abbr': 'searchpairpos({start}, {middle}, {end} [, {flags} [, {skip} [...]]])',
\         'menu': '[function]',
\         'word': 'searchpairpos',
\       },{
\         '__func__': 1,
\         '__text__': 'searchpos',
\         'abbr': 'searchpos({pattern} [, {flags} [, {stopline} [, {timeout}]]])',
\         'menu': '[function]',
\         'word': 'searchpos',
\       },{
\         '__func__': 1,
\         '__text__': 'server2client',
\         'abbr': 'server2client({clientid}, {string})',
\         'menu': '[function]',
\         'word': 'server2client',
\       },{
\         '__func__': 1,
\         '__text__': 'serverlist',
\         'abbr': 'serverlist()',
\         'menu': '[function]',
\         'word': 'serverlist',
\       },{
\         '__func__': 1,
\         '__text__': 'setbufline',
\         'abbr': 'setbufline({expr}, {lnum}, {line})',
\         'menu': '[function]',
\         'word': 'setbufline',
\       },{
\         '__func__': 1,
\         '__text__': 'setbufvar',
\         'abbr': 'setbufvar({expr}, {varname}, {val})',
\         'menu': '[function]',
\         'word': 'setbufvar',
\       },{
\         '__func__': 1,
\         '__text__': 'setcharsearch',
\         'abbr': 'setcharsearch({dict})',
\         'menu': '[function]',
\         'word': 'setcharsearch',
\       },{
\         '__func__': 1,
\         '__text__': 'setcmdpos',
\         'abbr': 'setcmdpos({pos})',
\         'menu': '[function]',
\         'word': 'setcmdpos',
\       },{
\         '__func__': 1,
\         '__text__': 'setfperm',
\         'abbr': 'setfperm({fname}, {mode})',
\         'menu': '[function]',
\         'word': 'setfperm',
\       },{
\         '__func__': 1,
\         '__text__': 'setline',
\         'abbr': 'setline({lnum}, {line})',
\         'menu': '[function]',
\         'word': 'setline',
\       },{
\         '__func__': 1,
\         '__text__': 'setloclist',
\         'abbr': 'setloclist({nr}, {list} [, {action} [, {what}]])',
\         'menu': '[function]',
\         'word': 'setloclist',
\       },{
\         '__func__': 1,
\         '__text__': 'setmatches',
\         'abbr': 'setmatches({list})',
\         'menu': '[function]',
\         'word': 'setmatches',
\       },{
\         '__func__': 1,
\         '__text__': 'setpos',
\         'abbr': 'setpos({expr}, {list})',
\         'menu': '[function]',
\         'word': 'setpos',
\       },{
\         '__func__': 1,
\         '__text__': 'setqflist',
\         'abbr': 'setqflist({list} [, {action} [, {what}]])',
\         'menu': '[function]',
\         'word': 'setqflist',
\       },{
\         '__func__': 1,
\         '__text__': 'setreg',
\         'abbr': 'setreg({n}, {v} [, {opt}])',
\         'menu': '[function]',
\         'word': 'setreg',
\       },{
\         '__func__': 1,
\         '__text__': 'settabvar',
\         'abbr': 'settabvar({nr}, {varname}, {val})',
\         'menu': '[function]',
\         'word': 'settabvar',
\       },{
\         '__func__': 1,
\         '__text__': 'settabwinvar',
\         'abbr': 'settabwinvar({tabnr}, {winnr}, {varname}, {val})',
\         'menu': '[function]',
\         'word': 'settabwinvar',
\       },{
\         '__func__': 1,
\         '__text__': 'setwinvar',
\         'abbr': 'setwinvar({nr}, {varname}, {val})',
\         'menu': '[function]',
\         'word': 'setwinvar',
\       },],
\     'sh': [{
\         '__func__': 1,
\         '__text__': 'sha256',
\         'abbr': 'sha256({string})',
\         'menu': '[function]',
\         'word': 'sha256',
\       },{
\         '__func__': 1,
\         '__text__': 'shellescape',
\         'abbr': 'shellescape({string} [, {special}])',
\         'menu': '[function]',
\         'word': 'shellescape',
\       },{
\         '__func__': 1,
\         '__text__': 'shiftwidth',
\         'abbr': 'shiftwidth()',
\         'menu': '[function]',
\         'word': 'shiftwidth',
\       },],
\     'si': [{
\         '__func__': 1,
\         '__text__': 'simplify',
\         'abbr': 'simplify({filename})',
\         'menu': '[function]',
\         'word': 'simplify',
\       },{
\         '__func__': 1,
\         '__text__': 'sin',
\         'abbr': 'sin({expr})',
\         'menu': '[function]',
\         'word': 'sin',
\       },{
\         '__func__': 1,
\         '__text__': 'sinh',
\         'abbr': 'sinh({expr})',
\         'menu': '[function]',
\         'word': 'sinh',
\       },],
\     'so': [{
\         '__func__': 1,
\         '__text__': 'sort',
\         'abbr': 'sort({list} [, {func} [, {dict}]])',
\         'menu': '[function]',
\         'word': 'sort',
\       },{
\         '__func__': 1,
\         '__text__': 'soundfold',
\         'abbr': 'soundfold({word})',
\         'menu': '[function]',
\         'word': 'soundfold',
\       },],
\     'sp': [{
\         '__func__': 1,
\         '__text__': 'spellbadword',
\         'abbr': 'spellbadword()',
\         'menu': '[function]',
\         'word': 'spellbadword',
\       },{
\         '__func__': 1,
\         '__text__': 'spellsuggest',
\         'abbr': 'spellsuggest({word} [, {max} [, {capital}]])',
\         'menu': '[function]',
\         'word': 'spellsuggest',
\       },{
\         '__func__': 1,
\         '__text__': 'split',
\         'abbr': 'split({expr} [, {pat} [, {keepempty}]])',
\         'menu': '[function]',
\         'word': 'split',
\       },],
\     'sq': [{
\         '__func__': 1,
\         '__text__': 'sqrt',
\         'abbr': 'sqrt({expr})',
\         'menu': '[function]',
\         'word': 'sqrt',
\       },],
\     'st': [{
\         '__func__': 1,
\         '__text__': 'str2float',
\         'abbr': 'str2float({expr})',
\         'menu': '[function]',
\         'word': 'str2float',
\       },{
\         '__func__': 1,
\         '__text__': 'str2nr',
\         'abbr': 'str2nr({expr} [, {base}])',
\         'menu': '[function]',
\         'word': 'str2nr',
\       },{
\         '__func__': 1,
\         '__text__': 'strcharpart',
\         'abbr': 'strcharpart({str}, {start} [, {len}])',
\         'menu': '[function]',
\         'word': 'strcharpart',
\       },{
\         '__func__': 1,
\         '__text__': 'strchars',
\         'abbr': 'strchars({expr} [, {skipcc}])',
\         'menu': '[function]',
\         'word': 'strchars',
\       },{
\         '__func__': 1,
\         '__text__': 'strdisplaywidth',
\         'abbr': 'strdisplaywidth({expr} [, {col}])',
\         'menu': '[function]',
\         'word': 'strdisplaywidth',
\       },{
\         '__func__': 1,
\         '__text__': 'strftime',
\         'abbr': 'strftime({format} [, {time}])',
\         'menu': '[function]',
\         'word': 'strftime',
\       },{
\         '__func__': 1,
\         '__text__': 'strgetchar',
\         'abbr': 'strgetchar({str}, {index})',
\         'menu': '[function]',
\         'word': 'strgetchar',
\       },{
\         '__func__': 1,
\         '__text__': 'stridx',
\         'abbr': 'stridx({haystack}, {needle} [, {start}])',
\         'menu': '[function]',
\         'word': 'stridx',
\       },{
\         '__func__': 1,
\         '__text__': 'string',
\         'abbr': 'string({expr})',
\         'menu': '[function]',
\         'word': 'string',
\       },{
\         '__func__': 1,
\         '__text__': 'strlen',
\         'abbr': 'strlen({expr})',
\         'menu': '[function]',
\         'word': 'strlen',
\       },{
\         '__func__': 1,
\         '__text__': 'strpart',
\         'abbr': 'strpart({str}, {start} [, {len}])',
\         'menu': '[function]',
\         'word': 'strpart',
\       },{
\         '__func__': 1,
\         '__text__': 'strridx',
\         'abbr': 'strridx({haystack}, {needle} [, {start}])',
\         'menu': '[function]',
\         'word': 'strridx',
\       },{
\         '__func__': 1,
\         '__text__': 'strtrans',
\         'abbr': 'strtrans({expr})',
\         'menu': '[function]',
\         'word': 'strtrans',
\       },{
\         '__func__': 1,
\         '__text__': 'strwidth',
\         'abbr': 'strwidth({expr})',
\         'menu': '[function]',
\         'word': 'strwidth',
\       },],
\     'su': [{
\         '__func__': 1,
\         '__text__': 'submatch',
\         'abbr': 'submatch({nr} [, {list}])',
\         'menu': '[function]',
\         'word': 'submatch',
\       },{
\         '__func__': 1,
\         '__text__': 'substitute',
\         'abbr': 'substitute({expr}, {pat}, {sub}, {flags})',
\         'menu': '[function]',
\         'word': 'substitute',
\       },],
\     'sy': [{
\         '__func__': 1,
\         '__text__': 'synID',
\         'abbr': 'synID({lnum}, {col}, {trans})',
\         'menu': '[function]',
\         'word': 'synID',
\       },{
\         '__func__': 1,
\         '__text__': 'synIDattr',
\         'abbr': 'synIDattr({synID}, {what} [, {mode}])',
\         'menu': '[function]',
\         'word': 'synIDattr',
\       },{
\         '__func__': 1,
\         '__text__': 'synIDtrans',
\         'abbr': 'synIDtrans({synID})',
\         'menu': '[function]',
\         'word': 'synIDtrans',
\       },{
\         '__func__': 1,
\         '__text__': 'synconcealed',
\         'abbr': 'synconcealed({lnum}, {col})',
\         'menu': '[function]',
\         'word': 'synconcealed',
\       },{
\         '__func__': 1,
\         '__text__': 'synstack',
\         'abbr': 'synstack({lnum}, {col})',
\         'menu': '[function]',
\         'word': 'synstack',
\       },{
\         '__func__': 1,
\         '__text__': 'system',
\         'abbr': 'system({expr} [, {input}])',
\         'menu': '[function]',
\         'word': 'system',
\       },{
\         '__func__': 1,
\         '__text__': 'systemlist',
\         'abbr': 'systemlist({expr} [, {input}])',
\         'menu': '[function]',
\         'word': 'systemlist',
\       },],
\     'ta': [{
\         '__func__': 1,
\         '__text__': 'tabpagebuflist',
\         'abbr': 'tabpagebuflist([{arg}])',
\         'menu': '[function]',
\         'word': 'tabpagebuflist',
\       },{
\         '__func__': 1,
\         '__text__': 'tabpagenr',
\         'abbr': 'tabpagenr([{arg}])',
\         'menu': '[function]',
\         'word': 'tabpagenr',
\       },{
\         '__func__': 1,
\         '__text__': 'tabpagewinnr',
\         'abbr': 'tabpagewinnr({tabarg} [, {arg}])',
\         'menu': '[function]',
\         'word': 'tabpagewinnr',
\       },{
\         '__func__': 1,
\         '__text__': 'tagfiles',
\         'abbr': 'tagfiles()',
\         'menu': '[function]',
\         'word': 'tagfiles',
\       },{
\         '__func__': 1,
\         '__text__': 'taglist',
\         'abbr': 'taglist({expr} [, {filename}])',
\         'menu': '[function]',
\         'word': 'taglist',
\       },{
\         '__func__': 1,
\         '__text__': 'tan',
\         'abbr': 'tan({expr})',
\         'menu': '[function]',
\         'word': 'tan',
\       },{
\         '__func__': 1,
\         '__text__': 'tanh',
\         'abbr': 'tanh({expr})',
\         'menu': '[function]',
\         'word': 'tanh',
\       },],
\     'te': [{
\         '__func__': 1,
\         '__text__': 'tempname',
\         'abbr': 'tempname()',
\         'menu': '[function]',
\         'word': 'tempname',
\       },{
\         '__func__': 1,
\         '__text__': 'term_dumpdiff',
\         'abbr': 'term_dumpdiff({filename}, {filename} [, {options}])',
\         'menu': '[function]',
\         'word': 'term_dumpdiff',
\       },{
\         '__func__': 1,
\         '__text__': 'term_dumpload',
\         'abbr': 'term_dumpload({filename} [, {options}])',
\         'menu': '[function]',
\         'word': 'term_dumpload',
\       },{
\         '__func__': 1,
\         '__text__': 'term_dumpwrite',
\         'abbr': 'term_dumpwrite({buf}, {filename} [, {options}])',
\         'menu': '[function]',
\         'word': 'term_dumpwrite',
\       },{
\         '__func__': 1,
\         '__text__': 'term_getaltscreen',
\         'abbr': 'term_getaltscreen({buf})',
\         'menu': '[function]',
\         'word': 'term_getaltscreen',
\       },{
\         '__func__': 1,
\         '__text__': 'term_getattr',
\         'abbr': 'term_getattr({attr}, {what})',
\         'menu': '[function]',
\         'word': 'term_getattr',
\       },{
\         '__func__': 1,
\         '__text__': 'term_getcursor',
\         'abbr': 'term_getcursor({buf})',
\         'menu': '[function]',
\         'word': 'term_getcursor',
\       },{
\         '__func__': 1,
\         '__text__': 'term_getjob',
\         'abbr': 'term_getjob({buf})',
\         'menu': '[function]',
\         'word': 'term_getjob',
\       },{
\         '__func__': 1,
\         '__text__': 'term_getline',
\         'abbr': 'term_getline({buf}, {row})',
\         'menu': '[function]',
\         'word': 'term_getline',
\       },{
\         '__func__': 1,
\         '__text__': 'term_getscrolled',
\         'abbr': 'term_getscrolled({buf})',
\         'menu': '[function]',
\         'word': 'term_getscrolled',
\       },{
\         '__func__': 1,
\         '__text__': 'term_getsize',
\         'abbr': 'term_getsize({buf})',
\         'menu': '[function]',
\         'word': 'term_getsize',
\       },{
\         '__func__': 1,
\         '__text__': 'term_getstatus',
\         'abbr': 'term_getstatus({buf})',
\         'menu': '[function]',
\         'word': 'term_getstatus',
\       },{
\         '__func__': 1,
\         '__text__': 'term_gettitle',
\         'abbr': 'term_gettitle({buf})',
\         'menu': '[function]',
\         'word': 'term_gettitle',
\       },{
\         '__func__': 1,
\         '__text__': 'term_gettty',
\         'abbr': 'term_gettty({buf}, [{input}])',
\         'menu': '[function]',
\         'word': 'term_gettty',
\       },{
\         '__func__': 1,
\         '__text__': 'term_list',
\         'abbr': 'term_list()',
\         'menu': '[function]',
\         'word': 'term_list',
\       },{
\         '__func__': 1,
\         '__text__': 'term_scrape',
\         'abbr': 'term_scrape({buf}, {row})',
\         'menu': '[function]',
\         'word': 'term_scrape',
\       },{
\         '__func__': 1,
\         '__text__': 'term_sendkeys',
\         'abbr': 'term_sendkeys({buf}, {keys})',
\         'menu': '[function]',
\         'word': 'term_sendkeys',
\       },{
\         '__func__': 1,
\         '__text__': 'term_start',
\         'abbr': 'term_start({cmd}, {options})',
\         'menu': '[function]',
\         'word': 'term_start',
\       },{
\         '__func__': 1,
\         '__text__': 'term_wait',
\         'abbr': 'term_wait({buf} [, {time}])',
\         'menu': '[function]',
\         'word': 'term_wait',
\       },{
\         '__func__': 1,
\         '__text__': 'test_alloc_fail',
\         'abbr': 'test_alloc_fail({id}, {countdown}, {repeat})',
\         'menu': '[function]',
\         'word': 'test_alloc_fail',
\       },{
\         '__func__': 1,
\         '__text__': 'test_autochdir',
\         'abbr': 'test_autochdir()',
\         'menu': '[function]',
\         'word': 'test_autochdir',
\       },{
\         '__func__': 1,
\         '__text__': 'test_feedinput',
\         'abbr': 'test_feedinput()',
\         'menu': '[function]',
\         'word': 'test_feedinput',
\       },{
\         '__func__': 1,
\         '__text__': 'test_garbagecollect_now',
\         'abbr': 'test_garbagecollect_now()',
\         'menu': '[function]',
\         'word': 'test_garbagecollect_now',
\       },{
\         '__func__': 1,
\         '__text__': 'test_ignore_error',
\         'abbr': 'test_ignore_error({expr})',
\         'menu': '[function]',
\         'word': 'test_ignore_error',
\       },{
\         '__func__': 1,
\         '__text__': 'test_null_channel',
\         'abbr': 'test_null_channel()',
\         'menu': '[function]',
\         'word': 'test_null_channel',
\       },{
\         '__func__': 1,
\         '__text__': 'test_null_dict',
\         'abbr': 'test_null_dict()',
\         'menu': '[function]',
\         'word': 'test_null_dict',
\       },{
\         '__func__': 1,
\         '__text__': 'test_null_job',
\         'abbr': 'test_null_job()',
\         'menu': '[function]',
\         'word': 'test_null_job',
\       },{
\         '__func__': 1,
\         '__text__': 'test_null_list',
\         'abbr': 'test_null_list()',
\         'menu': '[function]',
\         'word': 'test_null_list',
\       },{
\         '__func__': 1,
\         '__text__': 'test_null_partial',
\         'abbr': 'test_null_partial()',
\         'menu': '[function]',
\         'word': 'test_null_partial',
\       },{
\         '__func__': 1,
\         '__text__': 'test_null_string',
\         'abbr': 'test_null_string()',
\         'menu': '[function]',
\         'word': 'test_null_string',
\       },{
\         '__func__': 1,
\         '__text__': 'test_override',
\         'abbr': 'test_override({expr}, {val})',
\         'menu': '[function]',
\         'word': 'test_override',
\       },{
\         '__func__': 1,
\         '__text__': 'test_settime',
\         'abbr': 'test_settime({expr})',
\         'menu': '[function]',
\         'word': 'test_settime',
\       },],
\     'ti': [{
\         '__func__': 1,
\         '__text__': 'timer_info',
\         'abbr': 'timer_info([{id}])',
\         'menu': '[function]',
\         'word': 'timer_info',
\       },{
\         '__func__': 1,
\         '__text__': 'timer_pause',
\         'abbr': 'timer_pause({id}, {pause})',
\         'menu': '[function]',
\         'word': 'timer_pause',
\       },{
\         '__func__': 1,
\         '__text__': 'timer_start',
\         'abbr': 'timer_start({time}, {callback} [, {options}])',
\         'menu': '[function]',
\         'word': 'timer_start',
\       },{
\         '__func__': 1,
\         '__text__': 'timer_stop',
\         'abbr': 'timer_stop({timer})',
\         'menu': '[function]',
\         'word': 'timer_stop',
\       },{
\         '__func__': 1,
\         '__text__': 'timer_stopall',
\         'abbr': 'timer_stopall()',
\         'menu': '[function]',
\         'word': 'timer_stopall',
\       },],
\     'to': [{
\         '__func__': 1,
\         '__text__': 'tolower',
\         'abbr': 'tolower({expr})',
\         'menu': '[function]',
\         'word': 'tolower',
\       },{
\         '__func__': 1,
\         '__text__': 'toupper',
\         'abbr': 'toupper({expr})',
\         'menu': '[function]',
\         'word': 'toupper',
\       },],
\     'tr': [{
\         '__func__': 1,
\         '__text__': 'tr',
\         'abbr': 'tr({src}, {fromstr}, {tostr})',
\         'menu': '[function]',
\         'word': 'tr',
\       },{
\         '__func__': 1,
\         '__text__': 'trunc',
\         'abbr': 'trunc({expr})',
\         'menu': '[function]',
\         'word': 'trunc',
\       },],
\     'ty': [{
\         '__func__': 1,
\         '__text__': 'type',
\         'abbr': 'type({name})',
\         'menu': '[function]',
\         'word': 'type',
\       },],
\     'un': [{
\         '__func__': 1,
\         '__text__': 'undofile',
\         'abbr': 'undofile({name})',
\         'menu': '[function]',
\         'word': 'undofile',
\       },{
\         '__func__': 1,
\         '__text__': 'undotree',
\         'abbr': 'undotree()',
\         'menu': '[function]',
\         'word': 'undotree',
\       },{
\         '__func__': 1,
\         '__text__': 'uniq',
\         'abbr': 'uniq({list} [, {func} [, {dict}]])',
\         'menu': '[function]',
\         'word': 'uniq',
\       },],
\     'va': [{
\         '__func__': 1,
\         '__text__': 'values',
\         'abbr': 'values({dict})',
\         'menu': '[function]',
\         'word': 'values',
\       },],
\     'vi': [{
\         '__func__': 1,
\         '__text__': 'virtcol',
\         'abbr': 'virtcol({expr})',
\         'menu': '[function]',
\         'word': 'virtcol',
\       },{
\         '__func__': 1,
\         '__text__': 'visualmode',
\         'abbr': 'visualmode([expr])',
\         'menu': '[function]',
\         'word': 'visualmode',
\       },],
\     'wi': [{
\         '__func__': 1,
\         '__text__': 'wildmenumode',
\         'abbr': 'wildmenumode()',
\         'menu': '[function]',
\         'word': 'wildmenumode',
\       },{
\         '__func__': 1,
\         '__text__': 'win_findbuf',
\         'abbr': 'win_findbuf({bufnr})',
\         'menu': '[function]',
\         'word': 'win_findbuf',
\       },{
\         '__func__': 1,
\         '__text__': 'win_getid',
\         'abbr': 'win_getid([{win} [, {tab}]])',
\         'menu': '[function]',
\         'word': 'win_getid',
\       },{
\         '__func__': 1,
\         '__text__': 'win_gotoid',
\         'abbr': 'win_gotoid({expr})',
\         'menu': '[function]',
\         'word': 'win_gotoid',
\       },{
\         '__func__': 1,
\         '__text__': 'win_id2tabwin',
\         'abbr': 'win_id2tabwin({expr})',
\         'menu': '[function]',
\         'word': 'win_id2tabwin',
\       },{
\         '__func__': 1,
\         '__text__': 'win_id2win',
\         'abbr': 'win_id2win({expr})',
\         'menu': '[function]',
\         'word': 'win_id2win',
\       },{
\         '__func__': 1,
\         '__text__': 'win_screenpos',
\         'abbr': 'win_screenpos({nr})',
\         'menu': '[function]',
\         'word': 'win_screenpos',
\       },{
\         '__func__': 1,
\         '__text__': 'winbufnr',
\         'abbr': 'winbufnr({nr})',
\         'menu': '[function]',
\         'word': 'winbufnr',
\       },{
\         '__func__': 1,
\         '__text__': 'wincol',
\         'abbr': 'wincol()',
\         'menu': '[function]',
\         'word': 'wincol',
\       },{
\         '__func__': 1,
\         '__text__': 'winheight',
\         'abbr': 'winheight({nr})',
\         'menu': '[function]',
\         'word': 'winheight',
\       },{
\         '__func__': 1,
\         '__text__': 'winline',
\         'abbr': 'winline()',
\         'menu': '[function]',
\         'word': 'winline',
\       },{
\         '__func__': 1,
\         '__text__': 'winnr',
\         'abbr': 'winnr([{expr}])',
\         'menu': '[function]',
\         'word': 'winnr',
\       },{
\         '__func__': 1,
\         '__text__': 'winrestcmd',
\         'abbr': 'winrestcmd()',
\         'menu': '[function]',
\         'word': 'winrestcmd',
\       },{
\         '__func__': 1,
\         '__text__': 'winrestview',
\         'abbr': 'winrestview({dict})',
\         'menu': '[function]',
\         'word': 'winrestview',
\       },{
\         '__func__': 1,
\         '__text__': 'winsaveview',
\         'abbr': 'winsaveview()',
\         'menu': '[function]',
\         'word': 'winsaveview',
\       },{
\         '__func__': 1,
\         '__text__': 'winwidth',
\         'abbr': 'winwidth({nr})',
\         'menu': '[function]',
\         'word': 'winwidth',
\       },],
\     'wo': [{
\         '__func__': 1,
\         '__text__': 'wordcount',
\         'abbr': 'wordcount()',
\         'menu': '[function]',
\         'word': 'wordcount',
\       },],
\     'wr': [{
\         '__func__': 1,
\         '__text__': 'writefile',
\         'abbr': 'writefile({list}, {fname} [, {flags}])',
\         'menu': '[function]',
\         'word': 'writefile',
\       },],
\     'xo': [{
\         '__func__': 1,
\         '__text__': 'xor',
\         'abbr': 'xor({expr}, {expr})',
\         'menu': '[function]',
\         'word': 'xor',
\       },],
\   },
\   'indexlen': 2,
\   'name': 'function',
\   'wordlist': [{
\       '__func__': 1,
\       '__text__': 'abs',
\       'abbr': 'abs({expr})',
\       'menu': '[function]',
\       'word': 'abs',
\     },{
\       '__func__': 1,
\       '__text__': 'acos',
\       'abbr': 'acos({expr})',
\       'menu': '[function]',
\       'word': 'acos',
\     },{
\       '__func__': 1,
\       '__text__': 'add',
\       'abbr': 'add({list}, {item})',
\       'menu': '[function]',
\       'word': 'add',
\     },{
\       '__func__': 1,
\       '__text__': 'and',
\       'abbr': 'and({expr}, {expr})',
\       'menu': '[function]',
\       'word': 'and',
\     },{
\       '__func__': 1,
\       '__text__': 'append',
\       'abbr': 'append({lnum}, {string})',
\       'menu': '[function]',
\       'word': 'append',
\     },{
\       '__func__': 1,
\       '__text__': 'argc',
\       'abbr': 'argc()',
\       'menu': '[function]',
\       'word': 'argc',
\     },{
\       '__func__': 1,
\       '__text__': 'argidx',
\       'abbr': 'argidx()',
\       'menu': '[function]',
\       'word': 'argidx',
\     },{
\       '__func__': 1,
\       '__text__': 'arglistid',
\       'abbr': 'arglistid([{winnr} [, {tabnr}]])',
\       'menu': '[function]',
\       'word': 'arglistid',
\     },{
\       '__func__': 1,
\       '__text__': 'argv',
\       'abbr': 'argv({nr})',
\       'menu': '[function]',
\       'word': 'argv',
\     },{
\       '__func__': 1,
\       '__text__': 'asin',
\       'abbr': 'asin({expr})',
\       'menu': '[function]',
\       'word': 'asin',
\     },{
\       '__func__': 1,
\       '__text__': 'assert_beeps',
\       'abbr': 'assert_beeps({cmd})',
\       'menu': '[function]',
\       'word': 'assert_beeps',
\     },{
\       '__func__': 1,
\       '__text__': 'assert_equal',
\       'abbr': 'assert_equal({exp}, {act} [, {msg}])',
\       'menu': '[function]',
\       'word': 'assert_equal',
\     },{
\       '__func__': 1,
\       '__text__': 'assert_equalfile',
\       'abbr': 'assert_equalfile({fname-one}, {fname-two})',
\       'menu': '[function]',
\       'word': 'assert_equalfile',
\     },{
\       '__func__': 1,
\       '__text__': 'assert_exception',
\       'abbr': 'assert_exception({error} [, {msg}])',
\       'menu': '[function]',
\       'word': 'assert_exception',
\     },{
\       '__func__': 1,
\       '__text__': 'assert_fails',
\       'abbr': 'assert_fails({cmd} [, {error}])',
\       'menu': '[function]',
\       'word': 'assert_fails',
\     },{
\       '__func__': 1,
\       '__text__': 'assert_false',
\       'abbr': 'assert_false({actual} [, {msg}])',
\       'menu': '[function]',
\       'word': 'assert_false',
\     },{
\       '__func__': 1,
\       '__text__': 'assert_inrange',
\       'abbr': 'assert_inrange({lower}, {upper}, {actual} [, {msg}])',
\       'menu': '[function]',
\       'word': 'assert_inrange',
\     },{
\       '__func__': 1,
\       '__text__': 'assert_match',
\       'abbr': 'assert_match({pat}, {text} [, {msg}])',
\       'menu': '[function]',
\       'word': 'assert_match',
\     },{
\       '__func__': 1,
\       '__text__': 'assert_notequal',
\       'abbr': 'assert_notequal({exp}, {act} [, {msg}])',
\       'menu': '[function]',
\       'word': 'assert_notequal',
\     },{
\       '__func__': 1,
\       '__text__': 'assert_notmatch',
\       'abbr': 'assert_notmatch({pat}, {text} [, {msg}])',
\       'menu': '[function]',
\       'word': 'assert_notmatch',
\     },{
\       '__func__': 1,
\       '__text__': 'assert_report',
\       'abbr': 'assert_report({msg})',
\       'menu': '[function]',
\       'word': 'assert_report',
\     },{
\       '__func__': 1,
\       '__text__': 'assert_true',
\       'abbr': 'assert_true({actual} [, {msg}])',
\       'menu': '[function]',
\       'word': 'assert_true',
\     },{
\       '__func__': 1,
\       '__text__': 'atan',
\       'abbr': 'atan({expr})',
\       'menu': '[function]',
\       'word': 'atan',
\     },{
\       '__func__': 1,
\       '__text__': 'atan2',
\       'abbr': 'atan2({expr1}, {expr2})',
\       'menu': '[function]',
\       'word': 'atan2',
\     },{
\       '__func__': 1,
\       '__text__': 'balloon_show',
\       'abbr': 'balloon_show({expr})',
\       'menu': '[function]',
\       'word': 'balloon_show',
\     },{
\       '__func__': 1,
\       '__text__': 'browse',
\       'abbr': 'browse({save}, {title}, {initdir}, {default})',
\       'menu': '[function]',
\       'word': 'browse',
\     },{
\       '__func__': 1,
\       '__text__': 'browsedir',
\       'abbr': 'browsedir({title}, {initdir})',
\       'menu': '[function]',
\       'word': 'browsedir',
\     },{
\       '__func__': 1,
\       '__text__': 'bufexists',
\       'abbr': 'bufexists({expr})',
\       'menu': '[function]',
\       'word': 'bufexists',
\     },'buffer_exists','buffer_name','buffer_number',{
\       '__func__': 1,
\       '__text__': 'buflisted',
\       'abbr': 'buflisted({expr})',
\       'menu': '[function]',
\       'word': 'buflisted',
\     },{
\       '__func__': 1,
\       '__text__': 'bufloaded',
\       'abbr': 'bufloaded({expr})',
\       'menu': '[function]',
\       'word': 'bufloaded',
\     },{
\       '__func__': 1,
\       '__text__': 'bufname',
\       'abbr': 'bufname({expr})',
\       'menu': '[function]',
\       'word': 'bufname',
\     },{
\       '__func__': 1,
\       '__text__': 'bufnr',
\       'abbr': 'bufnr({expr} [, {create}])',
\       'menu': '[function]',
\       'word': 'bufnr',
\     },{
\       '__func__': 1,
\       '__text__': 'bufwinid',
\       'abbr': 'bufwinid({expr})',
\       'menu': '[function]',
\       'word': 'bufwinid',
\     },{
\       '__func__': 1,
\       '__text__': 'bufwinnr',
\       'abbr': 'bufwinnr({expr})',
\       'menu': '[function]',
\       'word': 'bufwinnr',
\     },{
\       '__func__': 1,
\       '__text__': 'byte2line',
\       'abbr': 'byte2line({byte})',
\       'menu': '[function]',
\       'word': 'byte2line',
\     },{
\       '__func__': 1,
\       '__text__': 'byteidx',
\       'abbr': 'byteidx({expr}, {nr})',
\       'menu': '[function]',
\       'word': 'byteidx',
\     },{
\       '__func__': 1,
\       '__text__': 'byteidxcomp',
\       'abbr': 'byteidxcomp({expr}, {nr})',
\       'menu': '[function]',
\       'word': 'byteidxcomp',
\     },{
\       '__func__': 1,
\       '__text__': 'call',
\       'abbr': 'call({func}, {arglist} [, {dict}])',
\       'menu': '[function]',
\       'word': 'call',
\     },{
\       '__func__': 1,
\       '__text__': 'ceil',
\       'abbr': 'ceil({expr})',
\       'menu': '[function]',
\       'word': 'ceil',
\     },{
\       '__func__': 1,
\       '__text__': 'ch_canread',
\       'abbr': 'ch_canread({handle})',
\       'menu': '[function]',
\       'word': 'ch_canread',
\     },{
\       '__func__': 1,
\       '__text__': 'ch_close',
\       'abbr': 'ch_close({handle})',
\       'menu': '[function]',
\       'word': 'ch_close',
\     },{
\       '__func__': 1,
\       '__text__': 'ch_close_in',
\       'abbr': 'ch_close_in({handle})',
\       'menu': '[function]',
\       'word': 'ch_close_in',
\     },{
\       '__func__': 1,
\       '__text__': 'ch_evalexpr',
\       'abbr': 'ch_evalexpr({handle}, {expr} [, {options}])',
\       'menu': '[function]',
\       'word': 'ch_evalexpr',
\     },{
\       '__func__': 1,
\       '__text__': 'ch_evalraw',
\       'abbr': 'ch_evalraw({handle}, {string} [, {options}])',
\       'menu': '[function]',
\       'word': 'ch_evalraw',
\     },{
\       '__func__': 1,
\       '__text__': 'ch_getbufnr',
\       'abbr': 'ch_getbufnr({handle}, {what})',
\       'menu': '[function]',
\       'word': 'ch_getbufnr',
\     },{
\       '__func__': 1,
\       '__text__': 'ch_getjob',
\       'abbr': 'ch_getjob({channel})',
\       'menu': '[function]',
\       'word': 'ch_getjob',
\     },{
\       '__func__': 1,
\       '__text__': 'ch_info',
\       'abbr': 'ch_info({handle})',
\       'menu': '[function]',
\       'word': 'ch_info',
\     },{
\       '__func__': 1,
\       '__text__': 'ch_log',
\       'abbr': 'ch_log({msg} [, {handle}])',
\       'menu': '[function]',
\       'word': 'ch_log',
\     },{
\       '__func__': 1,
\       '__text__': 'ch_logfile',
\       'abbr': 'ch_logfile({fname} [, {mode}])',
\       'menu': '[function]',
\       'word': 'ch_logfile',
\     },{
\       '__func__': 1,
\       '__text__': 'ch_open',
\       'abbr': 'ch_open({address} [, {options}])',
\       'menu': '[function]',
\       'word': 'ch_open',
\     },{
\       '__func__': 1,
\       '__text__': 'ch_read',
\       'abbr': 'ch_read({handle} [, {options}])',
\       'menu': '[function]',
\       'word': 'ch_read',
\     },{
\       '__func__': 1,
\       '__text__': 'ch_readraw',
\       'abbr': 'ch_readraw({handle} [, {options}])',
\       'menu': '[function]',
\       'word': 'ch_readraw',
\     },{
\       '__func__': 1,
\       '__text__': 'ch_sendexpr',
\       'abbr': 'ch_sendexpr({handle}, {expr} [, {options}])',
\       'menu': '[function]',
\       'word': 'ch_sendexpr',
\     },{
\       '__func__': 1,
\       '__text__': 'ch_sendraw',
\       'abbr': 'ch_sendraw({handle}, {string} [, {options}])',
\       'menu': '[function]',
\       'word': 'ch_sendraw',
\     },{
\       '__func__': 1,
\       '__text__': 'ch_setoptions',
\       'abbr': 'ch_setoptions({handle}, {options})',
\       'menu': '[function]',
\       'word': 'ch_setoptions',
\     },{
\       '__func__': 1,
\       '__text__': 'ch_status',
\       'abbr': 'ch_status({handle} [, {options}])',
\       'menu': '[function]',
\       'word': 'ch_status',
\     },{
\       '__func__': 1,
\       '__text__': 'changenr',
\       'abbr': 'changenr()',
\       'menu': '[function]',
\       'word': 'changenr',
\     },{
\       '__func__': 1,
\       '__text__': 'char2nr',
\       'abbr': 'char2nr({expr} [, {utf8}])',
\       'menu': '[function]',
\       'word': 'char2nr',
\     },{
\       '__func__': 1,
\       '__text__': 'cindent',
\       'abbr': 'cindent({lnum})',
\       'menu': '[function]',
\       'word': 'cindent',
\     },{
\       '__func__': 1,
\       '__text__': 'clearmatches',
\       'abbr': 'clearmatches()',
\       'menu': '[function]',
\       'word': 'clearmatches',
\     },{
\       '__func__': 1,
\       '__text__': 'col',
\       'abbr': 'col({expr})',
\       'menu': '[function]',
\       'word': 'col',
\     },{
\       '__func__': 1,
\       '__text__': 'complete',
\       'abbr': 'complete({startcol}, {matches})',
\       'menu': '[function]',
\       'word': 'complete',
\     },{
\       '__func__': 1,
\       '__text__': 'complete_add',
\       'abbr': 'complete_add({expr})',
\       'menu': '[function]',
\       'word': 'complete_add',
\     },{
\       '__func__': 1,
\       '__text__': 'complete_check',
\       'abbr': 'complete_check()',
\       'menu': '[function]',
\       'word': 'complete_check',
\     },{
\       '__func__': 1,
\       '__text__': 'confirm',
\       'abbr': 'confirm({msg} [, {choices} [, {default} [, {type}]]])',
\       'menu': '[function]',
\       'word': 'confirm',
\     },{
\       '__func__': 1,
\       '__text__': 'copy',
\       'abbr': 'copy({expr})',
\       'menu': '[function]',
\       'word': 'copy',
\     },{
\       '__func__': 1,
\       '__text__': 'cos',
\       'abbr': 'cos({expr})',
\       'menu': '[function]',
\       'word': 'cos',
\     },{
\       '__func__': 1,
\       '__text__': 'cosh',
\       'abbr': 'cosh({expr})',
\       'menu': '[function]',
\       'word': 'cosh',
\     },{
\       '__func__': 1,
\       '__text__': 'count',
\       'abbr': 'count({list}, {expr} [, {ic} [, {start}]])',
\       'menu': '[function]',
\       'word': 'count',
\     },{
\       '__func__': 1,
\       '__text__': 'cscope_connection',
\       'abbr': 'cscope_connection([{num}, {dbpath} [, {prepend}]])',
\       'menu': '[function]',
\       'word': 'cscope_connection',
\     },{
\       '__func__': 1,
\       '__text__': 'cursor',
\       'abbr': 'cursor({lnum}, {col} [, {off}])',
\       'menu': '[function]',
\       'word': 'cursor',
\     },{
\       '__func__': 1,
\       '__text__': 'deepcopy',
\       'abbr': 'deepcopy({expr} [, {noref}])',
\       'menu': '[function]',
\       'word': 'deepcopy',
\     },{
\       '__func__': 1,
\       '__text__': 'delete',
\       'abbr': 'delete({fname} [, {flags}])',
\       'menu': '[function]',
\       'word': 'delete',
\     },{
\       '__func__': 1,
\       '__text__': 'did_filetype',
\       'abbr': 'did_filetype()',
\       'menu': '[function]',
\       'word': 'did_filetype',
\     },{
\       '__func__': 1,
\       '__text__': 'diff_filler',
\       'abbr': 'diff_filler({lnum})',
\       'menu': '[function]',
\       'word': 'diff_filler',
\     },{
\       '__func__': 1,
\       '__text__': 'diff_hlID',
\       'abbr': 'diff_hlID({lnum}, {col})',
\       'menu': '[function]',
\       'word': 'diff_hlID',
\     },{
\       '__func__': 1,
\       '__text__': 'empty',
\       'abbr': 'empty({expr})',
\       'menu': '[function]',
\       'word': 'empty',
\     },{
\       '__func__': 1,
\       '__text__': 'escape',
\       'abbr': 'escape({string}, {chars})',
\       'menu': '[function]',
\       'word': 'escape',
\     },{
\       '__func__': 1,
\       '__text__': 'eval',
\       'abbr': 'eval({string})',
\       'menu': '[function]',
\       'word': 'eval',
\     },{
\       '__func__': 1,
\       '__text__': 'eventhandler',
\       'abbr': 'eventhandler()',
\       'menu': '[function]',
\       'word': 'eventhandler',
\     },{
\       '__func__': 1,
\       '__text__': 'executable',
\       'abbr': 'executable({expr})',
\       'menu': '[function]',
\       'word': 'executable',
\     },{
\       '__func__': 1,
\       '__text__': 'execute',
\       'abbr': 'execute({command})',
\       'menu': '[function]',
\       'word': 'execute',
\     },{
\       '__func__': 1,
\       '__text__': 'exepath',
\       'abbr': 'exepath({expr})',
\       'menu': '[function]',
\       'word': 'exepath',
\     },{
\       '__func__': 1,
\       '__text__': 'exists',
\       'abbr': 'exists({expr})',
\       'menu': '[function]',
\       'word': 'exists',
\     },{
\       '__func__': 1,
\       '__text__': 'exp',
\       'abbr': 'exp({expr})',
\       'menu': '[function]',
\       'word': 'exp',
\     },{
\       '__func__': 1,
\       '__text__': 'expand',
\       'abbr': 'expand({expr} [, {nosuf} [, {list}]])',
\       'menu': '[function]',
\       'word': 'expand',
\     },{
\       '__func__': 1,
\       '__text__': 'extend',
\       'abbr': 'extend({expr1}, {expr2} [, {expr3}])',
\       'menu': '[function]',
\       'word': 'extend',
\     },{
\       '__func__': 1,
\       '__text__': 'feedkeys',
\       'abbr': 'feedkeys({string} [, {mode}])',
\       'menu': '[function]',
\       'word': 'feedkeys',
\     },'file_readable',{
\       '__func__': 1,
\       '__text__': 'filereadable',
\       'abbr': 'filereadable({file})',
\       'menu': '[function]',
\       'word': 'filereadable',
\     },{
\       '__func__': 1,
\       '__text__': 'filewritable',
\       'abbr': 'filewritable({file})',
\       'menu': '[function]',
\       'word': 'filewritable',
\     },{
\       '__func__': 1,
\       '__text__': 'filter',
\       'abbr': 'filter({expr1}, {expr2})',
\       'menu': '[function]',
\       'word': 'filter',
\     },{
\       '__func__': 1,
\       '__text__': 'finddir',
\       'abbr': 'finddir({name} [, {path} [, {count}]])',
\       'menu': '[function]',
\       'word': 'finddir',
\     },{
\       '__func__': 1,
\       '__text__': 'findfile',
\       'abbr': 'findfile({name} [, {path} [, {count}]])',
\       'menu': '[function]',
\       'word': 'findfile',
\     },{
\       '__func__': 1,
\       '__text__': 'float2nr',
\       'abbr': 'float2nr({expr})',
\       'menu': '[function]',
\       'word': 'float2nr',
\     },{
\       '__func__': 1,
\       '__text__': 'floor',
\       'abbr': 'floor({expr})',
\       'menu': '[function]',
\       'word': 'floor',
\     },{
\       '__func__': 1,
\       '__text__': 'fmod',
\       'abbr': 'fmod({expr1}, {expr2})',
\       'menu': '[function]',
\       'word': 'fmod',
\     },{
\       '__func__': 1,
\       '__text__': 'fnameescape',
\       'abbr': 'fnameescape({fname})',
\       'menu': '[function]',
\       'word': 'fnameescape',
\     },{
\       '__func__': 1,
\       '__text__': 'fnamemodify',
\       'abbr': 'fnamemodify({fname}, {mods})',
\       'menu': '[function]',
\       'word': 'fnamemodify',
\     },{
\       '__func__': 1,
\       '__text__': 'foldclosed',
\       'abbr': 'foldclosed({lnum})',
\       'menu': '[function]',
\       'word': 'foldclosed',
\     },{
\       '__func__': 1,
\       '__text__': 'foldclosedend',
\       'abbr': 'foldclosedend({lnum})',
\       'menu': '[function]',
\       'word': 'foldclosedend',
\     },{
\       '__func__': 1,
\       '__text__': 'foldlevel',
\       'abbr': 'foldlevel({lnum})',
\       'menu': '[function]',
\       'word': 'foldlevel',
\     },{
\       '__func__': 1,
\       '__text__': 'foldtext',
\       'abbr': 'foldtext()',
\       'menu': '[function]',
\       'word': 'foldtext',
\     },{
\       '__func__': 1,
\       '__text__': 'foldtextresult',
\       'abbr': 'foldtextresult({lnum})',
\       'menu': '[function]',
\       'word': 'foldtextresult',
\     },{
\       '__func__': 1,
\       '__text__': 'foreground',
\       'abbr': 'foreground()',
\       'menu': '[function]',
\       'word': 'foreground',
\     },{
\       '__func__': 1,
\       '__text__': 'funcref',
\       'abbr': 'funcref({name} [, {arglist}] [, {dict}])',
\       'menu': '[function]',
\       'word': 'funcref',
\     },{
\       '__func__': 1,
\       '__text__': 'function',
\       'abbr': 'function({name} [, {arglist}] [, {dict}])',
\       'menu': '[function]',
\       'word': 'function',
\     },{
\       '__func__': 1,
\       '__text__': 'garbagecollect',
\       'abbr': 'garbagecollect([{atexit}])',
\       'menu': '[function]',
\       'word': 'garbagecollect',
\     },{
\       '__func__': 1,
\       '__text__': 'get',
\       'abbr': 'get({list}, {idx} [, {def}])',
\       'menu': '[function]',
\       'word': 'get',
\     },{
\       '__func__': 1,
\       '__text__': 'getbufinfo',
\       'abbr': 'getbufinfo([{expr}])',
\       'menu': '[function]',
\       'word': 'getbufinfo',
\     },{
\       '__func__': 1,
\       '__text__': 'getbufline',
\       'abbr': 'getbufline({expr}, {lnum} [, {end}])',
\       'menu': '[function]',
\       'word': 'getbufline',
\     },{
\       '__func__': 1,
\       '__text__': 'getbufvar',
\       'abbr': 'getbufvar({expr}, {varname} [, {def}])',
\       'menu': '[function]',
\       'word': 'getbufvar',
\     },{
\       '__func__': 1,
\       '__text__': 'getchangelist',
\       'abbr': 'getchangelist({expr})',
\       'menu': '[function]',
\       'word': 'getchangelist',
\     },{
\       '__func__': 1,
\       '__text__': 'getchar',
\       'abbr': 'getchar([expr])',
\       'menu': '[function]',
\       'word': 'getchar',
\     },{
\       '__func__': 1,
\       '__text__': 'getcharmod',
\       'abbr': 'getcharmod()',
\       'menu': '[function]',
\       'word': 'getcharmod',
\     },{
\       '__func__': 1,
\       '__text__': 'getcharsearch',
\       'abbr': 'getcharsearch()',
\       'menu': '[function]',
\       'word': 'getcharsearch',
\     },{
\       '__func__': 1,
\       '__text__': 'getcmdline',
\       'abbr': 'getcmdline()',
\       'menu': '[function]',
\       'word': 'getcmdline',
\     },{
\       '__func__': 1,
\       '__text__': 'getcmdpos',
\       'abbr': 'getcmdpos()',
\       'menu': '[function]',
\       'word': 'getcmdpos',
\     },{
\       '__func__': 1,
\       '__text__': 'getcmdtype',
\       'abbr': 'getcmdtype()',
\       'menu': '[function]',
\       'word': 'getcmdtype',
\     },{
\       '__func__': 1,
\       '__text__': 'getcmdwintype',
\       'abbr': 'getcmdwintype()',
\       'menu': '[function]',
\       'word': 'getcmdwintype',
\     },{
\       '__func__': 1,
\       '__text__': 'getcompletion',
\       'abbr': 'getcompletion({pat}, {type} [, {filtered}])',
\       'menu': '[function]',
\       'word': 'getcompletion',
\     },{
\       '__func__': 1,
\       '__text__': 'getcurpos',
\       'abbr': 'getcurpos()',
\       'menu': '[function]',
\       'word': 'getcurpos',
\     },{
\       '__func__': 1,
\       '__text__': 'getcwd',
\       'abbr': 'getcwd([{winnr} [, {tabnr}]])',
\       'menu': '[function]',
\       'word': 'getcwd',
\     },{
\       '__func__': 1,
\       '__text__': 'getfontname',
\       'abbr': 'getfontname([{name}])',
\       'menu': '[function]',
\       'word': 'getfontname',
\     },{
\       '__func__': 1,
\       '__text__': 'getfperm',
\       'abbr': 'getfperm({fname})',
\       'menu': '[function]',
\       'word': 'getfperm',
\     },{
\       '__func__': 1,
\       '__text__': 'getfsize',
\       'abbr': 'getfsize({fname})',
\       'menu': '[function]',
\       'word': 'getfsize',
\     },{
\       '__func__': 1,
\       '__text__': 'getftime',
\       'abbr': 'getftime({fname})',
\       'menu': '[function]',
\       'word': 'getftime',
\     },{
\       '__func__': 1,
\       '__text__': 'getftype',
\       'abbr': 'getftype({fname})',
\       'menu': '[function]',
\       'word': 'getftype',
\     },{
\       '__func__': 1,
\       '__text__': 'getjumplist',
\       'abbr': 'getjumplist([{winnr} [, {tabnr}]])',
\       'menu': '[function]',
\       'word': 'getjumplist',
\     },{
\       '__func__': 1,
\       '__text__': 'getline',
\       'abbr': 'getline({lnum})',
\       'menu': '[function]',
\       'word': 'getline',
\     },{
\       '__func__': 1,
\       '__text__': 'getloclist',
\       'abbr': 'getloclist({nr} [, {what}])',
\       'menu': '[function]',
\       'word': 'getloclist',
\     },{
\       '__func__': 1,
\       '__text__': 'getmatches',
\       'abbr': 'getmatches()',
\       'menu': '[function]',
\       'word': 'getmatches',
\     },{
\       '__func__': 1,
\       '__text__': 'getpid',
\       'abbr': 'getpid()',
\       'menu': '[function]',
\       'word': 'getpid',
\     },{
\       '__func__': 1,
\       '__text__': 'getpos',
\       'abbr': 'getpos({expr})',
\       'menu': '[function]',
\       'word': 'getpos',
\     },{
\       '__func__': 1,
\       '__text__': 'getqflist',
\       'abbr': 'getqflist([{what}])',
\       'menu': '[function]',
\       'word': 'getqflist',
\     },{
\       '__func__': 1,
\       '__text__': 'getreg',
\       'abbr': 'getreg([{regname} [, 1 [, {list}]]])',
\       'menu': '[function]',
\       'word': 'getreg',
\     },{
\       '__func__': 1,
\       '__text__': 'getregtype',
\       'abbr': 'getregtype([{regname}])',
\       'menu': '[function]',
\       'word': 'getregtype',
\     },{
\       '__func__': 1,
\       '__text__': 'gettabinfo',
\       'abbr': 'gettabinfo([{expr}])',
\       'menu': '[function]',
\       'word': 'gettabinfo',
\     },{
\       '__func__': 1,
\       '__text__': 'gettabvar',
\       'abbr': 'gettabvar({nr}, {varname} [, {def}])',
\       'menu': '[function]',
\       'word': 'gettabvar',
\     },{
\       '__func__': 1,
\       '__text__': 'gettabwinvar',
\       'abbr': 'gettabwinvar({tabnr}, {winnr}, {name} [, {def}])',
\       'menu': '[function]',
\       'word': 'gettabwinvar',
\     },{
\       '__func__': 1,
\       '__text__': 'getwininfo',
\       'abbr': 'getwininfo([{winid}])',
\       'menu': '[function]',
\       'word': 'getwininfo',
\     },{
\       '__func__': 1,
\       '__text__': 'getwinpos',
\       'abbr': 'getwinpos([{tmeout}])',
\       'menu': '[function]',
\       'word': 'getwinpos',
\     },{
\       '__func__': 1,
\       '__text__': 'getwinposx',
\       'abbr': 'getwinposx()',
\       'menu': '[function]',
\       'word': 'getwinposx',
\     },{
\       '__func__': 1,
\       '__text__': 'getwinposy',
\       'abbr': 'getwinposy()',
\       'menu': '[function]',
\       'word': 'getwinposy',
\     },{
\       '__func__': 1,
\       '__text__': 'getwinvar',
\       'abbr': 'getwinvar({nr}, {varname} [, {def}])',
\       'menu': '[function]',
\       'word': 'getwinvar',
\     },{
\       '__func__': 1,
\       '__text__': 'glob',
\       'abbr': 'glob({expr} [, {nosuf} [, {list} [, {alllinks}]]])',
\       'menu': '[function]',
\       'word': 'glob',
\     },{
\       '__func__': 1,
\       '__text__': 'glob2regpat',
\       'abbr': 'glob2regpat({expr})',
\       'menu': '[function]',
\       'word': 'glob2regpat',
\     },{
\       '__func__': 1,
\       '__text__': 'globpath',
\       'abbr': 'globpath({path}, {expr} [, {nosuf} [, {list} [, {alllinks}]]])',
\       'menu': '[function]',
\       'word': 'globpath',
\     },{
\       '__func__': 1,
\       '__text__': 'has',
\       'abbr': 'has({feature})',
\       'menu': '[function]',
\       'word': 'has',
\     },{
\       '__func__': 1,
\       '__text__': 'has_key',
\       'abbr': 'has_key({dict}, {key})',
\       'menu': '[function]',
\       'word': 'has_key',
\     },{
\       '__func__': 1,
\       '__text__': 'haslocaldir',
\       'abbr': 'haslocaldir([{winnr} [, {tabnr}]])',
\       'menu': '[function]',
\       'word': 'haslocaldir',
\     },{
\       '__func__': 1,
\       '__text__': 'hasmapto',
\       'abbr': 'hasmapto({what} [, {mode} [, {abbr}]])',
\       'menu': '[function]',
\       'word': 'hasmapto',
\     },'highlightID','highlight_exists',{
\       '__func__': 1,
\       '__text__': 'histadd',
\       'abbr': 'histadd({history}, {item})',
\       'menu': '[function]',
\       'word': 'histadd',
\     },{
\       '__func__': 1,
\       '__text__': 'histdel',
\       'abbr': 'histdel({history} [, {item}])',
\       'menu': '[function]',
\       'word': 'histdel',
\     },{
\       '__func__': 1,
\       '__text__': 'histget',
\       'abbr': 'histget({history} [, {index}])',
\       'menu': '[function]',
\       'word': 'histget',
\     },{
\       '__func__': 1,
\       '__text__': 'histnr',
\       'abbr': 'histnr({history})',
\       'menu': '[function]',
\       'word': 'histnr',
\     },{
\       '__func__': 1,
\       '__text__': 'hlID',
\       'abbr': 'hlID({name})',
\       'menu': '[function]',
\       'word': 'hlID',
\     },{
\       '__func__': 1,
\       '__text__': 'hlexists',
\       'abbr': 'hlexists({name})',
\       'menu': '[function]',
\       'word': 'hlexists',
\     },{
\       '__func__': 1,
\       '__text__': 'hostname',
\       'abbr': 'hostname()',
\       'menu': '[function]',
\       'word': 'hostname',
\     },{
\       '__func__': 1,
\       '__text__': 'iconv',
\       'abbr': 'iconv({expr}, {from}, {to})',
\       'menu': '[function]',
\       'word': 'iconv',
\     },{
\       '__func__': 1,
\       '__text__': 'indent',
\       'abbr': 'indent({lnum})',
\       'menu': '[function]',
\       'word': 'indent',
\     },{
\       '__func__': 1,
\       '__text__': 'index',
\       'abbr': 'index({list}, {expr} [, {start} [, {ic}]])',
\       'menu': '[function]',
\       'word': 'index',
\     },{
\       '__func__': 1,
\       '__text__': 'input',
\       'abbr': 'input({prompt} [, {text} [, {completion}]])',
\       'menu': '[function]',
\       'word': 'input',
\     },{
\       '__func__': 1,
\       '__text__': 'inputdialog',
\       'abbr': 'inputdialog({prompt} [, {text} [, {completion}]])',
\       'menu': '[function]',
\       'word': 'inputdialog',
\     },{
\       '__func__': 1,
\       '__text__': 'inputlist',
\       'abbr': 'inputlist({textlist})',
\       'menu': '[function]',
\       'word': 'inputlist',
\     },{
\       '__func__': 1,
\       '__text__': 'inputrestore',
\       'abbr': 'inputrestore()',
\       'menu': '[function]',
\       'word': 'inputrestore',
\     },{
\       '__func__': 1,
\       '__text__': 'inputsave',
\       'abbr': 'inputsave()',
\       'menu': '[function]',
\       'word': 'inputsave',
\     },{
\       '__func__': 1,
\       '__text__': 'inputsecret',
\       'abbr': 'inputsecret({prompt} [, {text}])',
\       'menu': '[function]',
\       'word': 'inputsecret',
\     },{
\       '__func__': 1,
\       '__text__': 'insert',
\       'abbr': 'insert({list}, {item} [, {idx}])',
\       'menu': '[function]',
\       'word': 'insert',
\     },{
\       '__func__': 1,
\       '__text__': 'invert',
\       'abbr': 'invert({expr})',
\       'menu': '[function]',
\       'word': 'invert',
\     },{
\       '__func__': 1,
\       '__text__': 'isdirectory',
\       'abbr': 'isdirectory({directory})',
\       'menu': '[function]',
\       'word': 'isdirectory',
\     },{
\       '__func__': 1,
\       '__text__': 'islocked',
\       'abbr': 'islocked({expr})',
\       'menu': '[function]',
\       'word': 'islocked',
\     },{
\       '__func__': 1,
\       '__text__': 'isnan',
\       'abbr': 'isnan({expr})',
\       'menu': '[function]',
\       'word': 'isnan',
\     },{
\       '__func__': 1,
\       '__text__': 'items',
\       'abbr': 'items({dict})',
\       'menu': '[function]',
\       'word': 'items',
\     },{
\       '__func__': 1,
\       '__text__': 'job_getchannel',
\       'abbr': 'job_getchannel({job})',
\       'menu': '[function]',
\       'word': 'job_getchannel',
\     },{
\       '__func__': 1,
\       '__text__': 'job_info',
\       'abbr': 'job_info({job})',
\       'menu': '[function]',
\       'word': 'job_info',
\     },{
\       '__func__': 1,
\       '__text__': 'job_setoptions',
\       'abbr': 'job_setoptions({job}, {options})',
\       'menu': '[function]',
\       'word': 'job_setoptions',
\     },{
\       '__func__': 1,
\       '__text__': 'job_start',
\       'abbr': 'job_start({command} [, {options}])',
\       'menu': '[function]',
\       'word': 'job_start',
\     },{
\       '__func__': 1,
\       '__text__': 'job_status',
\       'abbr': 'job_status({job})',
\       'menu': '[function]',
\       'word': 'job_status',
\     },{
\       '__func__': 1,
\       '__text__': 'job_stop',
\       'abbr': 'job_stop({job} [, {how}])',
\       'menu': '[function]',
\       'word': 'job_stop',
\     },{
\       '__func__': 1,
\       '__text__': 'join',
\       'abbr': 'join({list} [, {sep}])',
\       'menu': '[function]',
\       'word': 'join',
\     },{
\       '__func__': 1,
\       '__text__': 'js_decode',
\       'abbr': 'js_decode({string})',
\       'menu': '[function]',
\       'word': 'js_decode',
\     },{
\       '__func__': 1,
\       '__text__': 'js_encode',
\       'abbr': 'js_encode({expr})',
\       'menu': '[function]',
\       'word': 'js_encode',
\     },{
\       '__func__': 1,
\       '__text__': 'json_decode',
\       'abbr': 'json_decode({string})',
\       'menu': '[function]',
\       'word': 'json_decode',
\     },{
\       '__func__': 1,
\       '__text__': 'json_encode',
\       'abbr': 'json_encode({expr})',
\       'menu': '[function]',
\       'word': 'json_encode',
\     },{
\       '__func__': 1,
\       '__text__': 'keys',
\       'abbr': 'keys({dict})',
\       'menu': '[function]',
\       'word': 'keys',
\     },'last_buffer_nr',{
\       '__func__': 1,
\       '__text__': 'len',
\       'abbr': 'len({expr})',
\       'menu': '[function]',
\       'word': 'len',
\     },{
\       '__func__': 1,
\       '__text__': 'libcall',
\       'abbr': 'libcall({lib}, {func}, {arg})',
\       'menu': '[function]',
\       'word': 'libcall',
\     },{
\       '__func__': 1,
\       '__text__': 'libcallnr',
\       'abbr': 'libcallnr({lib}, {func}, {arg})',
\       'menu': '[function]',
\       'word': 'libcallnr',
\     },{
\       '__func__': 1,
\       '__text__': 'line',
\       'abbr': 'line({expr})',
\       'menu': '[function]',
\       'word': 'line',
\     },{
\       '__func__': 1,
\       '__text__': 'line2byte',
\       'abbr': 'line2byte({lnum})',
\       'menu': '[function]',
\       'word': 'line2byte',
\     },{
\       '__func__': 1,
\       '__text__': 'lispindent',
\       'abbr': 'lispindent({lnum})',
\       'menu': '[function]',
\       'word': 'lispindent',
\     },{
\       '__func__': 1,
\       '__text__': 'localtime',
\       'abbr': 'localtime()',
\       'menu': '[function]',
\       'word': 'localtime',
\     },{
\       '__func__': 1,
\       '__text__': 'log',
\       'abbr': 'log({expr})',
\       'menu': '[function]',
\       'word': 'log',
\     },{
\       '__func__': 1,
\       '__text__': 'log10',
\       'abbr': 'log10({expr})',
\       'menu': '[function]',
\       'word': 'log10',
\     },{
\       '__func__': 1,
\       '__text__': 'luaeval',
\       'abbr': 'luaeval({expr} [, {expr}])',
\       'menu': '[function]',
\       'word': 'luaeval',
\     },{
\       '__func__': 1,
\       '__text__': 'map',
\       'abbr': 'map({expr1}, {expr2})',
\       'menu': '[function]',
\       'word': 'map',
\     },{
\       '__func__': 1,
\       '__text__': 'maparg',
\       'abbr': 'maparg({name} [, {mode} [, {abbr} [, {dict}]]])',
\       'menu': '[function]',
\       'word': 'maparg',
\     },{
\       '__func__': 1,
\       '__text__': 'mapcheck',
\       'abbr': 'mapcheck({name} [, {mode} [, {abbr}]])',
\       'menu': '[function]',
\       'word': 'mapcheck',
\     },{
\       '__func__': 1,
\       '__text__': 'match',
\       'abbr': 'match({expr}, {pat} [, {start} [, {count}]])',
\       'menu': '[function]',
\       'word': 'match',
\     },{
\       '__func__': 1,
\       '__text__': 'matchadd',
\       'abbr': 'matchadd({group}, {pattern} [, {priority} [, {id} [, {dict}]]])',
\       'menu': '[function]',
\       'word': 'matchadd',
\     },{
\       '__func__': 1,
\       '__text__': 'matchaddpos',
\       'abbr': 'matchaddpos({group}, {pos} [, {priority} [, {id} [, {dict}]]])',
\       'menu': '[function]',
\       'word': 'matchaddpos',
\     },{
\       '__func__': 1,
\       '__text__': 'matcharg',
\       'abbr': 'matcharg({nr})',
\       'menu': '[function]',
\       'word': 'matcharg',
\     },{
\       '__func__': 1,
\       '__text__': 'matchdelete',
\       'abbr': 'matchdelete({id})',
\       'menu': '[function]',
\       'word': 'matchdelete',
\     },{
\       '__func__': 1,
\       '__text__': 'matchend',
\       'abbr': 'matchend({expr}, {pat} [, {start} [, {count}]])',
\       'menu': '[function]',
\       'word': 'matchend',
\     },{
\       '__func__': 1,
\       '__text__': 'matchlist',
\       'abbr': 'matchlist({expr}, {pat} [, {start} [, {count}]])',
\       'menu': '[function]',
\       'word': 'matchlist',
\     },{
\       '__func__': 1,
\       '__text__': 'matchstr',
\       'abbr': 'matchstr({expr}, {pat} [, {start} [, {count}]])',
\       'menu': '[function]',
\       'word': 'matchstr',
\     },{
\       '__func__': 1,
\       '__text__': 'matchstrpos',
\       'abbr': 'matchstrpos({expr}, {pat} [, {start} [, {count}]])',
\       'menu': '[function]',
\       'word': 'matchstrpos',
\     },{
\       '__func__': 1,
\       '__text__': 'max',
\       'abbr': 'max({expr})',
\       'menu': '[function]',
\       'word': 'max',
\     },{
\       '__func__': 1,
\       '__text__': 'min',
\       'abbr': 'min({expr})',
\       'menu': '[function]',
\       'word': 'min',
\     },{
\       '__func__': 1,
\       '__text__': 'mkdir',
\       'abbr': 'mkdir({name} [, {path} [, {prot}]])',
\       'menu': '[function]',
\       'word': 'mkdir',
\     },{
\       '__func__': 1,
\       '__text__': 'mode',
\       'abbr': 'mode([expr])',
\       'menu': '[function]',
\       'word': 'mode',
\     },{
\       '__func__': 1,
\       '__text__': 'nextnonblank',
\       'abbr': 'nextnonblank({lnum})',
\       'menu': '[function]',
\       'word': 'nextnonblank',
\     },{
\       '__func__': 1,
\       '__text__': 'nr2char',
\       'abbr': 'nr2char({expr} [, {utf8}])',
\       'menu': '[function]',
\       'word': 'nr2char',
\     },{
\       '__func__': 1,
\       '__text__': 'or',
\       'abbr': 'or({expr}, {expr})',
\       'menu': '[function]',
\       'word': 'or',
\     },{
\       '__func__': 1,
\       '__text__': 'pathshorten',
\       'abbr': 'pathshorten({expr})',
\       'menu': '[function]',
\       'word': 'pathshorten',
\     },{
\       '__func__': 1,
\       '__text__': 'pow',
\       'abbr': 'pow({x}, {y})',
\       'menu': '[function]',
\       'word': 'pow',
\     },{
\       '__func__': 1,
\       '__text__': 'prevnonblank',
\       'abbr': 'prevnonblank({lnum})',
\       'menu': '[function]',
\       'word': 'prevnonblank',
\     },{
\       '__func__': 1,
\       '__text__': 'printf',
\       'abbr': 'printf({fmt}, {expr1}...)',
\       'menu': '[function]',
\       'word': 'printf',
\     },{
\       '__func__': 1,
\       '__text__': 'pumvisible',
\       'abbr': 'pumvisible()',
\       'menu': '[function]',
\       'word': 'pumvisible',
\     },{
\       '__func__': 1,
\       '__text__': 'py3eval',
\       'abbr': 'py3eval({expr})',
\       'menu': '[function]',
\       'word': 'py3eval',
\     },{
\       '__func__': 1,
\       '__text__': 'pyeval',
\       'abbr': 'pyeval({expr})',
\       'menu': '[function]',
\       'word': 'pyeval',
\     },{
\       '__func__': 1,
\       '__text__': 'pyxeval',
\       'abbr': 'pyxeval({expr})',
\       'menu': '[function]',
\       'word': 'pyxeval',
\     },{
\       '__func__': 1,
\       '__text__': 'range',
\       'abbr': 'range({expr} [, {max} [, {stride}]])',
\       'menu': '[function]',
\       'word': 'range',
\     },{
\       '__func__': 1,
\       '__text__': 'readfile',
\       'abbr': 'readfile({fname} [, {binary} [, {max}]])',
\       'menu': '[function]',
\       'word': 'readfile',
\     },{
\       '__func__': 1,
\       '__text__': 'reltime',
\       'abbr': 'reltime([{start} [, {end}]])',
\       'menu': '[function]',
\       'word': 'reltime',
\     },{
\       '__func__': 1,
\       '__text__': 'reltimefloat',
\       'abbr': 'reltimefloat({time})',
\       'menu': '[function]',
\       'word': 'reltimefloat',
\     },{
\       '__func__': 1,
\       '__text__': 'reltimestr',
\       'abbr': 'reltimestr({time})',
\       'menu': '[function]',
\       'word': 'reltimestr',
\     },{
\       '__func__': 1,
\       '__text__': 'remote_expr',
\       'abbr': 'remote_expr({server}, {string} [, {idvar} [, {timeout}]])',
\       'menu': '[function]',
\       'word': 'remote_expr',
\     },{
\       '__func__': 1,
\       '__text__': 'remote_foreground',
\       'abbr': 'remote_foreground({server})',
\       'menu': '[function]',
\       'word': 'remote_foreground',
\     },{
\       '__func__': 1,
\       '__text__': 'remote_peek',
\       'abbr': 'remote_peek({serverid} [, {retvar}])',
\       'menu': '[function]',
\       'word': 'remote_peek',
\     },{
\       '__func__': 1,
\       '__text__': 'remote_read',
\       'abbr': 'remote_read({serverid} [, {timeout}])',
\       'menu': '[function]',
\       'word': 'remote_read',
\     },{
\       '__func__': 1,
\       '__text__': 'remote_send',
\       'abbr': 'remote_send({server}, {string} [, {idvar}])',
\       'menu': '[function]',
\       'word': 'remote_send',
\     },{
\       '__func__': 1,
\       '__text__': 'remote_startserver',
\       'abbr': 'remote_startserver({name})',
\       'menu': '[function]',
\       'word': 'remote_startserver',
\     },{
\       '__func__': 1,
\       '__text__': 'remove',
\       'abbr': 'remove({list}, {idx} [, {end}])',
\       'menu': '[function]',
\       'word': 'remove',
\     },{
\       '__func__': 1,
\       '__text__': 'rename',
\       'abbr': 'rename({from}, {to})',
\       'menu': '[function]',
\       'word': 'rename',
\     },{
\       '__func__': 1,
\       '__text__': 'repeat',
\       'abbr': 'repeat({expr}, {count})',
\       'menu': '[function]',
\       'word': 'repeat',
\     },{
\       '__func__': 1,
\       '__text__': 'resolve',
\       'abbr': 'resolve({filename})',
\       'menu': '[function]',
\       'word': 'resolve',
\     },{
\       '__func__': 1,
\       '__text__': 'reverse',
\       'abbr': 'reverse({list})',
\       'menu': '[function]',
\       'word': 'reverse',
\     },{
\       '__func__': 1,
\       '__text__': 'round',
\       'abbr': 'round({expr})',
\       'menu': '[function]',
\       'word': 'round',
\     },{
\       '__func__': 1,
\       '__text__': 'screenattr',
\       'abbr': 'screenattr({row}, {col})',
\       'menu': '[function]',
\       'word': 'screenattr',
\     },{
\       '__func__': 1,
\       '__text__': 'screenchar',
\       'abbr': 'screenchar({row}, {col})',
\       'menu': '[function]',
\       'word': 'screenchar',
\     },{
\       '__func__': 1,
\       '__text__': 'screencol',
\       'abbr': 'screencol()',
\       'menu': '[function]',
\       'word': 'screencol',
\     },{
\       '__func__': 1,
\       '__text__': 'screenrow',
\       'abbr': 'screenrow()',
\       'menu': '[function]',
\       'word': 'screenrow',
\     },{
\       '__func__': 1,
\       '__text__': 'search',
\       'abbr': 'search({pattern} [, {flags} [, {stopline} [, {timeout}]]])',
\       'menu': '[function]',
\       'word': 'search',
\     },{
\       '__func__': 1,
\       '__text__': 'searchdecl',
\       'abbr': 'searchdecl({name} [, {global} [, {thisblock}]])',
\       'menu': '[function]',
\       'word': 'searchdecl',
\     },{
\       '__func__': 1,
\       '__text__': 'searchpair',
\       'abbr': 'searchpair({start}, {middle}, {end} [, {flags} [, {skip} [...]]])',
\       'menu': '[function]',
\       'word': 'searchpair',
\     },{
\       '__func__': 1,
\       '__text__': 'searchpairpos',
\       'abbr': 'searchpairpos({start}, {middle}, {end} [, {flags} [, {skip} [...]]])',
\       'menu': '[function]',
\       'word': 'searchpairpos',
\     },{
\       '__func__': 1,
\       '__text__': 'searchpos',
\       'abbr': 'searchpos({pattern} [, {flags} [, {stopline} [, {timeout}]]])',
\       'menu': '[function]',
\       'word': 'searchpos',
\     },{
\       '__func__': 1,
\       '__text__': 'server2client',
\       'abbr': 'server2client({clientid}, {string})',
\       'menu': '[function]',
\       'word': 'server2client',
\     },{
\       '__func__': 1,
\       '__text__': 'serverlist',
\       'abbr': 'serverlist()',
\       'menu': '[function]',
\       'word': 'serverlist',
\     },{
\       '__func__': 1,
\       '__text__': 'setbufline',
\       'abbr': 'setbufline({expr}, {lnum}, {line})',
\       'menu': '[function]',
\       'word': 'setbufline',
\     },{
\       '__func__': 1,
\       '__text__': 'setbufvar',
\       'abbr': 'setbufvar({expr}, {varname}, {val})',
\       'menu': '[function]',
\       'word': 'setbufvar',
\     },{
\       '__func__': 1,
\       '__text__': 'setcharsearch',
\       'abbr': 'setcharsearch({dict})',
\       'menu': '[function]',
\       'word': 'setcharsearch',
\     },{
\       '__func__': 1,
\       '__text__': 'setcmdpos',
\       'abbr': 'setcmdpos({pos})',
\       'menu': '[function]',
\       'word': 'setcmdpos',
\     },{
\       '__func__': 1,
\       '__text__': 'setfperm',
\       'abbr': 'setfperm({fname}, {mode})',
\       'menu': '[function]',
\       'word': 'setfperm',
\     },{
\       '__func__': 1,
\       '__text__': 'setline',
\       'abbr': 'setline({lnum}, {line})',
\       'menu': '[function]',
\       'word': 'setline',
\     },{
\       '__func__': 1,
\       '__text__': 'setloclist',
\       'abbr': 'setloclist({nr}, {list} [, {action} [, {what}]])',
\       'menu': '[function]',
\       'word': 'setloclist',
\     },{
\       '__func__': 1,
\       '__text__': 'setmatches',
\       'abbr': 'setmatches({list})',
\       'menu': '[function]',
\       'word': 'setmatches',
\     },{
\       '__func__': 1,
\       '__text__': 'setpos',
\       'abbr': 'setpos({expr}, {list})',
\       'menu': '[function]',
\       'word': 'setpos',
\     },{
\       '__func__': 1,
\       '__text__': 'setqflist',
\       'abbr': 'setqflist({list} [, {action} [, {what}]])',
\       'menu': '[function]',
\       'word': 'setqflist',
\     },{
\       '__func__': 1,
\       '__text__': 'setreg',
\       'abbr': 'setreg({n}, {v} [, {opt}])',
\       'menu': '[function]',
\       'word': 'setreg',
\     },{
\       '__func__': 1,
\       '__text__': 'settabvar',
\       'abbr': 'settabvar({nr}, {varname}, {val})',
\       'menu': '[function]',
\       'word': 'settabvar',
\     },{
\       '__func__': 1,
\       '__text__': 'settabwinvar',
\       'abbr': 'settabwinvar({tabnr}, {winnr}, {varname}, {val})',
\       'menu': '[function]',
\       'word': 'settabwinvar',
\     },{
\       '__func__': 1,
\       '__text__': 'setwinvar',
\       'abbr': 'setwinvar({nr}, {varname}, {val})',
\       'menu': '[function]',
\       'word': 'setwinvar',
\     },{
\       '__func__': 1,
\       '__text__': 'sha256',
\       'abbr': 'sha256({string})',
\       'menu': '[function]',
\       'word': 'sha256',
\     },{
\       '__func__': 1,
\       '__text__': 'shellescape',
\       'abbr': 'shellescape({string} [, {special}])',
\       'menu': '[function]',
\       'word': 'shellescape',
\     },{
\       '__func__': 1,
\       '__text__': 'shiftwidth',
\       'abbr': 'shiftwidth()',
\       'menu': '[function]',
\       'word': 'shiftwidth',
\     },{
\       '__func__': 1,
\       '__text__': 'simplify',
\       'abbr': 'simplify({filename})',
\       'menu': '[function]',
\       'word': 'simplify',
\     },{
\       '__func__': 1,
\       '__text__': 'sin',
\       'abbr': 'sin({expr})',
\       'menu': '[function]',
\       'word': 'sin',
\     },{
\       '__func__': 1,
\       '__text__': 'sinh',
\       'abbr': 'sinh({expr})',
\       'menu': '[function]',
\       'word': 'sinh',
\     },{
\       '__func__': 1,
\       '__text__': 'sort',
\       'abbr': 'sort({list} [, {func} [, {dict}]])',
\       'menu': '[function]',
\       'word': 'sort',
\     },{
\       '__func__': 1,
\       '__text__': 'soundfold',
\       'abbr': 'soundfold({word})',
\       'menu': '[function]',
\       'word': 'soundfold',
\     },{
\       '__func__': 1,
\       '__text__': 'spellbadword',
\       'abbr': 'spellbadword()',
\       'menu': '[function]',
\       'word': 'spellbadword',
\     },{
\       '__func__': 1,
\       '__text__': 'spellsuggest',
\       'abbr': 'spellsuggest({word} [, {max} [, {capital}]])',
\       'menu': '[function]',
\       'word': 'spellsuggest',
\     },{
\       '__func__': 1,
\       '__text__': 'split',
\       'abbr': 'split({expr} [, {pat} [, {keepempty}]])',
\       'menu': '[function]',
\       'word': 'split',
\     },{
\       '__func__': 1,
\       '__text__': 'sqrt',
\       'abbr': 'sqrt({expr})',
\       'menu': '[function]',
\       'word': 'sqrt',
\     },{
\       '__func__': 1,
\       '__text__': 'str2float',
\       'abbr': 'str2float({expr})',
\       'menu': '[function]',
\       'word': 'str2float',
\     },{
\       '__func__': 1,
\       '__text__': 'str2nr',
\       'abbr': 'str2nr({expr} [, {base}])',
\       'menu': '[function]',
\       'word': 'str2nr',
\     },{
\       '__func__': 1,
\       '__text__': 'strcharpart',
\       'abbr': 'strcharpart({str}, {start} [, {len}])',
\       'menu': '[function]',
\       'word': 'strcharpart',
\     },{
\       '__func__': 1,
\       '__text__': 'strchars',
\       'abbr': 'strchars({expr} [, {skipcc}])',
\       'menu': '[function]',
\       'word': 'strchars',
\     },{
\       '__func__': 1,
\       '__text__': 'strdisplaywidth',
\       'abbr': 'strdisplaywidth({expr} [, {col}])',
\       'menu': '[function]',
\       'word': 'strdisplaywidth',
\     },{
\       '__func__': 1,
\       '__text__': 'strftime',
\       'abbr': 'strftime({format} [, {time}])',
\       'menu': '[function]',
\       'word': 'strftime',
\     },{
\       '__func__': 1,
\       '__text__': 'strgetchar',
\       'abbr': 'strgetchar({str}, {index})',
\       'menu': '[function]',
\       'word': 'strgetchar',
\     },{
\       '__func__': 1,
\       '__text__': 'stridx',
\       'abbr': 'stridx({haystack}, {needle} [, {start}])',
\       'menu': '[function]',
\       'word': 'stridx',
\     },{
\       '__func__': 1,
\       '__text__': 'string',
\       'abbr': 'string({expr})',
\       'menu': '[function]',
\       'word': 'string',
\     },{
\       '__func__': 1,
\       '__text__': 'strlen',
\       'abbr': 'strlen({expr})',
\       'menu': '[function]',
\       'word': 'strlen',
\     },{
\       '__func__': 1,
\       '__text__': 'strpart',
\       'abbr': 'strpart({str}, {start} [, {len}])',
\       'menu': '[function]',
\       'word': 'strpart',
\     },{
\       '__func__': 1,
\       '__text__': 'strridx',
\       'abbr': 'strridx({haystack}, {needle} [, {start}])',
\       'menu': '[function]',
\       'word': 'strridx',
\     },{
\       '__func__': 1,
\       '__text__': 'strtrans',
\       'abbr': 'strtrans({expr})',
\       'menu': '[function]',
\       'word': 'strtrans',
\     },{
\       '__func__': 1,
\       '__text__': 'strwidth',
\       'abbr': 'strwidth({expr})',
\       'menu': '[function]',
\       'word': 'strwidth',
\     },{
\       '__func__': 1,
\       '__text__': 'submatch',
\       'abbr': 'submatch({nr} [, {list}])',
\       'menu': '[function]',
\       'word': 'submatch',
\     },{
\       '__func__': 1,
\       '__text__': 'substitute',
\       'abbr': 'substitute({expr}, {pat}, {sub}, {flags})',
\       'menu': '[function]',
\       'word': 'substitute',
\     },{
\       '__func__': 1,
\       '__text__': 'synID',
\       'abbr': 'synID({lnum}, {col}, {trans})',
\       'menu': '[function]',
\       'word': 'synID',
\     },{
\       '__func__': 1,
\       '__text__': 'synIDattr',
\       'abbr': 'synIDattr({synID}, {what} [, {mode}])',
\       'menu': '[function]',
\       'word': 'synIDattr',
\     },{
\       '__func__': 1,
\       '__text__': 'synIDtrans',
\       'abbr': 'synIDtrans({synID})',
\       'menu': '[function]',
\       'word': 'synIDtrans',
\     },{
\       '__func__': 1,
\       '__text__': 'synconcealed',
\       'abbr': 'synconcealed({lnum}, {col})',
\       'menu': '[function]',
\       'word': 'synconcealed',
\     },{
\       '__func__': 1,
\       '__text__': 'synstack',
\       'abbr': 'synstack({lnum}, {col})',
\       'menu': '[function]',
\       'word': 'synstack',
\     },{
\       '__func__': 1,
\       '__text__': 'system',
\       'abbr': 'system({expr} [, {input}])',
\       'menu': '[function]',
\       'word': 'system',
\     },{
\       '__func__': 1,
\       '__text__': 'systemlist',
\       'abbr': 'systemlist({expr} [, {input}])',
\       'menu': '[function]',
\       'word': 'systemlist',
\     },{
\       '__func__': 1,
\       '__text__': 'tabpagebuflist',
\       'abbr': 'tabpagebuflist([{arg}])',
\       'menu': '[function]',
\       'word': 'tabpagebuflist',
\     },{
\       '__func__': 1,
\       '__text__': 'tabpagenr',
\       'abbr': 'tabpagenr([{arg}])',
\       'menu': '[function]',
\       'word': 'tabpagenr',
\     },{
\       '__func__': 1,
\       '__text__': 'tabpagewinnr',
\       'abbr': 'tabpagewinnr({tabarg} [, {arg}])',
\       'menu': '[function]',
\       'word': 'tabpagewinnr',
\     },{
\       '__func__': 1,
\       '__text__': 'tagfiles',
\       'abbr': 'tagfiles()',
\       'menu': '[function]',
\       'word': 'tagfiles',
\     },{
\       '__func__': 1,
\       '__text__': 'taglist',
\       'abbr': 'taglist({expr} [, {filename}])',
\       'menu': '[function]',
\       'word': 'taglist',
\     },{
\       '__func__': 1,
\       '__text__': 'tan',
\       'abbr': 'tan({expr})',
\       'menu': '[function]',
\       'word': 'tan',
\     },{
\       '__func__': 1,
\       '__text__': 'tanh',
\       'abbr': 'tanh({expr})',
\       'menu': '[function]',
\       'word': 'tanh',
\     },{
\       '__func__': 1,
\       '__text__': 'tempname',
\       'abbr': 'tempname()',
\       'menu': '[function]',
\       'word': 'tempname',
\     },{
\       '__func__': 1,
\       '__text__': 'term_dumpdiff',
\       'abbr': 'term_dumpdiff({filename}, {filename} [, {options}])',
\       'menu': '[function]',
\       'word': 'term_dumpdiff',
\     },{
\       '__func__': 1,
\       '__text__': 'term_dumpload',
\       'abbr': 'term_dumpload({filename} [, {options}])',
\       'menu': '[function]',
\       'word': 'term_dumpload',
\     },{
\       '__func__': 1,
\       '__text__': 'term_dumpwrite',
\       'abbr': 'term_dumpwrite({buf}, {filename} [, {options}])',
\       'menu': '[function]',
\       'word': 'term_dumpwrite',
\     },{
\       '__func__': 1,
\       '__text__': 'term_getaltscreen',
\       'abbr': 'term_getaltscreen({buf})',
\       'menu': '[function]',
\       'word': 'term_getaltscreen',
\     },{
\       '__func__': 1,
\       '__text__': 'term_getattr',
\       'abbr': 'term_getattr({attr}, {what})',
\       'menu': '[function]',
\       'word': 'term_getattr',
\     },{
\       '__func__': 1,
\       '__text__': 'term_getcursor',
\       'abbr': 'term_getcursor({buf})',
\       'menu': '[function]',
\       'word': 'term_getcursor',
\     },{
\       '__func__': 1,
\       '__text__': 'term_getjob',
\       'abbr': 'term_getjob({buf})',
\       'menu': '[function]',
\       'word': 'term_getjob',
\     },{
\       '__func__': 1,
\       '__text__': 'term_getline',
\       'abbr': 'term_getline({buf}, {row})',
\       'menu': '[function]',
\       'word': 'term_getline',
\     },{
\       '__func__': 1,
\       '__text__': 'term_getscrolled',
\       'abbr': 'term_getscrolled({buf})',
\       'menu': '[function]',
\       'word': 'term_getscrolled',
\     },{
\       '__func__': 1,
\       '__text__': 'term_getsize',
\       'abbr': 'term_getsize({buf})',
\       'menu': '[function]',
\       'word': 'term_getsize',
\     },{
\       '__func__': 1,
\       '__text__': 'term_getstatus',
\       'abbr': 'term_getstatus({buf})',
\       'menu': '[function]',
\       'word': 'term_getstatus',
\     },{
\       '__func__': 1,
\       '__text__': 'term_gettitle',
\       'abbr': 'term_gettitle({buf})',
\       'menu': '[function]',
\       'word': 'term_gettitle',
\     },{
\       '__func__': 1,
\       '__text__': 'term_gettty',
\       'abbr': 'term_gettty({buf}, [{input}])',
\       'menu': '[function]',
\       'word': 'term_gettty',
\     },{
\       '__func__': 1,
\       '__text__': 'term_list',
\       'abbr': 'term_list()',
\       'menu': '[function]',
\       'word': 'term_list',
\     },{
\       '__func__': 1,
\       '__text__': 'term_scrape',
\       'abbr': 'term_scrape({buf}, {row})',
\       'menu': '[function]',
\       'word': 'term_scrape',
\     },{
\       '__func__': 1,
\       '__text__': 'term_sendkeys',
\       'abbr': 'term_sendkeys({buf}, {keys})',
\       'menu': '[function]',
\       'word': 'term_sendkeys',
\     },{
\       '__func__': 1,
\       '__text__': 'term_start',
\       'abbr': 'term_start({cmd}, {options})',
\       'menu': '[function]',
\       'word': 'term_start',
\     },{
\       '__func__': 1,
\       '__text__': 'term_wait',
\       'abbr': 'term_wait({buf} [, {time}])',
\       'menu': '[function]',
\       'word': 'term_wait',
\     },{
\       '__func__': 1,
\       '__text__': 'test_alloc_fail',
\       'abbr': 'test_alloc_fail({id}, {countdown}, {repeat})',
\       'menu': '[function]',
\       'word': 'test_alloc_fail',
\     },{
\       '__func__': 1,
\       '__text__': 'test_autochdir',
\       'abbr': 'test_autochdir()',
\       'menu': '[function]',
\       'word': 'test_autochdir',
\     },{
\       '__func__': 1,
\       '__text__': 'test_feedinput',
\       'abbr': 'test_feedinput()',
\       'menu': '[function]',
\       'word': 'test_feedinput',
\     },{
\       '__func__': 1,
\       '__text__': 'test_garbagecollect_now',
\       'abbr': 'test_garbagecollect_now()',
\       'menu': '[function]',
\       'word': 'test_garbagecollect_now',
\     },{
\       '__func__': 1,
\       '__text__': 'test_ignore_error',
\       'abbr': 'test_ignore_error({expr})',
\       'menu': '[function]',
\       'word': 'test_ignore_error',
\     },{
\       '__func__': 1,
\       '__text__': 'test_null_channel',
\       'abbr': 'test_null_channel()',
\       'menu': '[function]',
\       'word': 'test_null_channel',
\     },{
\       '__func__': 1,
\       '__text__': 'test_null_dict',
\       'abbr': 'test_null_dict()',
\       'menu': '[function]',
\       'word': 'test_null_dict',
\     },{
\       '__func__': 1,
\       '__text__': 'test_null_job',
\       'abbr': 'test_null_job()',
\       'menu': '[function]',
\       'word': 'test_null_job',
\     },{
\       '__func__': 1,
\       '__text__': 'test_null_list',
\       'abbr': 'test_null_list()',
\       'menu': '[function]',
\       'word': 'test_null_list',
\     },{
\       '__func__': 1,
\       '__text__': 'test_null_partial',
\       'abbr': 'test_null_partial()',
\       'menu': '[function]',
\       'word': 'test_null_partial',
\     },{
\       '__func__': 1,
\       '__text__': 'test_null_string',
\       'abbr': 'test_null_string()',
\       'menu': '[function]',
\       'word': 'test_null_string',
\     },{
\       '__func__': 1,
\       '__text__': 'test_override',
\       'abbr': 'test_override({expr}, {val})',
\       'menu': '[function]',
\       'word': 'test_override',
\     },{
\       '__func__': 1,
\       '__text__': 'test_settime',
\       'abbr': 'test_settime({expr})',
\       'menu': '[function]',
\       'word': 'test_settime',
\     },{
\       '__func__': 1,
\       '__text__': 'timer_info',
\       'abbr': 'timer_info([{id}])',
\       'menu': '[function]',
\       'word': 'timer_info',
\     },{
\       '__func__': 1,
\       '__text__': 'timer_pause',
\       'abbr': 'timer_pause({id}, {pause})',
\       'menu': '[function]',
\       'word': 'timer_pause',
\     },{
\       '__func__': 1,
\       '__text__': 'timer_start',
\       'abbr': 'timer_start({time}, {callback} [, {options}])',
\       'menu': '[function]',
\       'word': 'timer_start',
\     },{
\       '__func__': 1,
\       '__text__': 'timer_stop',
\       'abbr': 'timer_stop({timer})',
\       'menu': '[function]',
\       'word': 'timer_stop',
\     },{
\       '__func__': 1,
\       '__text__': 'timer_stopall',
\       'abbr': 'timer_stopall()',
\       'menu': '[function]',
\       'word': 'timer_stopall',
\     },{
\       '__func__': 1,
\       '__text__': 'tolower',
\       'abbr': 'tolower({expr})',
\       'menu': '[function]',
\       'word': 'tolower',
\     },{
\       '__func__': 1,
\       '__text__': 'toupper',
\       'abbr': 'toupper({expr})',
\       'menu': '[function]',
\       'word': 'toupper',
\     },{
\       '__func__': 1,
\       '__text__': 'tr',
\       'abbr': 'tr({src}, {fromstr}, {tostr})',
\       'menu': '[function]',
\       'word': 'tr',
\     },{
\       '__func__': 1,
\       '__text__': 'trunc',
\       'abbr': 'trunc({expr})',
\       'menu': '[function]',
\       'word': 'trunc',
\     },{
\       '__func__': 1,
\       '__text__': 'type',
\       'abbr': 'type({name})',
\       'menu': '[function]',
\       'word': 'type',
\     },{
\       '__func__': 1,
\       '__text__': 'undofile',
\       'abbr': 'undofile({name})',
\       'menu': '[function]',
\       'word': 'undofile',
\     },{
\       '__func__': 1,
\       '__text__': 'undotree',
\       'abbr': 'undotree()',
\       'menu': '[function]',
\       'word': 'undotree',
\     },{
\       '__func__': 1,
\       '__text__': 'uniq',
\       'abbr': 'uniq({list} [, {func} [, {dict}]])',
\       'menu': '[function]',
\       'word': 'uniq',
\     },{
\       '__func__': 1,
\       '__text__': 'values',
\       'abbr': 'values({dict})',
\       'menu': '[function]',
\       'word': 'values',
\     },{
\       '__func__': 1,
\       '__text__': 'virtcol',
\       'abbr': 'virtcol({expr})',
\       'menu': '[function]',
\       'word': 'virtcol',
\     },{
\       '__func__': 1,
\       '__text__': 'visualmode',
\       'abbr': 'visualmode([expr])',
\       'menu': '[function]',
\       'word': 'visualmode',
\     },{
\       '__func__': 1,
\       '__text__': 'wildmenumode',
\       'abbr': 'wildmenumode()',
\       'menu': '[function]',
\       'word': 'wildmenumode',
\     },{
\       '__func__': 1,
\       '__text__': 'win_findbuf',
\       'abbr': 'win_findbuf({bufnr})',
\       'menu': '[function]',
\       'word': 'win_findbuf',
\     },{
\       '__func__': 1,
\       '__text__': 'win_getid',
\       'abbr': 'win_getid([{win} [, {tab}]])',
\       'menu': '[function]',
\       'word': 'win_getid',
\     },{
\       '__func__': 1,
\       '__text__': 'win_gotoid',
\       'abbr': 'win_gotoid({expr})',
\       'menu': '[function]',
\       'word': 'win_gotoid',
\     },{
\       '__func__': 1,
\       '__text__': 'win_id2tabwin',
\       'abbr': 'win_id2tabwin({expr})',
\       'menu': '[function]',
\       'word': 'win_id2tabwin',
\     },{
\       '__func__': 1,
\       '__text__': 'win_id2win',
\       'abbr': 'win_id2win({expr})',
\       'menu': '[function]',
\       'word': 'win_id2win',
\     },{
\       '__func__': 1,
\       '__text__': 'win_screenpos',
\       'abbr': 'win_screenpos({nr})',
\       'menu': '[function]',
\       'word': 'win_screenpos',
\     },{
\       '__func__': 1,
\       '__text__': 'winbufnr',
\       'abbr': 'winbufnr({nr})',
\       'menu': '[function]',
\       'word': 'winbufnr',
\     },{
\       '__func__': 1,
\       '__text__': 'wincol',
\       'abbr': 'wincol()',
\       'menu': '[function]',
\       'word': 'wincol',
\     },{
\       '__func__': 1,
\       '__text__': 'winheight',
\       'abbr': 'winheight({nr})',
\       'menu': '[function]',
\       'word': 'winheight',
\     },{
\       '__func__': 1,
\       '__text__': 'winline',
\       'abbr': 'winline()',
\       'menu': '[function]',
\       'word': 'winline',
\     },{
\       '__func__': 1,
\       '__text__': 'winnr',
\       'abbr': 'winnr([{expr}])',
\       'menu': '[function]',
\       'word': 'winnr',
\     },{
\       '__func__': 1,
\       '__text__': 'winrestcmd',
\       'abbr': 'winrestcmd()',
\       'menu': '[function]',
\       'word': 'winrestcmd',
\     },{
\       '__func__': 1,
\       '__text__': 'winrestview',
\       'abbr': 'winrestview({dict})',
\       'menu': '[function]',
\       'word': 'winrestview',
\     },{
\       '__func__': 1,
\       '__text__': 'winsaveview',
\       'abbr': 'winsaveview()',
\       'menu': '[function]',
\       'word': 'winsaveview',
\     },{
\       '__func__': 1,
\       '__text__': 'winwidth',
\       'abbr': 'winwidth({nr})',
\       'menu': '[function]',
\       'word': 'winwidth',
\     },{
\       '__func__': 1,
\       '__text__': 'wordcount',
\       'abbr': 'wordcount()',
\       'menu': '[function]',
\       'word': 'wordcount',
\     },{
\       '__func__': 1,
\       '__text__': 'writefile',
\       'abbr': 'writefile({list}, {fname} [, {flags}])',
\       'menu': '[function]',
\       'word': 'writefile',
\     },{
\       '__func__': 1,
\       '__text__': 'xor',
\       'abbr': 'xor({expr}, {expr})',
\       'menu': '[function]',
\       'word': 'xor',
\     },],
\ }
lockvar! s:function
let s:commandattr = {
\   'conditionlist': [{
\       'cursor_at': '\m\C^\s*command!\?\s\+\%(\%(-nargs=[01*?+]\|-complete=\h\w*\%(,\S\+\)\?\|-range\%(=[%[:digit:]]\)\?\|-count=\d\+\|-addr=\h\w*\|-bang\|-bar\|-register\|-buffer\)\s\+\)*\zs\%(-\w*\)\?\%#',
\       'priority': 256,
\     },],
\   'index': {
\     '-': [{
\         '__text__': '-bar',
\         'menu': '[commandattr]',
\         'word': '-bar',
\       },{
\         '__text__': '-addr',
\         'menu': '[commandattr]',
\         'word': '-addr',
\       },{
\         '__text__': '-bang',
\         'menu': '[commandattr]',
\         'word': '-bang',
\       },{
\         '__text__': '-nargs',
\         'menu': '[commandattr]',
\         'word': '-nargs',
\       },{
\         '__text__': '-range',
\         'menu': '[commandattr]',
\         'word': '-range',
\       },{
\         '__text__': '-count',
\         'menu': '[commandattr]',
\         'word': '-count',
\       },{
\         '__text__': '-buffer',
\         'menu': '[commandattr]',
\         'word': '-buffer',
\       },{
\         '__text__': '-complete',
\         'menu': '[commandattr]',
\         'word': '-complete',
\       },{
\         '__text__': '-register',
\         'menu': '[commandattr]',
\         'word': '-register',
\       },],
\   },
\   'indexlen': 1,
\   'name': 'commandattr',
\   'wordlist': ['-nargs','-complete','-range','-count','-addr','-bang','-bar','-register','-buffer',],
\ }
lockvar! s:commandattr
let s:option = {
\   'conditionlist': [{
\       'cursor_at': '\m\C&\%(l:\)\?\zs\a*\%#',
\       'priority': 256,
\     },{
\       'cursor_at': '\m\C^\s*set\%[local]\s\+\%(no\)\?\zs\a*\%#',
\       'priority': 256,
\     },{
\       'cursor_at': '\m\C\<exists([''"][&+]\zs\a*\%#',
\       'priority': 256,
\     },{
\       'cursor_at': '\m^\%(\%([^"]*"[^"]*"\)*[^"]*"[^"]*\|\%([^'']*''[^'']*''\)*[^'']*''[^'']*\)\zs\<\a\{6,}\%#',
\       'in_string': 1,
\       'priority': 0,
\     },{
\       'cursor_at': '\m^\%(\%([^"]*"[^"]*"\)*[^"]*"[^"]*\|\%([^'']*''[^'']*''\)*[^'']*''[^'']*\)\zs\<\a\{6,}\%#',
\       'in_comment': 1,
\       'priority': 0,
\     },],
\   'index': {
\     'a': [{
\         '__text__': 'all',
\         'menu': '[option]',
\         'word': 'all',
\       },{
\         '__text__': 'aleph',
\         'menu': '[option]',
\         'word': 'aleph',
\       },{
\         '__text__': 'arabic',
\         'menu': '[option]',
\         'word': 'arabic',
\       },{
\         '__text__': 'autoread',
\         'menu': '[option]',
\         'word': 'autoread',
\       },{
\         '__text__': 'altkeymap',
\         'menu': '[option]',
\         'word': 'altkeymap',
\       },{
\         '__text__': 'ambiwidth',
\         'menu': '[option]',
\         'word': 'ambiwidth',
\       },{
\         '__text__': 'autochdir',
\         'menu': '[option]',
\         'word': 'autochdir',
\       },{
\         '__text__': 'autowrite',
\         'menu': '[option]',
\         'word': 'autowrite',
\       },{
\         '__text__': 'autoindent',
\         'menu': '[option]',
\         'word': 'autoindent',
\       },{
\         '__text__': 'arabicshape',
\         'menu': '[option]',
\         'word': 'arabicshape',
\       },{
\         '__text__': 'allowrevins',
\         'menu': '[option]',
\         'word': 'allowrevins',
\       },{
\         '__text__': 'autowriteall',
\         'menu': '[option]',
\         'word': 'autowriteall',
\       },],
\     'b': [{
\         '__text__': 'bomb',
\         'menu': '[option]',
\         'word': 'bomb',
\       },{
\         '__text__': 'backup',
\         'menu': '[option]',
\         'word': 'backup',
\       },{
\         '__text__': 'binary',
\         'menu': '[option]',
\         'word': 'binary',
\       },{
\         '__text__': 'belloff',
\         'menu': '[option]',
\         'word': 'belloff',
\       },{
\         '__text__': 'breakat',
\         'menu': '[option]',
\         'word': 'breakat',
\       },{
\         '__text__': 'buftype',
\         'menu': '[option]',
\         'word': 'buftype',
\       },{
\         '__text__': 'backspace',
\         'menu': '[option]',
\         'word': 'backspace',
\       },{
\         '__text__': 'backupdir',
\         'menu': '[option]',
\         'word': 'backupdir',
\       },{
\         '__text__': 'backupext',
\         'menu': '[option]',
\         'word': 'backupext',
\       },{
\         '__text__': 'browsedir',
\         'menu': '[option]',
\         'word': 'browsedir',
\       },{
\         '__text__': 'bufhidden',
\         'menu': '[option]',
\         'word': 'bufhidden',
\       },{
\         '__text__': 'buflisted',
\         'menu': '[option]',
\         'word': 'buflisted',
\       },{
\         '__text__': 'background',
\         'menu': '[option]',
\         'word': 'background',
\       },{
\         '__text__': 'backupcopy',
\         'menu': '[option]',
\         'word': 'backupcopy',
\       },{
\         '__text__': 'backupskip',
\         'menu': '[option]',
\         'word': 'backupskip',
\       },{
\         '__text__': 'ballooneval',
\         'menu': '[option]',
\         'word': 'ballooneval',
\       },{
\         '__text__': 'balloonexpr',
\         'menu': '[option]',
\         'word': 'balloonexpr',
\       },{
\         '__text__': 'breakindent',
\         'menu': '[option]',
\         'word': 'breakindent',
\       },{
\         '__text__': 'balloondelay',
\         'menu': '[option]',
\         'word': 'balloondelay',
\       },{
\         '__text__': 'breakindentopt',
\         'menu': '[option]',
\         'word': 'breakindentopt',
\       },],
\     'c': [{
\         '__text__': 'cedit',
\         'menu': '[option]',
\         'word': 'cedit',
\       },{
\         '__text__': 'cdpath',
\         'menu': '[option]',
\         'word': 'cdpath',
\       },{
\         '__text__': 'casemap',
\         'menu': '[option]',
\         'word': 'casemap',
\       },{
\         '__text__': 'cindent',
\         'menu': '[option]',
\         'word': 'cindent',
\       },{
\         '__text__': 'cinkeys',
\         'menu': '[option]',
\         'word': 'cinkeys',
\       },{
\         '__text__': 'columns',
\         'menu': '[option]',
\         'word': 'columns',
\       },{
\         '__text__': 'confirm',
\         'menu': '[option]',
\         'word': 'confirm',
\       },{
\         '__text__': 'cinwords',
\         'menu': '[option]',
\         'word': 'cinwords',
\       },{
\         '__text__': 'comments',
\         'menu': '[option]',
\         'word': 'comments',
\       },{
\         '__text__': 'complete',
\         'menu': '[option]',
\         'word': 'complete',
\       },{
\         '__text__': 'clipboard',
\         'menu': '[option]',
\         'word': 'clipboard',
\       },{
\         '__text__': 'cmdheight',
\         'menu': '[option]',
\         'word': 'cmdheight',
\       },{
\         '__text__': 'cpoptions',
\         'menu': '[option]',
\         'word': 'cpoptions',
\       },{
\         '__text__': 'cscopeprg',
\         'menu': '[option]',
\         'word': 'cscopeprg',
\       },{
\         '__text__': 'cscopetag',
\         'menu': '[option]',
\         'word': 'cscopetag',
\       },{
\         '__text__': 'cinoptions',
\         'menu': '[option]',
\         'word': 'cinoptions',
\       },{
\         '__text__': 'compatible',
\         'menu': '[option]',
\         'word': 'compatible',
\       },{
\         '__text__': 'copyindent',
\         'menu': '[option]',
\         'word': 'copyindent',
\       },{
\         '__text__': 'cursorbind',
\         'menu': '[option]',
\         'word': 'cursorbind',
\       },{
\         '__text__': 'cursorline',
\         'menu': '[option]',
\         'word': 'cursorline',
\       },{
\         '__text__': 'charconvert',
\         'menu': '[option]',
\         'word': 'charconvert',
\       },{
\         '__text__': 'colorcolumn',
\         'menu': '[option]',
\         'word': 'colorcolumn',
\       },{
\         '__text__': 'completeopt',
\         'menu': '[option]',
\         'word': 'completeopt',
\       },{
\         '__text__': 'cryptmethod',
\         'menu': '[option]',
\         'word': 'cryptmethod',
\       },{
\         '__text__': 'cmdwinheight',
\         'menu': '[option]',
\         'word': 'cmdwinheight',
\       },{
\         '__text__': 'conceallevel',
\         'menu': '[option]',
\         'word': 'conceallevel',
\       },{
\         '__text__': 'completefunc',
\         'menu': '[option]',
\         'word': 'completefunc',
\       },{
\         '__text__': 'cursorcolumn',
\         'menu': '[option]',
\         'word': 'cursorcolumn',
\       },{
\         '__text__': 'commentstring',
\         'menu': '[option]',
\         'word': 'commentstring',
\       },{
\         '__text__': 'concealcursor',
\         'menu': '[option]',
\         'word': 'concealcursor',
\       },{
\         '__text__': 'cscopeverbose',
\         'menu': '[option]',
\         'word': 'cscopeverbose',
\       },{
\         '__text__': 'cscopepathcomp',
\         'menu': '[option]',
\         'word': 'cscopepathcomp',
\       },{
\         '__text__': 'cscopequickfix',
\         'menu': '[option]',
\         'word': 'cscopequickfix',
\       },{
\         '__text__': 'cscoperelative',
\         'menu': '[option]',
\         'word': 'cscoperelative',
\       },{
\         '__text__': 'cscopetagorder',
\         'menu': '[option]',
\         'word': 'cscopetagorder',
\       },],
\     'd': [{
\         '__text__': 'diff',
\         'menu': '[option]',
\         'word': 'diff',
\       },{
\         '__text__': 'debug',
\         'menu': '[option]',
\         'word': 'debug',
\       },{
\         '__text__': 'define',
\         'menu': '[option]',
\         'word': 'define',
\       },{
\         '__text__': 'diffopt',
\         'menu': '[option]',
\         'word': 'diffopt',
\       },{
\         '__text__': 'digraph',
\         'menu': '[option]',
\         'word': 'digraph',
\       },{
\         '__text__': 'display',
\         'menu': '[option]',
\         'word': 'display',
\       },{
\         '__text__': 'diffexpr',
\         'menu': '[option]',
\         'word': 'diffexpr',
\       },{
\         '__text__': 'directory',
\         'menu': '[option]',
\         'word': 'directory',
\       },{
\         '__text__': 'delcombine',
\         'menu': '[option]',
\         'word': 'delcombine',
\       },{
\         '__text__': 'dictionary',
\         'menu': '[option]',
\         'word': 'dictionary',
\       },],
\     'e': [{
\         '__text__': 'exrc',
\         'menu': '[option]',
\         'word': 'exrc',
\       },{
\         '__text__': 'emoji',
\         'menu': '[option]',
\         'word': 'emoji',
\       },{
\         '__text__': 'esckeys',
\         'menu': '[option]',
\         'word': 'esckeys',
\       },{
\         '__text__': 'encoding',
\         'menu': '[option]',
\         'word': 'encoding',
\       },{
\         '__text__': 'equalprg',
\         'menu': '[option]',
\         'word': 'equalprg',
\       },{
\         '__text__': 'endofline',
\         'menu': '[option]',
\         'word': 'endofline',
\       },{
\         '__text__': 'errorfile',
\         'menu': '[option]',
\         'word': 'errorfile',
\       },{
\         '__text__': 'expandtab',
\         'menu': '[option]',
\         'word': 'expandtab',
\       },{
\         '__text__': 'errorbells',
\         'menu': '[option]',
\         'word': 'errorbells',
\       },{
\         '__text__': 'eadirection',
\         'menu': '[option]',
\         'word': 'eadirection',
\       },{
\         '__text__': 'equalalways',
\         'menu': '[option]',
\         'word': 'equalalways',
\       },{
\         '__text__': 'errorformat',
\         'menu': '[option]',
\         'word': 'errorformat',
\       },{
\         '__text__': 'eventignore',
\         'menu': '[option]',
\         'word': 'eventignore',
\       },{
\         '__text__': 'edcompatible',
\         'menu': '[option]',
\         'word': 'edcompatible',
\       },],
\     'f': [{
\         '__text__': 'fkmap',
\         'menu': '[option]',
\         'word': 'fkmap',
\       },{
\         '__text__': 'filetype',
\         'menu': '[option]',
\         'word': 'filetype',
\       },{
\         '__text__': 'foldexpr',
\         'menu': '[option]',
\         'word': 'foldexpr',
\       },{
\         '__text__': 'foldopen',
\         'menu': '[option]',
\         'word': 'foldopen',
\       },{
\         '__text__': 'foldtext',
\         'menu': '[option]',
\         'word': 'foldtext',
\       },{
\         '__text__': 'fillchars',
\         'menu': '[option]',
\         'word': 'fillchars',
\       },{
\         '__text__': 'foldclose',
\         'menu': '[option]',
\         'word': 'foldclose',
\       },{
\         '__text__': 'foldlevel',
\         'menu': '[option]',
\         'word': 'foldlevel',
\       },{
\         '__text__': 'formatprg',
\         'menu': '[option]',
\         'word': 'formatprg',
\       },{
\         '__text__': 'fileformat',
\         'menu': '[option]',
\         'word': 'fileformat',
\       },{
\         '__text__': 'foldcolumn',
\         'menu': '[option]',
\         'word': 'foldcolumn',
\       },{
\         '__text__': 'foldenable',
\         'menu': '[option]',
\         'word': 'foldenable',
\       },{
\         '__text__': 'foldignore',
\         'menu': '[option]',
\         'word': 'foldignore',
\       },{
\         '__text__': 'foldmarker',
\         'menu': '[option]',
\         'word': 'foldmarker',
\       },{
\         '__text__': 'foldmethod',
\         'menu': '[option]',
\         'word': 'foldmethod',
\       },{
\         '__text__': 'formatexpr',
\         'menu': '[option]',
\         'word': 'formatexpr',
\       },{
\         '__text__': 'fileformats',
\         'menu': '[option]',
\         'word': 'fileformats',
\       },{
\         '__text__': 'foldnestmax',
\         'menu': '[option]',
\         'word': 'foldnestmax',
\       },{
\         '__text__': 'fileencoding',
\         'menu': '[option]',
\         'word': 'fileencoding',
\       },{
\         '__text__': 'fixendofline',
\         'menu': '[option]',
\         'word': 'fixendofline',
\       },{
\         '__text__': 'foldminlines',
\         'menu': '[option]',
\         'word': 'foldminlines',
\       },{
\         '__text__': 'fileencodings',
\         'menu': '[option]',
\         'word': 'fileencodings',
\       },{
\         '__text__': 'formatoptions',
\         'menu': '[option]',
\         'word': 'formatoptions',
\       },{
\         '__text__': 'formatlistpat',
\         'menu': '[option]',
\         'word': 'formatlistpat',
\       },{
\         '__text__': 'fileignorecase',
\         'menu': '[option]',
\         'word': 'fileignorecase',
\       },{
\         '__text__': 'foldlevelstart',
\         'menu': '[option]',
\         'word': 'foldlevelstart',
\       },],
\     'g': [{
\         '__text__': 'guipty',
\         'menu': '[option]',
\         'word': 'guipty',
\       },{
\         '__text__': 'grepprg',
\         'menu': '[option]',
\         'word': 'grepprg',
\       },{
\         '__text__': 'guifont',
\         'menu': '[option]',
\         'word': 'guifont',
\       },{
\         '__text__': 'gdefault',
\         'menu': '[option]',
\         'word': 'gdefault',
\       },{
\         '__text__': 'guicursor',
\         'menu': '[option]',
\         'word': 'guicursor',
\       },{
\         '__text__': 'grepformat',
\         'menu': '[option]',
\         'word': 'grepformat',
\       },{
\         '__text__': 'guioptions',
\         'menu': '[option]',
\         'word': 'guioptions',
\       },{
\         '__text__': 'guifontwide',
\         'menu': '[option]',
\         'word': 'guifontwide',
\       },{
\         '__text__': 'guitablabel',
\         'menu': '[option]',
\         'word': 'guitablabel',
\       },{
\         '__text__': 'guitabtooltip',
\         'menu': '[option]',
\         'word': 'guitabtooltip',
\       },],
\     'h': [{
\         '__text__': 'hkmap',
\         'menu': '[option]',
\         'word': 'hkmap',
\       },{
\         '__text__': 'hidden',
\         'menu': '[option]',
\         'word': 'hidden',
\       },{
\         '__text__': 'hkmapp',
\         'menu': '[option]',
\         'word': 'hkmapp',
\       },{
\         '__text__': 'history',
\         'menu': '[option]',
\         'word': 'history',
\       },{
\         '__text__': 'helpfile',
\         'menu': '[option]',
\         'word': 'helpfile',
\       },{
\         '__text__': 'helplang',
\         'menu': '[option]',
\         'word': 'helplang',
\       },{
\         '__text__': 'hlsearch',
\         'menu': '[option]',
\         'word': 'hlsearch',
\       },{
\         '__text__': 'highlight',
\         'menu': '[option]',
\         'word': 'highlight',
\       },{
\         '__text__': 'helpheight',
\         'menu': '[option]',
\         'word': 'helpheight',
\       },],
\     'i': [{
\         '__text__': 'icon',
\         'menu': '[option]',
\         'word': 'icon',
\       },{
\         '__text__': 'include',
\         'menu': '[option]',
\         'word': 'include',
\       },{
\         '__text__': 'isfname',
\         'menu': '[option]',
\         'word': 'isfname',
\       },{
\         '__text__': 'isident',
\         'menu': '[option]',
\         'word': 'isident',
\       },{
\         '__text__': 'isprint',
\         'menu': '[option]',
\         'word': 'isprint',
\       },{
\         '__text__': 'iminsert',
\         'menu': '[option]',
\         'word': 'iminsert',
\       },{
\         '__text__': 'imsearch',
\         'menu': '[option]',
\         'word': 'imsearch',
\       },{
\         '__text__': 'imcmdline',
\         'menu': '[option]',
\         'word': 'imcmdline',
\       },{
\         '__text__': 'imdisable',
\         'menu': '[option]',
\         'word': 'imdisable',
\       },{
\         '__text__': 'incsearch',
\         'menu': '[option]',
\         'word': 'incsearch',
\       },{
\         '__text__': 'infercase',
\         'menu': '[option]',
\         'word': 'infercase',
\       },{
\         '__text__': 'iskeyword',
\         'menu': '[option]',
\         'word': 'iskeyword',
\       },{
\         '__text__': 'iconstring',
\         'menu': '[option]',
\         'word': 'iconstring',
\       },{
\         '__text__': 'ignorecase',
\         'menu': '[option]',
\         'word': 'ignorecase',
\       },{
\         '__text__': 'indentexpr',
\         'menu': '[option]',
\         'word': 'indentexpr',
\       },{
\         '__text__': 'indentkeys',
\         'menu': '[option]',
\         'word': 'indentkeys',
\       },{
\         '__text__': 'insertmode',
\         'menu': '[option]',
\         'word': 'insertmode',
\       },{
\         '__text__': 'includeexpr',
\         'menu': '[option]',
\         'word': 'includeexpr',
\       },{
\         '__text__': 'imstatusfunc',
\         'menu': '[option]',
\         'word': 'imstatusfunc',
\       },{
\         '__text__': 'imactivatefunc',
\         'menu': '[option]',
\         'word': 'imactivatefunc',
\       },],
\     'j': [{
\         '__text__': 'joinspaces',
\         'menu': '[option]',
\         'word': 'joinspaces',
\       },],
\     'k': [{
\         '__text__': 'key',
\         'menu': '[option]',
\         'word': 'key',
\       },{
\         '__text__': 'keymap',
\         'menu': '[option]',
\         'word': 'keymap',
\       },{
\         '__text__': 'keymodel',
\         'menu': '[option]',
\         'word': 'keymodel',
\       },{
\         '__text__': 'keywordprg',
\         'menu': '[option]',
\         'word': 'keywordprg',
\       },],
\     'l': [{
\         '__text__': 'lisp',
\         'menu': '[option]',
\         'word': 'lisp',
\       },{
\         '__text__': 'list',
\         'menu': '[option]',
\         'word': 'list',
\       },{
\         '__text__': 'lines',
\         'menu': '[option]',
\         'word': 'lines',
\       },{
\         '__text__': 'luadll',
\         'menu': '[option]',
\         'word': 'luadll',
\       },{
\         '__text__': 'langmap',
\         'menu': '[option]',
\         'word': 'langmap',
\       },{
\         '__text__': 'langmenu',
\         'menu': '[option]',
\         'word': 'langmenu',
\       },{
\         '__text__': 'langremap',
\         'menu': '[option]',
\         'word': 'langremap',
\       },{
\         '__text__': 'linebreak',
\         'menu': '[option]',
\         'word': 'linebreak',
\       },{
\         '__text__': 'linespace',
\         'menu': '[option]',
\         'word': 'linespace',
\       },{
\         '__text__': 'lispwords',
\         'menu': '[option]',
\         'word': 'lispwords',
\       },{
\         '__text__': 'listchars',
\         'menu': '[option]',
\         'word': 'listchars',
\       },{
\         '__text__': 'laststatus',
\         'menu': '[option]',
\         'word': 'laststatus',
\       },{
\         '__text__': 'lazyredraw',
\         'menu': '[option]',
\         'word': 'lazyredraw',
\       },{
\         '__text__': 'langnoremap',
\         'menu': '[option]',
\         'word': 'langnoremap',
\       },{
\         '__text__': 'loadplugins',
\         'menu': '[option]',
\         'word': 'loadplugins',
\       },],
\     'm': [{
\         '__text__': 'more',
\         'menu': '[option]',
\         'word': 'more',
\       },{
\         '__text__': 'magic',
\         'menu': '[option]',
\         'word': 'magic',
\       },{
\         '__text__': 'mouse',
\         'menu': '[option]',
\         'word': 'mouse',
\       },{
\         '__text__': 'makeef',
\         'menu': '[option]',
\         'word': 'makeef',
\       },{
\         '__text__': 'maxmem',
\         'menu': '[option]',
\         'word': 'maxmem',
\       },{
\         '__text__': 'makeprg',
\         'menu': '[option]',
\         'word': 'makeprg',
\       },{
\         '__text__': 'modeline',
\         'menu': '[option]',
\         'word': 'modeline',
\       },{
\         '__text__': 'modified',
\         'menu': '[option]',
\         'word': 'modified',
\       },{
\         '__text__': 'matchtime',
\         'menu': '[option]',
\         'word': 'matchtime',
\       },{
\         '__text__': 'maxmemtot',
\         'menu': '[option]',
\         'word': 'maxmemtot',
\       },{
\         '__text__': 'menuitems',
\         'menu': '[option]',
\         'word': 'menuitems',
\       },{
\         '__text__': 'modelines',
\         'menu': '[option]',
\         'word': 'modelines',
\       },{
\         '__text__': 'mousehide',
\         'menu': '[option]',
\         'word': 'mousehide',
\       },{
\         '__text__': 'mousetime',
\         'menu': '[option]',
\         'word': 'mousetime',
\       },{
\         '__text__': 'matchpairs',
\         'menu': '[option]',
\         'word': 'matchpairs',
\       },{
\         '__text__': 'maxcombine',
\         'menu': '[option]',
\         'word': 'maxcombine',
\       },{
\         '__text__': 'mkspellmem',
\         'menu': '[option]',
\         'word': 'mkspellmem',
\       },{
\         '__text__': 'modifiable',
\         'menu': '[option]',
\         'word': 'modifiable',
\       },{
\         '__text__': 'mousefocus',
\         'menu': '[option]',
\         'word': 'mousefocus',
\       },{
\         '__text__': 'mousemodel',
\         'menu': '[option]',
\         'word': 'mousemodel',
\       },{
\         '__text__': 'mouseshape',
\         'menu': '[option]',
\         'word': 'mouseshape',
\       },{
\         '__text__': 'maxmapdepth',
\         'menu': '[option]',
\         'word': 'maxmapdepth',
\       },{
\         '__text__': 'makeencoding',
\         'menu': '[option]',
\         'word': 'makeencoding',
\       },{
\         '__text__': 'maxfuncdepth',
\         'menu': '[option]',
\         'word': 'maxfuncdepth',
\       },{
\         '__text__': 'maxmempattern',
\         'menu': '[option]',
\         'word': 'maxmempattern',
\       },],
\     'n': [{
\         '__text__': 'number',
\         'menu': '[option]',
\         'word': 'number',
\       },{
\         '__text__': 'nrformats',
\         'menu': '[option]',
\         'word': 'nrformats',
\       },{
\         '__text__': 'numberwidth',
\         'menu': '[option]',
\         'word': 'numberwidth',
\       },],
\     'o': [{
\         '__text__': 'omnifunc',
\         'menu': '[option]',
\         'word': 'omnifunc',
\       },{
\         '__text__': 'opendevice',
\         'menu': '[option]',
\         'word': 'opendevice',
\       },{
\         '__text__': 'operatorfunc',
\         'menu': '[option]',
\         'word': 'operatorfunc',
\       },],
\     'p': [{
\         '__text__': 'path',
\         'menu': '[option]',
\         'word': 'path',
\       },{
\         '__text__': 'paste',
\         'menu': '[option]',
\         'word': 'paste',
\       },{
\         '__text__': 'prompt',
\         'menu': '[option]',
\         'word': 'prompt',
\       },{
\         '__text__': 'packpath',
\         'menu': '[option]',
\         'word': 'packpath',
\       },{
\         '__text__': 'pumwidth',
\         'menu': '[option]',
\         'word': 'pumwidth',
\       },{
\         '__text__': 'patchexpr',
\         'menu': '[option]',
\         'word': 'patchexpr',
\       },{
\         '__text__': 'patchmode',
\         'menu': '[option]',
\         'word': 'patchmode',
\       },{
\         '__text__': 'printfont',
\         'menu': '[option]',
\         'word': 'printfont',
\       },{
\         '__text__': 'pumheight',
\         'menu': '[option]',
\         'word': 'pumheight',
\       },{
\         '__text__': 'pythondll',
\         'menu': '[option]',
\         'word': 'pythondll',
\       },{
\         '__text__': 'paragraphs',
\         'menu': '[option]',
\         'word': 'paragraphs',
\       },{
\         '__text__': 'pythonhome',
\         'menu': '[option]',
\         'word': 'pythonhome',
\       },{
\         '__text__': 'pyxversion',
\         'menu': '[option]',
\         'word': 'pyxversion',
\       },{
\         '__text__': 'pastetoggle',
\         'menu': '[option]',
\         'word': 'pastetoggle',
\       },{
\         '__text__': 'printdevice',
\         'menu': '[option]',
\         'word': 'printdevice',
\       },{
\         '__text__': 'printheader',
\         'menu': '[option]',
\         'word': 'printheader',
\       },{
\         '__text__': 'printoptions',
\         'menu': '[option]',
\         'word': 'printoptions',
\       },{
\         '__text__': 'previewheight',
\         'menu': '[option]',
\         'word': 'previewheight',
\       },{
\         '__text__': 'previewwindow',
\         'menu': '[option]',
\         'word': 'previewwindow',
\       },{
\         '__text__': 'preserveindent',
\         'menu': '[option]',
\         'word': 'preserveindent',
\       },{
\         '__text__': 'pythonthreedll',
\         'menu': '[option]',
\         'word': 'pythonthreedll',
\       },{
\         '__text__': 'pythonthreehome',
\         'menu': '[option]',
\         'word': 'pythonthreehome',
\       },],
\     'q': [{
\         '__text__': 'quoteescape',
\         'menu': '[option]',
\         'word': 'quoteescape',
\       },],
\     'r': [{
\         '__text__': 'remap',
\         'menu': '[option]',
\         'word': 'remap',
\       },{
\         '__text__': 'ruler',
\         'menu': '[option]',
\         'word': 'ruler',
\       },{
\         '__text__': 'report',
\         'menu': '[option]',
\         'word': 'report',
\       },{
\         '__text__': 'revins',
\         'menu': '[option]',
\         'word': 'revins',
\       },{
\         '__text__': 'readonly',
\         'menu': '[option]',
\         'word': 'readonly',
\       },{
\         '__text__': 'rightleft',
\         'menu': '[option]',
\         'word': 'rightleft',
\       },{
\         '__text__': 'redrawtime',
\         'menu': '[option]',
\         'word': 'redrawtime',
\       },{
\         '__text__': 'rulerformat',
\         'menu': '[option]',
\         'word': 'rulerformat',
\       },{
\         '__text__': 'runtimepath',
\         'menu': '[option]',
\         'word': 'runtimepath',
\       },{
\         '__text__': 'regexpengine',
\         'menu': '[option]',
\         'word': 'regexpengine',
\       },{
\         '__text__': 'rightleftcmd',
\         'menu': '[option]',
\         'word': 'rightleftcmd',
\       },{
\         '__text__': 'renderoptions',
\         'menu': '[option]',
\         'word': 'renderoptions',
\       },{
\         '__text__': 'restorescreen',
\         'menu': '[option]',
\         'word': 'restorescreen',
\       },{
\         '__text__': 'relativenumber',
\         'menu': '[option]',
\         'word': 'relativenumber',
\       },],
\     's': [{
\         '__text__': 'shell',
\         'menu': '[option]',
\         'word': 'shell',
\       },{
\         '__text__': 'spell',
\         'menu': '[option]',
\         'word': 'spell',
\       },{
\         '__text__': 'scroll',
\         'menu': '[option]',
\         'word': 'scroll',
\       },{
\         '__text__': 'secure',
\         'menu': '[option]',
\         'word': 'secure',
\       },{
\         '__text__': 'syntax',
\         'menu': '[option]',
\         'word': 'syntax',
\       },{
\         '__text__': 'showcmd',
\         'menu': '[option]',
\         'word': 'showcmd',
\       },{
\         '__text__': 'sections',
\         'menu': '[option]',
\         'word': 'sections',
\       },{
\         '__text__': 'showmode',
\         'menu': '[option]',
\         'word': 'showmode',
\       },{
\         '__text__': 'smarttab',
\         'menu': '[option]',
\         'word': 'smarttab',
\       },{
\         '__text__': 'suffixes',
\         'menu': '[option]',
\         'word': 'suffixes',
\       },{
\         '__text__': 'swapfile',
\         'menu': '[option]',
\         'word': 'swapfile',
\       },{
\         '__text__': 'swapsync',
\         'menu': '[option]',
\         'word': 'swapsync',
\       },{
\         '__text__': 'scrolloff',
\         'menu': '[option]',
\         'word': 'scrolloff',
\       },{
\         '__text__': 'scrollopt',
\         'menu': '[option]',
\         'word': 'scrollopt',
\       },{
\         '__text__': 'selection',
\         'menu': '[option]',
\         'word': 'selection',
\       },{
\         '__text__': 'shellpipe',
\         'menu': '[option]',
\         'word': 'shellpipe',
\       },{
\         '__text__': 'shelltemp',
\         'menu': '[option]',
\         'word': 'shelltemp',
\       },{
\         '__text__': 'shortmess',
\         'menu': '[option]',
\         'word': 'shortmess',
\       },{
\         '__text__': 'shortname',
\         'menu': '[option]',
\         'word': 'shortname',
\       },{
\         '__text__': 'showbreak',
\         'menu': '[option]',
\         'word': 'showbreak',
\       },{
\         '__text__': 'showmatch',
\         'menu': '[option]',
\         'word': 'showmatch',
\       },{
\         '__text__': 'smartcase',
\         'menu': '[option]',
\         'word': 'smartcase',
\       },{
\         '__text__': 'spellfile',
\         'menu': '[option]',
\         'word': 'spellfile',
\       },{
\         '__text__': 'spelllang',
\         'menu': '[option]',
\         'word': 'spelllang',
\       },{
\         '__text__': 'switchbuf',
\         'menu': '[option]',
\         'word': 'switchbuf',
\       },{
\         '__text__': 'synmaxcol',
\         'menu': '[option]',
\         'word': 'synmaxcol',
\       },{
\         '__text__': 'scrollbind',
\         'menu': '[option]',
\         'word': 'scrollbind',
\       },{
\         '__text__': 'scrolljump',
\         'menu': '[option]',
\         'word': 'scrolljump',
\       },{
\         '__text__': 'selectmode',
\         'menu': '[option]',
\         'word': 'selectmode',
\       },{
\         '__text__': 'shellquote',
\         'menu': '[option]',
\         'word': 'shellquote',
\       },{
\         '__text__': 'shellredir',
\         'menu': '[option]',
\         'word': 'shellredir',
\       },{
\         '__text__': 'shellslash',
\         'menu': '[option]',
\         'word': 'shellslash',
\       },{
\         '__text__': 'shiftround',
\         'menu': '[option]',
\         'word': 'shiftround',
\       },{
\         '__text__': 'shiftwidth',
\         'menu': '[option]',
\         'word': 'shiftwidth',
\       },{
\         '__text__': 'sidescroll',
\         'menu': '[option]',
\         'word': 'sidescroll',
\       },{
\         '__text__': 'signcolumn',
\         'menu': '[option]',
\         'word': 'signcolumn',
\       },{
\         '__text__': 'splitbelow',
\         'menu': '[option]',
\         'word': 'splitbelow',
\       },{
\         '__text__': 'splitright',
\         'menu': '[option]',
\         'word': 'splitright',
\       },{
\         '__text__': 'statusline',
\         'menu': '[option]',
\         'word': 'statusline',
\       },{
\         '__text__': 'shellxquote',
\         'menu': '[option]',
\         'word': 'shellxquote',
\       },{
\         '__text__': 'showfulltag',
\         'menu': '[option]',
\         'word': 'showfulltag',
\       },{
\         '__text__': 'showtabline',
\         'menu': '[option]',
\         'word': 'showtabline',
\       },{
\         '__text__': 'smartindent',
\         'menu': '[option]',
\         'word': 'smartindent',
\       },{
\         '__text__': 'softtabstop',
\         'menu': '[option]',
\         'word': 'softtabstop',
\       },{
\         '__text__': 'startofline',
\         'menu': '[option]',
\         'word': 'startofline',
\       },{
\         '__text__': 'suffixesadd',
\         'menu': '[option]',
\         'word': 'suffixesadd',
\       },{
\         '__text__': 'shellcmdflag',
\         'menu': '[option]',
\         'word': 'shellcmdflag',
\       },{
\         '__text__': 'shellxescape',
\         'menu': '[option]',
\         'word': 'shellxescape',
\       },{
\         '__text__': 'spellsuggest',
\         'menu': '[option]',
\         'word': 'spellsuggest',
\       },{
\         '__text__': 'sidescrolloff',
\         'menu': '[option]',
\         'word': 'sidescrolloff',
\       },{
\         '__text__': 'spellcapcheck',
\         'menu': '[option]',
\         'word': 'spellcapcheck',
\       },{
\         '__text__': 'sessionoptions',
\         'menu': '[option]',
\         'word': 'sessionoptions',
\       },],
\     't': [{
\         '__text__': 'tags',
\         'menu': '[option]',
\         'word': 'tags',
\       },{
\         '__text__': 'term',
\         'menu': '[option]',
\         'word': 'term',
\       },{
\         '__text__': 'terse',
\         'menu': '[option]',
\         'word': 'terse',
\       },{
\         '__text__': 'title',
\         'menu': '[option]',
\         'word': 'title',
\       },{
\         '__text__': 'termcap',
\         'menu': '[option]',
\         'word': 'termcap',
\       },{
\         '__text__': 'tabline',
\         'menu': '[option]',
\         'word': 'tabline',
\       },{
\         '__text__': 'tabstop',
\         'menu': '[option]',
\         'word': 'tabstop',
\       },{
\         '__text__': 'tagcase',
\         'menu': '[option]',
\         'word': 'tagcase',
\       },{
\         '__text__': 'termkey',
\         'menu': '[option]',
\         'word': 'termkey',
\       },{
\         '__text__': 'tildeop',
\         'menu': '[option]',
\         'word': 'tildeop',
\       },{
\         '__text__': 'timeout',
\         'menu': '[option]',
\         'word': 'timeout',
\       },{
\         '__text__': 'ttyfast',
\         'menu': '[option]',
\         'word': 'ttyfast',
\       },{
\         '__text__': 'ttytype',
\         'menu': '[option]',
\         'word': 'ttytype',
\       },{
\         '__text__': 'tagstack',
\         'menu': '[option]',
\         'word': 'tagstack',
\       },{
\         '__text__': 'termbidi',
\         'menu': '[option]',
\         'word': 'termbidi',
\       },{
\         '__text__': 'termsize',
\         'menu': '[option]',
\         'word': 'termsize',
\       },{
\         '__text__': 'textauto',
\         'menu': '[option]',
\         'word': 'textauto',
\       },{
\         '__text__': 'textmode',
\         'menu': '[option]',
\         'word': 'textmode',
\       },{
\         '__text__': 'titlelen',
\         'menu': '[option]',
\         'word': 'titlelen',
\       },{
\         '__text__': 'titleold',
\         'menu': '[option]',
\         'word': 'titleold',
\       },{
\         '__text__': 'ttimeout',
\         'menu': '[option]',
\         'word': 'ttimeout',
\       },{
\         '__text__': 'taglength',
\         'menu': '[option]',
\         'word': 'taglength',
\       },{
\         '__text__': 'textwidth',
\         'menu': '[option]',
\         'word': 'textwidth',
\       },{
\         '__text__': 'thesaurus',
\         'menu': '[option]',
\         'word': 'thesaurus',
\       },{
\         '__text__': 'ttyscroll',
\         'menu': '[option]',
\         'word': 'ttyscroll',
\       },{
\         '__text__': 'tabpagemax',
\         'menu': '[option]',
\         'word': 'tabpagemax',
\       },{
\         '__text__': 'tagbsearch',
\         'menu': '[option]',
\         'word': 'tagbsearch',
\       },{
\         '__text__': 'timeoutlen',
\         'menu': '[option]',
\         'word': 'timeoutlen',
\       },{
\         '__text__': 'ttybuiltin',
\         'menu': '[option]',
\         'word': 'ttybuiltin',
\       },{
\         '__text__': 'tagrelative',
\         'menu': '[option]',
\         'word': 'tagrelative',
\       },{
\         '__text__': 'titlestring',
\         'menu': '[option]',
\         'word': 'titlestring',
\       },{
\         '__text__': 'ttimeoutlen',
\         'menu': '[option]',
\         'word': 'ttimeoutlen',
\       },{
\         '__text__': 'termencoding',
\         'menu': '[option]',
\         'word': 'termencoding',
\       },],
\     'u': [{
\         '__text__': 'undodir',
\         'menu': '[option]',
\         'word': 'undodir',
\       },{
\         '__text__': 'undofile',
\         'menu': '[option]',
\         'word': 'undofile',
\       },{
\         '__text__': 'undolevels',
\         'menu': '[option]',
\         'word': 'undolevels',
\       },{
\         '__text__': 'undoreload',
\         'menu': '[option]',
\         'word': 'undoreload',
\       },{
\         '__text__': 'updatetime',
\         'menu': '[option]',
\         'word': 'updatetime',
\       },{
\         '__text__': 'updatecount',
\         'menu': '[option]',
\         'word': 'updatecount',
\       },],
\     'v': [{
\         '__text__': 'verbose',
\         'menu': '[option]',
\         'word': 'verbose',
\       },{
\         '__text__': 'viewdir',
\         'menu': '[option]',
\         'word': 'viewdir',
\       },{
\         '__text__': 'viminfo',
\         'menu': '[option]',
\         'word': 'viminfo',
\       },{
\         '__text__': 'visualbell',
\         'menu': '[option]',
\         'word': 'visualbell',
\       },{
\         '__text__': 'verbosefile',
\         'menu': '[option]',
\         'word': 'verbosefile',
\       },{
\         '__text__': 'viewoptions',
\         'menu': '[option]',
\         'word': 'viewoptions',
\       },{
\         '__text__': 'viminfofile',
\         'menu': '[option]',
\         'word': 'viminfofile',
\       },{
\         '__text__': 'virtualedit',
\         'menu': '[option]',
\         'word': 'virtualedit',
\       },],
\     'w': [{
\         '__text__': 'warn',
\         'menu': '[option]',
\         'word': 'warn',
\       },{
\         '__text__': 'wrap',
\         'menu': '[option]',
\         'word': 'wrap',
\       },{
\         '__text__': 'write',
\         'menu': '[option]',
\         'word': 'write',
\       },{
\         '__text__': 'window',
\         'menu': '[option]',
\         'word': 'window',
\       },{
\         '__text__': 'wildchar',
\         'menu': '[option]',
\         'word': 'wildchar',
\       },{
\         '__text__': 'wildmenu',
\         'menu': '[option]',
\         'word': 'wildmenu',
\       },{
\         '__text__': 'wildmode',
\         'menu': '[option]',
\         'word': 'wildmode',
\       },{
\         '__text__': 'winwidth',
\         'menu': '[option]',
\         'word': 'winwidth',
\       },{
\         '__text__': 'wrapscan',
\         'menu': '[option]',
\         'word': 'wrapscan',
\       },{
\         '__text__': 'writeany',
\         'menu': '[option]',
\         'word': 'writeany',
\       },{
\         '__text__': 'whichwrap',
\         'menu': '[option]',
\         'word': 'whichwrap',
\       },{
\         '__text__': 'wildcharm',
\         'menu': '[option]',
\         'word': 'wildcharm',
\       },{
\         '__text__': 'winheight',
\         'menu': '[option]',
\         'word': 'winheight',
\       },{
\         '__text__': 'winptydll',
\         'menu': '[option]',
\         'word': 'winptydll',
\       },{
\         '__text__': 'wildignore',
\         'menu': '[option]',
\         'word': 'wildignore',
\       },{
\         '__text__': 'winaltkeys',
\         'menu': '[option]',
\         'word': 'winaltkeys',
\       },{
\         '__text__': 'wrapmargin',
\         'menu': '[option]',
\         'word': 'wrapmargin',
\       },{
\         '__text__': 'writedelay',
\         'menu': '[option]',
\         'word': 'writedelay',
\       },{
\         '__text__': 'weirdinvert',
\         'menu': '[option]',
\         'word': 'weirdinvert',
\       },{
\         '__text__': 'wildoptions',
\         'menu': '[option]',
\         'word': 'wildoptions',
\       },{
\         '__text__': 'winfixwidth',
\         'menu': '[option]',
\         'word': 'winfixwidth',
\       },{
\         '__text__': 'winminwidth',
\         'menu': '[option]',
\         'word': 'winminwidth',
\       },{
\         '__text__': 'writebackup',
\         'menu': '[option]',
\         'word': 'writebackup',
\       },{
\         '__text__': 'winfixheight',
\         'menu': '[option]',
\         'word': 'winfixheight',
\       },{
\         '__text__': 'winminheight',
\         'menu': '[option]',
\         'word': 'winminheight',
\       },{
\         '__text__': 'wildignorecase',
\         'menu': '[option]',
\         'word': 'wildignorecase',
\       },],
\   },
\   'indexlen': 1,
\   'name': 'option',
\   'wordlist': ['all','termcap','aleph','arabic','arabicshape','allowrevins','altkeymap','ambiwidth','autochdir','autoindent','autoread','autowrite','autowriteall','background','backspace','backup','backupcopy','backupdir','backupext','backupskip','balloondelay','ballooneval','balloonexpr','belloff','binary','bomb','breakat','breakindent','breakindentopt','browsedir','bufhidden','buflisted','buftype','casemap','cdpath','cedit','charconvert','cindent','cinkeys','cinoptions','cinwords','clipboard','cmdheight','cmdwinheight','colorcolumn','columns','comments','commentstring','compatible','complete','concealcursor','conceallevel','completefunc','completeopt','confirm','copyindent','cpoptions','cryptmethod','cscopepathcomp','cscopeprg','cscopequickfix','cscoperelative','cscopetag','cscopetagorder','cscopeverbose','cursorbind','cursorcolumn','cursorline','debug','define','delcombine','dictionary','diff','diffexpr','diffopt','digraph','directory','display','eadirection','edcompatible','emoji','encoding','endofline','equalalways','equalprg','errorbells','errorfile','errorformat','esckeys','eventignore','expandtab','exrc','fileencoding','fileencodings','fileformat','fileformats','fileignorecase','filetype','fillchars','fixendofline','fkmap','foldclose','foldcolumn','foldenable','foldexpr','foldignore','foldlevel','foldlevelstart','foldmarker','foldmethod','foldminlines','foldnestmax','foldopen','foldtext','formatexpr','formatoptions','formatlistpat','formatprg','gdefault','grepformat','grepprg','guicursor','guifont','guifontwide','guioptions','guipty','guitablabel','guitabtooltip','helpfile','helpheight','helplang','hidden','highlight','history','hkmap','hkmapp','hlsearch','icon','iconstring','ignorecase','imactivatefunc','imcmdline','imdisable','iminsert','imsearch','imstatusfunc','include','includeexpr','incsearch','indentexpr','indentkeys','infercase','insertmode','isfname','isident','iskeyword','isprint','joinspaces','key','keymap','keymodel','keywordprg','langmap','langmenu','langnoremap','langremap','laststatus','lazyredraw','linebreak','lines','linespace','lisp','lispwords','list','listchars','loadplugins','luadll','magic','makeef','makeencoding','makeprg','matchpairs','matchtime','maxcombine','maxfuncdepth','maxmapdepth','maxmem','maxmempattern','maxmemtot','menuitems','mkspellmem','modeline','modelines','modifiable','modified','more','mouse','mousefocus','mousehide','mousemodel','mouseshape','mousetime','nrformats','number','numberwidth','omnifunc','opendevice','operatorfunc','packpath','paragraphs','paste','pastetoggle','patchexpr','patchmode','path','preserveindent','previewheight','previewwindow','printdevice','printfont','printheader','printoptions','prompt','pumheight','pumwidth','pythonthreedll','pythonthreehome','pythondll','pythonhome','pyxversion','quoteescape','readonly','redrawtime','regexpengine','relativenumber','remap','renderoptions','report','restorescreen','revins','rightleft','rightleftcmd','ruler','rulerformat','runtimepath','scroll','scrollbind','scrolljump','scrolloff','scrollopt','sections','secure','selection','selectmode','sessionoptions','shell','shellcmdflag','shellpipe','shellquote','shellredir','shellslash','shelltemp','shellxquote','shellxescape','shiftround','shiftwidth','shortmess','shortname','showbreak','showcmd','showfulltag','showmatch','showmode','showtabline','sidescroll','sidescrolloff','signcolumn','smartcase','smartindent','smarttab','softtabstop','spell','spellcapcheck','spellfile','spelllang','spellsuggest','splitbelow','splitright','startofline','statusline','suffixes','suffixesadd','swapfile','swapsync','switchbuf','synmaxcol','syntax','tabline','tabpagemax','tabstop','tagbsearch','tagcase','taglength','tagrelative','tags','tagstack','term','termbidi','termencoding','termkey','termsize','terse','textauto','textmode','textwidth','thesaurus','tildeop','timeout','timeoutlen','title','titlelen','titleold','titlestring','ttimeout','ttimeoutlen','ttybuiltin','ttyfast','ttyscroll','ttytype','undodir','undofile','undolevels','undoreload','updatecount','updatetime','verbose','verbosefile','viewdir','viewoptions','viminfo','viminfofile','virtualedit','visualbell','warn','weirdinvert','whichwrap','wildchar','wildcharm','wildignore','wildignorecase','wildmenu','wildmode','wildoptions','winaltkeys','window','winheight','winfixheight','winfixwidth','winminheight','winminwidth','winptydll','winwidth','wrap','wrapmargin','wrapscan','write','writeany','writebackup','writedelay',],
\ }
lockvar! s:option
let s:event = {
\   'conditionlist': [{
\       'cursor_at': '\m\C^\s*au\%[tocmd]\s\+\%(\S\+\s\+\)\?\%([A-Z]\a*,\)*\zs\%([A-Z]\a*\)\?\%#',
\       'priority': 256,
\     },{
\       'cursor_at': '\m\C\<exists([''"]##\?\zs\%([A-Z]\a*\)\?\%#',
\       'priority': 256,
\     },{
\       'cursor_at': '\m\C^\s*do\%[autocmd]\s\+\%(<nomodeline>\s\+\)\?\%(\S\+\s\+\)\?\zs\%([A-Z]\a*\)\?\%#',
\       'priority': 256,
\     },{
\       'cursor_at': '\m^\%(\%([^"]*"[^"]*"\)*[^"]*"[^"]*\|\%([^'']*''[^'']*''\)*[^'']*''[^'']*\)\zs\<\a\{6,}\%#',
\       'in_string': 1,
\       'priority': 0,
\     },{
\       'cursor_at': '\m^\%(\%([^"]*"[^"]*"\)*[^"]*"[^"]*\|\%([^'']*''[^'']*''\)*[^'']*''[^'']*\)\zs\<\a\{6,}\%#',
\       'in_comment': 1,
\       'priority': 0,
\     },],
\   'index': {
\     'B': [{
\         '__text__': 'BufAdd',
\         'menu': '[event]',
\         'word': 'BufAdd',
\       },{
\         '__text__': 'BufNew',
\         'menu': '[event]',
\         'word': 'BufNew',
\       },{
\         '__text__': 'BufRead',
\         'menu': '[event]',
\         'word': 'BufRead',
\       },{
\         '__text__': 'BufEnter',
\         'menu': '[event]',
\         'word': 'BufEnter',
\       },{
\         '__text__': 'BufLeave',
\         'menu': '[event]',
\         'word': 'BufLeave',
\       },{
\         '__text__': 'BufWrite',
\         'menu': '[event]',
\         'word': 'BufWrite',
\       },{
\         '__text__': 'BufCreate',
\         'menu': '[event]',
\         'word': 'BufCreate',
\       },{
\         '__text__': 'BufDelete',
\         'menu': '[event]',
\         'word': 'BufDelete',
\       },{
\         '__text__': 'BufHidden',
\         'menu': '[event]',
\         'word': 'BufHidden',
\       },{
\         '__text__': 'BufUnload',
\         'menu': '[event]',
\         'word': 'BufUnload',
\       },{
\         '__text__': 'BufFilePre',
\         'menu': '[event]',
\         'word': 'BufFilePre',
\       },{
\         '__text__': 'BufNewFile',
\         'menu': '[event]',
\         'word': 'BufNewFile',
\       },{
\         '__text__': 'BufReadCmd',
\         'menu': '[event]',
\         'word': 'BufReadCmd',
\       },{
\         '__text__': 'BufReadPre',
\         'menu': '[event]',
\         'word': 'BufReadPre',
\       },{
\         '__text__': 'BufWipeout',
\         'menu': '[event]',
\         'word': 'BufWipeout',
\       },{
\         '__text__': 'BufFilePost',
\         'menu': '[event]',
\         'word': 'BufFilePost',
\       },{
\         '__text__': 'BufReadPost',
\         'menu': '[event]',
\         'word': 'BufReadPost',
\       },{
\         '__text__': 'BufWinEnter',
\         'menu': '[event]',
\         'word': 'BufWinEnter',
\       },{
\         '__text__': 'BufWinLeave',
\         'menu': '[event]',
\         'word': 'BufWinLeave',
\       },{
\         '__text__': 'BufWriteCmd',
\         'menu': '[event]',
\         'word': 'BufWriteCmd',
\       },{
\         '__text__': 'BufWritePre',
\         'menu': '[event]',
\         'word': 'BufWritePre',
\       },{
\         '__text__': 'BufWritePost',
\         'menu': '[event]',
\         'word': 'BufWritePost',
\       },],
\     'C': [{
\         '__text__': 'CursorHold',
\         'menu': '[event]',
\         'word': 'CursorHold',
\       },{
\         '__text__': 'CmdwinEnter',
\         'menu': '[event]',
\         'word': 'CmdwinEnter',
\       },{
\         '__text__': 'CmdwinLeave',
\         'menu': '[event]',
\         'word': 'CmdwinLeave',
\       },{
\         '__text__': 'ColorScheme',
\         'menu': '[event]',
\         'word': 'ColorScheme',
\       },{
\         '__text__': 'CursorHoldI',
\         'menu': '[event]',
\         'word': 'CursorHoldI',
\       },{
\         '__text__': 'CursorMoved',
\         'menu': '[event]',
\         'word': 'CursorMoved',
\       },{
\         '__text__': 'CmdUndefined',
\         'menu': '[event]',
\         'word': 'CmdUndefined',
\       },{
\         '__text__': 'CmdlineEnter',
\         'menu': '[event]',
\         'word': 'CmdlineEnter',
\       },{
\         '__text__': 'CmdlineLeave',
\         'menu': '[event]',
\         'word': 'CmdlineLeave',
\       },{
\         '__text__': 'CompleteDone',
\         'menu': '[event]',
\         'word': 'CompleteDone',
\       },{
\         '__text__': 'CursorMovedI',
\         'menu': '[event]',
\         'word': 'CursorMovedI',
\       },{
\         '__text__': 'CmdlineChanged',
\         'menu': '[event]',
\         'word': 'CmdlineChanged',
\       },],
\     'D': [{
\         '__text__': 'DirChanged',
\         'menu': '[event]',
\         'word': 'DirChanged',
\       },],
\     'E': [{
\         '__text__': 'EncodingChanged',
\         'menu': '[event]',
\         'word': 'EncodingChanged',
\       },],
\     'F': [{
\         '__text__': 'FileType',
\         'menu': '[event]',
\         'word': 'FileType',
\       },{
\         '__text__': 'FocusLost',
\         'menu': '[event]',
\         'word': 'FocusLost',
\       },{
\         '__text__': 'FileReadCmd',
\         'menu': '[event]',
\         'word': 'FileReadCmd',
\       },{
\         '__text__': 'FileReadPre',
\         'menu': '[event]',
\         'word': 'FileReadPre',
\       },{
\         '__text__': 'FocusGained',
\         'menu': '[event]',
\         'word': 'FocusGained',
\       },{
\         '__text__': 'FileEncoding',
\         'menu': '[event]',
\         'word': 'FileEncoding',
\       },{
\         '__text__': 'FileReadPost',
\         'menu': '[event]',
\         'word': 'FileReadPost',
\       },{
\         '__text__': 'FileWriteCmd',
\         'menu': '[event]',
\         'word': 'FileWriteCmd',
\       },{
\         '__text__': 'FileWritePre',
\         'menu': '[event]',
\         'word': 'FileWritePre',
\       },{
\         '__text__': 'FileAppendCmd',
\         'menu': '[event]',
\         'word': 'FileAppendCmd',
\       },{
\         '__text__': 'FileAppendPre',
\         'menu': '[event]',
\         'word': 'FileAppendPre',
\       },{
\         '__text__': 'FileChangedRO',
\         'menu': '[event]',
\         'word': 'FileChangedRO',
\       },{
\         '__text__': 'FileWritePost',
\         'menu': '[event]',
\         'word': 'FileWritePost',
\       },{
\         '__text__': 'FilterReadPre',
\         'menu': '[event]',
\         'word': 'FilterReadPre',
\       },{
\         '__text__': 'FuncUndefined',
\         'menu': '[event]',
\         'word': 'FuncUndefined',
\       },{
\         '__text__': 'FileAppendPost',
\         'menu': '[event]',
\         'word': 'FileAppendPost',
\       },{
\         '__text__': 'FilterReadPost',
\         'menu': '[event]',
\         'word': 'FilterReadPost',
\       },{
\         '__text__': 'FilterWritePre',
\         'menu': '[event]',
\         'word': 'FilterWritePre',
\       },{
\         '__text__': 'FilterWritePost',
\         'menu': '[event]',
\         'word': 'FilterWritePost',
\       },{
\         '__text__': 'FileChangedShell',
\         'menu': '[event]',
\         'word': 'FileChangedShell',
\       },{
\         '__text__': 'FileChangedShellPost',
\         'menu': '[event]',
\         'word': 'FileChangedShellPost',
\       },],
\     'G': [{
\         '__text__': 'GUIEnter',
\         'menu': '[event]',
\         'word': 'GUIEnter',
\       },{
\         '__text__': 'GUIFailed',
\         'menu': '[event]',
\         'word': 'GUIFailed',
\       },],
\     'I': [{
\         '__text__': 'InsertEnter',
\         'menu': '[event]',
\         'word': 'InsertEnter',
\       },{
\         '__text__': 'InsertLeave',
\         'menu': '[event]',
\         'word': 'InsertLeave',
\       },{
\         '__text__': 'InsertChange',
\         'menu': '[event]',
\         'word': 'InsertChange',
\       },{
\         '__text__': 'InsertCharPre',
\         'menu': '[event]',
\         'word': 'InsertCharPre',
\       },],
\     'M': [{
\         '__text__': 'MenuPopup',
\         'menu': '[event]',
\         'word': 'MenuPopup',
\       },],
\     'O': [{
\         '__text__': 'OptionSet',
\         'menu': '[event]',
\         'word': 'OptionSet',
\       },],
\     'Q': [{
\         '__text__': 'QuitPre',
\         'menu': '[event]',
\         'word': 'QuitPre',
\       },{
\         '__text__': 'QuickFixCmdPre',
\         'menu': '[event]',
\         'word': 'QuickFixCmdPre',
\       },{
\         '__text__': 'QuickFixCmdPost',
\         'menu': '[event]',
\         'word': 'QuickFixCmdPost',
\       },],
\     'R': [{
\         '__text__': 'RemoteReply',
\         'menu': '[event]',
\         'word': 'RemoteReply',
\       },],
\     'S': [{
\         '__text__': 'Syntax',
\         'menu': '[event]',
\         'word': 'Syntax',
\       },{
\         '__text__': 'SourceCmd',
\         'menu': '[event]',
\         'word': 'SourceCmd',
\       },{
\         '__text__': 'SourcePre',
\         'menu': '[event]',
\         'word': 'SourcePre',
\       },{
\         '__text__': 'SwapExists',
\         'menu': '[event]',
\         'word': 'SwapExists',
\       },{
\         '__text__': 'ShellCmdPost',
\         'menu': '[event]',
\         'word': 'ShellCmdPost',
\       },{
\         '__text__': 'StdinReadPre',
\         'menu': '[event]',
\         'word': 'StdinReadPre',
\       },{
\         '__text__': 'StdinReadPost',
\         'menu': '[event]',
\         'word': 'StdinReadPost',
\       },{
\         '__text__': 'SessionLoadPost',
\         'menu': '[event]',
\         'word': 'SessionLoadPost',
\       },{
\         '__text__': 'ShellFilterPost',
\         'menu': '[event]',
\         'word': 'ShellFilterPost',
\       },{
\         '__text__': 'SpellFileMissing',
\         'menu': '[event]',
\         'word': 'SpellFileMissing',
\       },],
\     'T': [{
\         '__text__': 'TabNew',
\         'menu': '[event]',
\         'word': 'TabNew',
\       },{
\         '__text__': 'TabEnter',
\         'menu': '[event]',
\         'word': 'TabEnter',
\       },{
\         '__text__': 'TabLeave',
\         'menu': '[event]',
\         'word': 'TabLeave',
\       },{
\         '__text__': 'TabClosed',
\         'menu': '[event]',
\         'word': 'TabClosed',
\       },{
\         '__text__': 'TermChanged',
\         'menu': '[event]',
\         'word': 'TermChanged',
\       },{
\         '__text__': 'TextChanged',
\         'menu': '[event]',
\         'word': 'TextChanged',
\       },{
\         '__text__': 'TermResponse',
\         'menu': '[event]',
\         'word': 'TermResponse',
\       },{
\         '__text__': 'TextChangedI',
\         'menu': '[event]',
\         'word': 'TextChangedI',
\       },{
\         '__text__': 'TextChangedP',
\         'menu': '[event]',
\         'word': 'TextChangedP',
\       },{
\         '__text__': 'TextYankPost',
\         'menu': '[event]',
\         'word': 'TextYankPost',
\       },],
\     'U': [{
\         '__text__': 'User',
\         'menu': '[event]',
\         'word': 'User',
\       },],
\     'V': [{
\         '__text__': 'VimEnter',
\         'menu': '[event]',
\         'word': 'VimEnter',
\       },{
\         '__text__': 'VimLeave',
\         'menu': '[event]',
\         'word': 'VimLeave',
\       },{
\         '__text__': 'VimResized',
\         'menu': '[event]',
\         'word': 'VimResized',
\       },{
\         '__text__': 'VimLeavePre',
\         'menu': '[event]',
\         'word': 'VimLeavePre',
\       },],
\     'W': [{
\         '__text__': 'WinNew',
\         'menu': '[event]',
\         'word': 'WinNew',
\       },{
\         '__text__': 'WinEnter',
\         'menu': '[event]',
\         'word': 'WinEnter',
\       },{
\         '__text__': 'WinLeave',
\         'menu': '[event]',
\         'word': 'WinLeave',
\       },],
\   },
\   'indexlen': 1,
\   'name': 'event',
\   'wordlist': ['BufAdd','BufCreate','BufDelete','BufEnter','BufFilePost','BufFilePre','BufHidden','BufLeave','BufNew','BufNewFile','BufRead','BufReadCmd','BufReadPost','BufReadPre','BufUnload','BufWinEnter','BufWinLeave','BufWipeout','BufWrite','BufWriteCmd','BufWritePost','BufWritePre','CmdUndefined','CmdlineChanged','CmdlineEnter','CmdlineLeave','CmdwinEnter','CmdwinLeave','ColorScheme','CompleteDone','CursorHold','CursorHoldI','CursorMoved','CursorMovedI','DirChanged','EncodingChanged','FileAppendCmd','FileAppendPost','FileAppendPre','FileChangedRO','FileChangedShell','FileChangedShellPost','FileEncoding','FileReadCmd','FileReadPost','FileReadPre','FileType','FileWriteCmd','FileWritePost','FileWritePre','FilterReadPost','FilterReadPre','FilterWritePost','FilterWritePre','FocusGained','FocusLost','FuncUndefined','GUIEnter','GUIFailed','InsertChange','InsertCharPre','InsertEnter','InsertLeave','MenuPopup','OptionSet','QuickFixCmdPost','QuickFixCmdPre','QuitPre','RemoteReply','SessionLoadPost','ShellCmdPost','ShellFilterPost','SourceCmd','SourcePre','SpellFileMissing','StdinReadPost','StdinReadPre','SwapExists','Syntax','TabClosed','TabEnter','TabLeave','TabNew','TermChanged','TermResponse','TextChanged','TextChangedI','TextChangedP','TextYankPost','User','VimEnter','VimLeave','VimLeavePre','VimResized','WinEnter','WinLeave','WinNew',],
\ }
lockvar! s:event
let s:keys = {
\   'conditionlist': [{
\       'cursor_at': '\m\C^\s*\%([nvxsoilc]\?\%(m\%[ap]\|no\%[remap]\)\|map!\|no\%[remap]!\)\s\+\%(<\%(buffer\|nowait\|silent\|special\|script\|expr\|unique\)>\s*\)*\%(\S\+\s\+\)\?\zs<[[:alnum:]-]*\%#',
\       'priority': 128,
\     },{
\       'cursor_at': '\m\C\<normal!\?\s\+.*\zs<[[:alnum:]-]*\%#',
\       'priority': 128,
\     },{
\       'cursor_at': '\m\C\<feedkeys(\%(''\%([^'']*\%(''''\)*\)*[^'']*\|"\%([^"]*\%(\\"\)*\)[^"]*\)\zs<[[:alnum:]-]*\%#',
\       'in_string': 1,
\       'priority': 128,
\     },{
\       'cursor_at': '\m<[[:alnum:]-]\+\%#',
\       'priority': 128,
\     },],
\   'index': {
\     '<B': [{
\         '__text__': '<BS>',
\         'menu': '[keys]',
\         'word': '<BS>',
\       },{
\         '__text__': '<Bar>',
\         'menu': '[keys]',
\         'word': '<Bar>',
\       },{
\         '__text__': '<Bslash>',
\         'menu': '[keys]',
\         'word': '<Bslash>',
\       },],
\     '<C': [{
\         '__text__': '<CR>',
\         'menu': '[keys]',
\         'word': '<CR>',
\       },{
\         '__text__': '<CSI>',
\         'menu': '[keys]',
\         'word': '<CSI>',
\       },{
\         '__text__': '<C-Left>',
\         'menu': '[keys]',
\         'word': '<C-Left>',
\       },{
\         '__text__': '<C-Right>',
\         'menu': '[keys]',
\         'word': '<C-Right>',
\       },],
\     '<D': [{
\         '__text__': '<Del>',
\         'menu': '[keys]',
\         'word': '<Del>',
\       },{
\         '__text__': '<Down>',
\         'menu': '[keys]',
\         'word': '<Down>',
\       },],
\     '<E': [{
\         '__text__': '<Esc>',
\         'menu': '[keys]',
\         'word': '<Esc>',
\       },{
\         '__text__': '<End>',
\         'menu': '[keys]',
\         'word': '<End>',
\       },{
\         '__text__': '<EOL>',
\         'menu': '[keys]',
\         'word': '<EOL>',
\       },{
\         '__text__': '<Enter>',
\         'menu': '[keys]',
\         'word': '<Enter>',
\       },],
\     '<F': [{
\         '__text__': '<F1>',
\         'menu': '[keys]',
\         'word': '<F1>',
\       },{
\         '__text__': '<F2>',
\         'menu': '[keys]',
\         'word': '<F2>',
\       },{
\         '__text__': '<F3>',
\         'menu': '[keys]',
\         'word': '<F3>',
\       },{
\         '__text__': '<F4>',
\         'menu': '[keys]',
\         'word': '<F4>',
\       },{
\         '__text__': '<F5>',
\         'menu': '[keys]',
\         'word': '<F5>',
\       },{
\         '__text__': '<F6>',
\         'menu': '[keys]',
\         'word': '<F6>',
\       },{
\         '__text__': '<F7>',
\         'menu': '[keys]',
\         'word': '<F7>',
\       },{
\         '__text__': '<F8>',
\         'menu': '[keys]',
\         'word': '<F8>',
\       },{
\         '__text__': '<F9>',
\         'menu': '[keys]',
\         'word': '<F9>',
\       },{
\         '__text__': '<FF>',
\         'menu': '[keys]',
\         'word': '<FF>',
\       },{
\         '__text__': '<F10>',
\         'menu': '[keys]',
\         'word': '<F10>',
\       },{
\         '__text__': '<F11>',
\         'menu': '[keys]',
\         'word': '<F11>',
\       },{
\         '__text__': '<F12>',
\         'menu': '[keys]',
\         'word': '<F12>',
\       },],
\     '<H': [{
\         '__text__': '<Help>',
\         'menu': '[keys]',
\         'word': '<Help>',
\       },{
\         '__text__': '<Home>',
\         'menu': '[keys]',
\         'word': '<Home>',
\       },],
\     '<I': [{
\         '__text__': '<Insert>',
\         'menu': '[keys]',
\         'word': '<Insert>',
\       },],
\     '<L': [{
\         '__text__': '<Left>',
\         'menu': '[keys]',
\         'word': '<Left>',
\       },],
\     '<N': [{
\         '__text__': '<NL>',
\         'menu': '[keys]',
\         'word': '<NL>',
\       },{
\         '__text__': '<Nul>',
\         'menu': '[keys]',
\         'word': '<Nul>',
\       },{
\         '__text__': '<Nop>',
\         'menu': '[keys]',
\         'word': '<Nop>',
\       },],
\     '<P': [{
\         '__text__': '<Plug>',
\         'menu': '[keys]',
\         'word': '<Plug>',
\       },{
\         '__text__': '<PageUp>',
\         'menu': '[keys]',
\         'word': '<PageUp>',
\       },{
\         '__text__': '<PageDown>',
\         'menu': '[keys]',
\         'word': '<PageDown>',
\       },],
\     '<R': [{
\         '__text__': '<Right>',
\         'menu': '[keys]',
\         'word': '<Right>',
\       },{
\         '__text__': '<Return>',
\         'menu': '[keys]',
\         'word': '<Return>',
\       },],
\     '<S': [{
\         '__text__': '<SID>',
\         'menu': '[keys]',
\         'word': '<SID>',
\       },{
\         '__text__': '<S-Up>',
\         'menu': '[keys]',
\         'word': '<S-Up>',
\       },{
\         '__text__': '<S-F1>',
\         'menu': '[keys]',
\         'word': '<S-F1>',
\       },{
\         '__text__': '<S-F2>',
\         'menu': '[keys]',
\         'word': '<S-F2>',
\       },{
\         '__text__': '<S-F3>',
\         'menu': '[keys]',
\         'word': '<S-F3>',
\       },{
\         '__text__': '<S-F4>',
\         'menu': '[keys]',
\         'word': '<S-F4>',
\       },{
\         '__text__': '<S-F5>',
\         'menu': '[keys]',
\         'word': '<S-F5>',
\       },{
\         '__text__': '<S-F6>',
\         'menu': '[keys]',
\         'word': '<S-F6>',
\       },{
\         '__text__': '<S-F7>',
\         'menu': '[keys]',
\         'word': '<S-F7>',
\       },{
\         '__text__': '<S-F8>',
\         'menu': '[keys]',
\         'word': '<S-F8>',
\       },{
\         '__text__': '<S-F9>',
\         'menu': '[keys]',
\         'word': '<S-F9>',
\       },{
\         '__text__': '<Space>',
\         'menu': '[keys]',
\         'word': '<Space>',
\       },{
\         '__text__': '<S-F10>',
\         'menu': '[keys]',
\         'word': '<S-F10>',
\       },{
\         '__text__': '<S-F11>',
\         'menu': '[keys]',
\         'word': '<S-F11>',
\       },{
\         '__text__': '<S-F12>',
\         'menu': '[keys]',
\         'word': '<S-F12>',
\       },{
\         '__text__': '<S-Down>',
\         'menu': '[keys]',
\         'word': '<S-Down>',
\       },{
\         '__text__': '<S-Left>',
\         'menu': '[keys]',
\         'word': '<S-Left>',
\       },{
\         '__text__': '<S-Right>',
\         'menu': '[keys]',
\         'word': '<S-Right>',
\       },],
\     '<T': [{
\         '__text__': '<Tab>',
\         'menu': '[keys]',
\         'word': '<Tab>',
\       },],
\     '<U': [{
\         '__text__': '<Up>',
\         'menu': '[keys]',
\         'word': '<Up>',
\       },{
\         '__text__': '<Undo>',
\         'menu': '[keys]',
\         'word': '<Undo>',
\       },],
\     '<k': [{
\         '__text__': '<k0>',
\         'menu': '[keys]',
\         'word': '<k0>',
\       },{
\         '__text__': '<k1>',
\         'menu': '[keys]',
\         'word': '<k1>',
\       },{
\         '__text__': '<k2>',
\         'menu': '[keys]',
\         'word': '<k2>',
\       },{
\         '__text__': '<k3>',
\         'menu': '[keys]',
\         'word': '<k3>',
\       },{
\         '__text__': '<k4>',
\         'menu': '[keys]',
\         'word': '<k4>',
\       },{
\         '__text__': '<k5>',
\         'menu': '[keys]',
\         'word': '<k5>',
\       },{
\         '__text__': '<k6>',
\         'menu': '[keys]',
\         'word': '<k6>',
\       },{
\         '__text__': '<k7>',
\         'menu': '[keys]',
\         'word': '<k7>',
\       },{
\         '__text__': '<k8>',
\         'menu': '[keys]',
\         'word': '<k8>',
\       },{
\         '__text__': '<k9>',
\         'menu': '[keys]',
\         'word': '<k9>',
\       },{
\         '__text__': '<kEnd>',
\         'menu': '[keys]',
\         'word': '<kEnd>',
\       },{
\         '__text__': '<kHome>',
\         'menu': '[keys]',
\         'word': '<kHome>',
\       },{
\         '__text__': '<kPlus>',
\         'menu': '[keys]',
\         'word': '<kPlus>',
\       },{
\         '__text__': '<kMinus>',
\         'menu': '[keys]',
\         'word': '<kMinus>',
\       },{
\         '__text__': '<kEnter>',
\         'menu': '[keys]',
\         'word': '<kEnter>',
\       },{
\         '__text__': '<kPoint>',
\         'menu': '[keys]',
\         'word': '<kPoint>',
\       },{
\         '__text__': '<kPageUp>',
\         'menu': '[keys]',
\         'word': '<kPageUp>',
\       },{
\         '__text__': '<kDivide>',
\         'menu': '[keys]',
\         'word': '<kDivide>',
\       },{
\         '__text__': '<kPageDown>',
\         'menu': '[keys]',
\         'word': '<kPageDown>',
\       },{
\         '__text__': '<kMultiply>',
\         'menu': '[keys]',
\         'word': '<kMultiply>',
\       },],
\     '<l': [{
\         '__text__': '<lt>',
\         'menu': '[keys]',
\         'word': '<lt>',
\       },],
\     '<x': [{
\         '__text__': '<xCSI>',
\         'menu': '[keys]',
\         'word': '<xCSI>',
\       },],
\   },
\   'indexlen': 2,
\   'name': 'keys',
\   'wordlist': ['<BS>','<Tab>','<CR>','<Return>','<Enter>','<Esc>','<Space>','<lt>','<Bslash>','<Bar>','<Del>','<Up>','<Down>','<Left>','<Right>','<F1>','<F2>','<F3>','<F4>','<F5>','<F6>','<F7>','<F8>','<F9>','<F10>','<F11>','<F12>','<S-Up>','<S-Down>','<S-Left>','<S-Right>','<C-Left>','<C-Right>','<S-F1>','<S-F2>','<S-F3>','<S-F4>','<S-F5>','<S-F6>','<S-F7>','<S-F8>','<S-F9>','<S-F10>','<S-F11>','<S-F12>','<Help>','<Undo>','<Insert>','<Home>','<End>','<PageUp>','<PageDown>','<kHome>','<kEnd>','<kPageUp>','<kPageDown>','<kPlus>','<kMinus>','<kMultiply>','<kDivide>','<kEnter>','<kPoint>','<k0>','<k1>','<k2>','<k3>','<k4>','<k5>','<k6>','<k7>','<k8>','<k9>','<EOL>','<CSI>','<xCSI>','<NL>','<FF>','<Nul>','<Nop>','<Plug>','<SID>',],
\ }
lockvar! s:keys
let s:commandattraddr = {
\   'conditionlist': [{
\       'cursor_at': '\m\C^\s*command!\?\s\+\%(\%(-nargs=[01*?+]\|-complete=\h\w*\%(,\S\+\)\?\|-range\%(=[%[:digit:]]\)\?\|-count=\d\+\|-bang\|-bar\|-register\|-buffer\)\s\+\)*-addr\zs\%(=[a-z_]*\)\?\%#',
\       'priority': 256,
\     },],
\   'index': {
\     '=': [{
\         '__text__': '=tabs',
\         'menu': '[commandattr]',
\         'word': '=tabs',
\       },{
\         '__text__': '=lines',
\         'menu': '[commandattr]',
\         'word': '=lines',
\       },{
\         '__text__': '=buffers',
\         'menu': '[commandattr]',
\         'word': '=buffers',
\       },{
\         '__text__': '=windows',
\         'menu': '[commandattr]',
\         'word': '=windows',
\       },{
\         '__text__': '=arguments',
\         'menu': '[commandattr]',
\         'word': '=arguments',
\       },{
\         '__text__': '=loaded_buffers',
\         'menu': '[commandattr]',
\         'word': '=loaded_buffers',
\       },],
\   },
\   'indexlen': 1,
\   'name': 'commandattr',
\   'wordlist': ['=lines','=arguments','=buffers','=loaded_buffers','=windows','=tabs',],
\ }
lockvar! s:commandattraddr
let s:commandattrcomplete = {
\   'conditionlist': [{
\       'cursor_at': '\m\C^\s*command!\?\s\+\%(\%(-nargs=[01*?+]\|-range\%(=[%[:digit:]]\)\?\|-count=\d\+\|-addr=\h\w*\|-bang\|-bar\|-register\|-buffer\)\s\+\)*-complete\zs\%(=[a-z_]*\)\?\%#',
\       'priority': 256,
\     },],
\   'index': {
\     '=': [{
\         '__text__': '=dir',
\         'menu': '[commandattr]',
\         'word': '=dir',
\       },{
\         '__text__': '=tag',
\         'menu': '[commandattr]',
\         'word': '=tag',
\       },{
\         '__text__': '=var',
\         'menu': '[commandattr]',
\         'word': '=var',
\       },{
\         '__text__': '=file',
\         'menu': '[commandattr]',
\         'word': '=file',
\       },{
\         '__text__': '=help',
\         'menu': '[commandattr]',
\         'word': '=help',
\       },{
\         '__text__': '=menu',
\         'menu': '[commandattr]',
\         'word': '=menu',
\       },{
\         '__text__': '=sign',
\         'menu': '[commandattr]',
\         'word': '=sign',
\       },{
\         '__text__': '=user',
\         'menu': '[commandattr]',
\         'word': '=user',
\       },{
\         '__text__': '=color',
\         'menu': '[commandattr]',
\         'word': '=color',
\       },{
\         '__text__': '=event',
\         'menu': '[commandattr]',
\         'word': '=event',
\       },{
\         '__text__': '=buffer',
\         'menu': '[commandattr]',
\         'word': '=buffer',
\       },{
\         '__text__': '=behave',
\         'menu': '[commandattr]',
\         'word': '=behave',
\       },{
\         '__text__': '=cscope',
\         'menu': '[commandattr]',
\         'word': '=cscope',
\       },{
\         '__text__': '=locale',
\         'menu': '[commandattr]',
\         'word': '=locale',
\       },{
\         '__text__': '=option',
\         'menu': '[commandattr]',
\         'word': '=option',
\       },{
\         '__text__': '=syntax',
\         'menu': '[commandattr]',
\         'word': '=syntax',
\       },{
\         '__text__': '=augroup',
\         'menu': '[commandattr]',
\         'word': '=augroup',
\       },{
\         '__text__': '=command',
\         'menu': '[commandattr]',
\         'word': '=command',
\       },{
\         '__text__': '=history',
\         'menu': '[commandattr]',
\         'word': '=history',
\       },{
\         '__text__': '=mapping',
\         'menu': '[commandattr]',
\         'word': '=mapping',
\       },{
\         '__text__': '=packadd',
\         'menu': '[commandattr]',
\         'word': '=packadd',
\       },{
\         '__text__': '=syntime',
\         'menu': '[commandattr]',
\         'word': '=syntime',
\       },{
\         '__text__': '=custom,',
\         'menu': '[commandattr]',
\         'word': '=custom,',
\       },{
\         '__text__': '=compiler',
\         'menu': '[commandattr]',
\         'word': '=compiler',
\       },{
\         '__text__': '=filetype',
\         'menu': '[commandattr]',
\         'word': '=filetype',
\       },{
\         '__text__': '=function',
\         'menu': '[commandattr]',
\         'word': '=function',
\       },{
\         '__text__': '=messages',
\         'menu': '[commandattr]',
\         'word': '=messages',
\       },{
\         '__text__': '=shellcmd',
\         'menu': '[commandattr]',
\         'word': '=shellcmd',
\       },{
\         '__text__': '=highlight',
\         'menu': '[commandattr]',
\         'word': '=highlight',
\       },{
\         '__text__': '=expression',
\         'menu': '[commandattr]',
\         'word': '=expression',
\       },{
\         '__text__': '=environment',
\         'menu': '[commandattr]',
\         'word': '=environment',
\       },{
\         '__text__': '=customlist,',
\         'menu': '[commandattr]',
\         'word': '=customlist,',
\       },{
\         '__text__': '=file_in_path',
\         'menu': '[commandattr]',
\         'word': '=file_in_path',
\       },{
\         '__text__': '=tag_listfiles',
\         'menu': '[commandattr]',
\         'word': '=tag_listfiles',
\       },],
\   },
\   'indexlen': 1,
\   'name': 'commandattr',
\   'wordlist': ['=augroup','=buffer','=behave','=color','=command','=compiler','=cscope','=dir','=environment','=event','=expression','=file','=file_in_path','=filetype','=function','=help','=highlight','=history','=locale','=mapping','=menu','=messages','=option','=packadd','=shellcmd','=sign','=syntax','=syntime','=tag','=tag_listfiles','=user','=var','=custom,','=customlist,',],
\ }
lockvar! s:commandattrcomplete
