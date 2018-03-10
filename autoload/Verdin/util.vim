scriptencoding utf-8

let s:lib = Verdin#lib#distribute()
let s:const = Verdin#constants#distribute()

" utilities
function! Verdin#util#exportbasedict(path, ...) abort "{{{
  let need_rebuild = get(a:000, 0, 0)
  let filetype = get(a:000, 1, 'vim')
  if need_rebuild
    let basedict = Verdin#util#rebuildbasedict(filetype)
  else
    let basedict = b:Verdin.Completer.Dictionary
  endif
  let memberlist = filter(keys(basedict), 'v:val !~# ''^\%(buffer\|scope\)''')

  let lines = []
  let lines += ['scriptencoding utf-8']
  let lines += [printf('function! Verdin#basedict#%s#distribute() abort', filetype)]
  let lines += ['  let basedict = {}']
  for member in memberlist
    let lines += [printf('  let basedict.%s = s:%s', member, member)]
  endfor
  let lines += ['  return basedict']
  let lines += ['endfunction']

  for member in memberlist
    let valname = 's:' . member
    let lines += s:val2str(basedict[member], valname)
    let lines += ['lockvar! ' . valname]
  endfor
  call writefile(lines, expand(a:path))
endfunction "}}}
function! Verdin#util#export(val, path, ...) abort "{{{
  let lines = s:val2str(a:val, get(a:000, 0, 'val'))
  call writefile(lines, expand(a:path))
endfunction "}}}
function! s:val2str(item, ...) abort "{{{
  let lines = [printf('let %s = ', get(a:000, 0, 'val'))]
  let indentlevel = 0
  call s:export(a:item, lines, indentlevel)
  let lines[-1] = substitute(lines[-1], ',\s*$', '', '')
  return lines
endfunction "}}}
function! s:export(item, lines, indentlevel) abort "{{{
  if type(a:item) == v:t_number
    call s:export_num(a:item, a:lines, a:indentlevel)
  elseif type(a:item) == v:t_string
    call s:export_str(a:item, a:lines, a:indentlevel)
  elseif type(a:item) == v:t_list
    call s:export_list(a:item, a:lines, a:indentlevel)
  elseif type(a:item) == v:t_dict
    call s:export_dict(a:item, a:lines, a:indentlevel)
  elseif type(a:item) == v:t_float
    call s:export_float(a:item, a:lines, a:indentlevel)
  endif
endfunction "}}}
function! s:export_num(num, lines, indentlevel) abort "{{{
  let a:lines[-1] .= printf('%d,', a:num)
  return a:indentlevel
endfunction "}}}
function! s:export_str(str, lines, indentlevel) abort "{{{
  let a:lines[-1] .= printf('''%s'',', s:escapesinglequote(a:str))
  return a:indentlevel
endfunction "}}}
function! s:export_list(list, lines, indentlevel) abort "{{{
  let a:lines[-1] .= '['
  for item in a:list
    call s:export(item, a:lines, a:indentlevel+1)
  endfor
  let a:lines[-1] .= '],'
endfunction "}}}
function! s:export_dict(dict, lines, indentlevel) abort "{{{
  let a:lines[-1] .= '{'
  let keylist = sort(keys(a:dict))
  for key in keylist
    call add(a:lines, printf('\%s ''%s'': ', repeat('  ', a:indentlevel+1), s:escapesinglequote(key)))
    let value = a:dict[key]
    call s:export(value, a:lines, a:indentlevel+1)
  endfor
  call add(a:lines, printf('\%s },', repeat('  ', a:indentlevel)))
endfunction "}}}
function! s:export_float(float, lines, indentlevel) abort "{{{
  let a:lines[-1] .= printf('%f,', a:float)
endfunction "}}}
function! s:escapesinglequote(str) abort "{{{
  return substitute(a:str, "'", "''", 'g')
endfunction "}}}

function! Verdin#util#countoccurrence(...) abort "{{{
  let need_rebuild = get(a:000, 0, 0)
  if need_rebuild
    let basedict = Verdin#util#rebuildbasedict()
  else
    let basedict = b:Verdin.Completer.shelf
  endif
  let report = []
  for Dictionary in values(basedict)
    if !has_key(Dictionary, 'name') || Dictionary.name ==# 'symbol'
      continue
    endif
    if Dictionary.name ==# 'command'
      let report += map(copy(Dictionary.wordlist), '{"name": Dictionary.name, "word": s:lib.word(v:val), "pat": printf(''\m\C^\s*%s\>'', s:lib.word(v:val)), "n": 0}')
    elseif Dictionary.name ==# 'function'
      let report += map(copy(Dictionary.wordlist), '{"name": Dictionary.name, "word": s:lib.word(v:val), "pat": printf(''\m\C^\s*\S.*\<%s\>'', s:lib.word(v:val)), "n": 0}')
    else
      let report += map(copy(Dictionary.wordlist), '{"name": Dictionary.name, "word": s:lib.word(v:val), "pat": printf(''\m\C\<%s\>'', s:lib.word(v:val)), "n": 0}')
    endif
  endfor

  for bufnr in range(1, bufnr('$'))
    call s:scan(bufnr, report)
  endfor
  return report
endfunction "}}}
function! s:scan(bufnr, report) abort "{{{
  if !bufexists(a:bufnr)
    return
  endif
  execute 'noautocmd silent buffer ' . a:bufnr
  if &l:filetype !=# 'vim'
    return
  endif
  echomsg bufname(a:bufnr)

  for item in a:report
    let item.n += s:count(item.pat)
  endfor
endfunction "}}}
function! s:count(pat) abort "{{{
  normal! gg
  let n = 0
  let lnum = search(a:pat, 'W')
  while lnum != 0
    let syntax = synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
    if syntax !~# '\%(Constant\|Comment\)'
      let n += 1
    endif
    let lnum = search(a:pat, 'W')
  endwhile
  return n
endfunction "}}}
function! Verdin#util#wordlist(name, ...) abort "{{{
  if a:0 > 0
    let report = a:1
  else
    let report = Verdin#util#countoccurrence()
  endif
  let partiallist = filter(copy(report), 'v:val.name ==# a:name')
  call sort(partiallist, {a, b -> b.n - a.n})
  return map(partiallist, 'v:val.word')
endfunction "}}}

" base dictionaries
" Command dictionary{{{
let s:commandwordlist = filter(getcompletion('', 'command'), 'v:val =~# ''\m\C^\%([[:lower:]]\|Next\)''')
" let s:commandwordlist = Verdin#util#wordlist('command', g:report)
" let g:commandwordlist = s:commandwordlist
"}}}
" Function dictionary {{{
let s:funcwordlist = map(filter(getcompletion('', 'function'), 'v:val =~# ''\m\C^[[:lower:]]\w*\%[()]$'''), 'matchstr(v:val, ''\h\k*\ze(\?'')')
" let s:funcwordlist = Verdin#util#wordlist('function', g:report)
" let g:funcwordlist = s:funcwordlist
function! s:funcitems(funcwordlist) abort
  let evaltxtpath = s:lib.pathjoin([expand('$VIMRUNTIME'), 'doc', 'eval.txt'])
  let evallines = readfile(evaltxtpath)
  let [start, end] = [-1, -1]
  for i in range(len(evallines))
    if evallines[i] =~# '^\d\+\.\s*Builtin Functions\s\+\*functions\*'
      let start = i
      break
    endif
  endfor
  for i in range(start + 1, len(evallines) - 1)
    if evallines[i] =~# '^\s\+\*feature-list\*'
      let end = i
      break
    endif
  endfor
  let evaltxt = filter(map(evallines[start : end], 'matchstr(v:val, ''\m^\h\w*([^)]\{-})'')'), 'v:val !=# ""')
  let funcwordlist = copy(a:funcwordlist)
  call filter(a:funcwordlist, 0)
  for func in funcwordlist
    let pattern = printf('\m^%s(', func)
    let usage = filter(copy(evaltxt), 'v:val =~# pattern')
    if usage != []
      let completeitem = {
            \   'word': func, 'menu': '[function]', 'abbr': usage[0],
            \   '__text__': func, '__func__': 1,
            \ }
    else
      let completeitem = func
    endif
    call add(a:funcwordlist, completeitem)
  endfor
  return a:funcwordlist
endfunction
call s:funcitems(s:funcwordlist)
"}}}
" Option dictionary {{{
let s:optionwordlist = getcompletion('', 'option')
"}}}
" Event dictionary {{{
let s:eventwordlist = getcompletion('', 'event')
"}}}
" Highlight group dictionary {{{
let s:higroupwordlist = [
    \   'Boolean', 'Character', 'ColorColumn', 'Comment', 'Conceal',
    \   'Conditional', 'Constant', 'Cursor', 'CursorColumn', 'CursorIM',
    \   'CursorLine', 'CursorLineNr', 'Debug', 'Define', 'Delimiter', 'DiffAdd',
    \   'DiffChange', 'DiffDelete', 'DiffText', 'Directory', 'EndOfBuffer',
    \   'Error', 'ErrorMsg', 'Exception', 'Float', 'FoldColumn', 'Folded',
    \   'Function', 'Identifier', 'Ignore', 'IncSearch', 'Include', 'Keyword',
    \   'Label', 'LineNr', 'Macro', 'MatchParen', 'Menu', 'ModeMsg', 'MoreMsg',
    \   'NONE', 'NonText', 'Normal', 'Number', 'Operator', 'Pmenu', 'PmenuSbar',
    \   'PmenuSel', 'PmenuThumb', 'PreCondit', 'PreProc', 'Question', 'Repeat',
    \   'Scrollbar', 'Search', 'SignColumn', 'Special', 'SpecialChar',
    \   'SpecialComment', 'SpecialKey', 'SpellBad', 'SpellCap', 'SpellLocal',
    \   'SpellRare', 'Statement', 'StatusLine', 'StatusLineNC',
    \   'StatusLineTerm', 'StatusLineTermNC', 'StorageClass', 'String',
    \   'Structure', 'TabLine', 'TabLineFill', 'TabLineSel', 'Tag', 'Title',
    \   'Todo', 'Tooltip', 'Type', 'Typedef', 'Underlined', 'VertSplit',
    \   'Visual', 'VisualNOS', 'WarningMsg', 'WildMenu', 'lCursor',
    \ ]
"}}}
" Helper dictionary for :highlight command {{{
let s:hicmdoptwordlist = ['default', 'link', 'clear']
let s:hicmdkeywordlist = ['term=', 'cterm=', 'gui=', 'ctermfg=', 'ctermbg=', 'guifg=', 'guibg=', 'guisp=', 'font=', 'start=', 'stop=']
let s:hicmdattrwordlist = ['bold', 'underline', 'undercurl', 'reverse', 'inverse', 'italic', 'standout', 'NONE']
"}}}
" Special keys dictionary{{{
let s:specialkeywordlist = [
      \   '<BS>', '<Tab>', '<CR>', '<Return>', '<Enter>', '<Esc>', '<Space>',
      \   '<lt>', '<Bslash>', '<Bar>', '<Del>', '<Up>', '<Down>', '<Left>',
      \   '<Right>', '<F1>', '<F2>', '<F3>', '<F4>', '<F5>', '<F6>', '<F7>',
      \   '<F8>', '<F9>', '<F10>', '<F11>', '<F12>', '<S-Up>', '<S-Down>',
      \   '<S-Left>', '<S-Right>', '<C-Left>', '<C-Right>', '<S-F1>', '<S-F2>',
      \   '<S-F3>', '<S-F4>', '<S-F5>', '<S-F6>', '<S-F7>', '<S-F8>', '<S-F9>',
      \   '<S-F10>', '<S-F11>', '<S-F12>', '<Help>', '<Undo>', '<Insert>',
      \   '<Home>', '<End>', '<PageUp>', '<PageDown>', '<kHome>', '<kEnd>',
      \   '<kPageUp>', '<kPageDown>', '<kPlus>', '<kMinus>', '<kMultiply>',
      \   '<kDivide>', '<kEnter>', '<kPoint>', '<k0>', '<k1>', '<k2>', '<k3>',
      \   '<k4>', '<k5>', '<k6>', '<k7>', '<k8>', '<k9>', '<EOL>', '<CSI>',
      \   '<xCSI>', '<NL>', '<FF>', '<Nul>', '<Nop>', '<Plug>', '<SID>',
      \ ]
"}}}
" Map attribute dictionary {{{
let s:mapattrwordlist = [
      \   '<buffer>', '<nowait>', '<silent>', '<special>', '<script>', '<expr>',
      \   '<unique>',
      \ ]
"}}}
" Command attribute dictionary {{{
let s:commandattrwordlist = [
      \   '-nargs', '-complete', '-range', '-count', '-addr', '-bang',
      \   '-bar', '-register', '-buffer',
      \ ]
let s:commandattrnargswordlist = ['=0', '=1', '=*', '=?', '=+']
let s:commandattrcompletewordlist = [
      \   '=augroup', '=buffer', '=behave', '=color', '=command', '=compiler',
      \   '=cscope', '=dir', '=environment', '=event', '=expression', '=file',
      \   '=file_in_path', '=filetype', '=function', '=help', '=highlight',
      \   '=history', '=locale', '=mapping', '=menu', '=messages', '=option',
      \   '=packadd', '=shellcmd', '=sign', '=syntax', '=syntime', '=tag',
      \   '=tag_listfiles', '=user', '=var', '=custom,', '=customlist,',
      \ ]
let s:commandattraddrwordlist = [
      \   '=lines', '=arguments', '=buffers', '=loaded_buffers', '=windows', '=tabs',
      \ ]
"}}}
" Expandables dictionary {{{
let s:expandablewordlist = [
      \   '%', '#', '<cfile>', '<afile>', '<abuf>', '<sfile>', '<slnum>',
      \   '<cword>', '<cWORD>', '<client>',
      \ ]
let s:expandablemodifierwordlist = [':p', ':h', ':t', ':r', ':e']
"}}}
" Vimvar dictionary {{{
let s:vimvarwordlist = getcompletion('v:', 'var')
"}}}
" Helper dictionary for exists function {{{
let s:existshelperwordlist = [
    \   '&', '+', '$', '*', ':', '#', '##',
    \ ]
let s:existshelperwordlist = [
    \   {'word': '&', 'menu': '[exists] &existing-option', '__text__': '&'},
    \   {'word': '+', 'menu': '[exists] +available-option', '__text__': '+'},
    \   {'word': '$', 'menu': '[exists] $ENVNAME', '__text__': '$'},
    \   {'word': '*', 'menu': '[exists] *funcname', '__text__': '*'},
    \   {'word': ':', 'menu': '[exists] :cmdname', '__text__': ':'},
    \   {'word': '#', 'menu': '[exists] #Event/#Group', '__text__': '#'},
    \   {'word': '##', 'menu': '[exists] ##SupportedEvent', '__text__': '##'},
    \ ]
"}}}
" Feature dictionary{{{
function! s:featurelist() abort
  let evaltxtpath = s:lib.pathjoin([expand('$VIMRUNTIME'), 'doc', 'eval.txt'])
  let evallines = readfile(evaltxtpath)
  for i in range(len(evallines))
    if evallines[i] =~# '^use: `if exists(''+shellslash'')`'
      let start = i + 1
      break
    endif
  endfor
  for i in range(start + 1, len(evallines) - 1)
    if evallines[i] =~# '^\s\+\*string-match\*'
      let end = i
      break
    endif
  endfor
  return filter(map(evallines[start : end], 'matchstr(v:val, ''\m^\h\w*'')'), 'v:val !=# ""')
endfunction
let s:featurewordlist = s:featurelist()
"}}}
" Help tags dictionary {{{
function! s:helptagitems(helptaglist) abort
  let helptaglist = copy(a:helptaglist)
  call filter(a:helptaglist, 0)
  for [helptag, file, _] in helptaglist
    let menu = ' ' . file
    call add(a:helptaglist, {'word': helptag, 'menu': menu, 'abbr': helptag, '__text__': helptag})
    if helptag =~# '^''[^'']\+''$'
      let __text__ = printf('%s', matchstr(helptag, '^''\zs[^'']\+\ze''$'))
      call add(a:helptaglist, {'word': helptag, 'menu': menu, 'abbr': helptag, '__text__': __text__})
    elseif helptag =~# '^<\w\+>$'
      let __text__ = printf('%s', matchstr(helptag, '^<\zs\w\+\ze>$'))
      call add(a:helptaglist, {'word': helptag, 'menu': menu, 'abbr': helptag, '__text__': __text__})
    elseif helptag =~# '^\$\a\+$'
      let __text__ = printf('%s', matchstr(helptag, '^\$\zs\a\+$'))
      call add(a:helptaglist, {'word': helptag, 'menu': menu, 'abbr': helptag, '__text__': __text__})
    endif
  endfor
  return a:helptaglist
endfunction
let s:helptagspath = s:lib.pathjoin([expand('$VIMRUNTIME'), 'doc', 'tags'])
let s:helptagwordlist = s:helptagitems(map(readfile(s:helptagspath), 'split(v:val, ''\s\+'')'))
"}}}
function! Verdin#util#rebuildbasedict(...) abort "{{{
  let filetype = get(a:000, 0, 'vim')
  return s:rebuild{filetype}basedict()
endfunction "}}}
function! s:rebuildvimbasedict() abort "{{{
  let options = {'sortbylength': 1}
  let basedict = {}
  let basedict.command = Verdin#Dictionary#new('command', s:const.COMMANDCONDITIONLIST, s:commandwordlist, 2)
  let basedict.function = Verdin#Dictionary#new('function', s:const.FUNCCONDITIONLIST, s:funcwordlist, 2)
  let basedict.option = Verdin#Dictionary#new('option', s:const.OPTIONCONDITIONLIST, s:optionwordlist, 1, options)
  let basedict.event = Verdin#Dictionary#new('event', s:const.EVENTCONDITIONLIST, s:eventwordlist, 1, options)
  let basedict.higroup = Verdin#Dictionary#new('higroup', s:const.HIGROUPCONDITIONLIST, s:higroupwordlist, 2, options)
  let basedict.hicmdopt = Verdin#Dictionary#new('highlight', s:const.HICMDOPTCONDITIONLIST, s:hicmdoptwordlist, 1)
  let basedict.hicmdkey = Verdin#Dictionary#new('highlight', s:const.HICMDKEYCONDITIONLIST, s:hicmdkeywordlist, 1)
  let basedict.hicmdattr = Verdin#Dictionary#new('highlight', s:const.HICMDATTRCONDITIONLIST, s:hicmdattrwordlist, 1)
  let basedict.keys = Verdin#Dictionary#new('keys', s:const.SPECIALKEYCONDITIONLIST, s:specialkeywordlist, 2, options)
  let basedict.mapattr = Verdin#Dictionary#new('mapattr', s:const.MAPATTRCONDITIONLIST, s:mapattrwordlist, 1, options)
  let basedict.commandattr = Verdin#Dictionary#new('commandattr', s:const.COMMANDATTRCONDITIONLIST, s:commandattrwordlist, 1, options)
  let basedict.commandattrnargs = Verdin#Dictionary#new('commandattr', s:const.COMMANDATTRNARGSCONDITIONLIST, s:commandattrnargswordlist, 1, options)
  let basedict.commandattrcomplete = Verdin#Dictionary#new('commandattr', s:const.COMMANDATTRCOMPLETECONDITIONLIST, s:commandattrcompletewordlist, 1, options)
  let basedict.commandattraddr = Verdin#Dictionary#new('commandattr', s:const.COMMANDATTRADDRCONDITIONLIST, s:commandattraddrwordlist, 1, options)
  let basedict.expandable = Verdin#Dictionary#new('expand', s:const.EXPANDABLECONDITIONLIST, s:expandablewordlist, 1, options)
  let basedict.expandablemodifier = Verdin#Dictionary#new('expand', s:const.EXPANDABLEMODIFIERCONDITIONLIST, s:expandablemodifierwordlist, 1, options)
  let basedict.vimvar = Verdin#Dictionary#new('vimvar', s:const.VIMVARCONDITIONLIST, s:vimvarwordlist, 3, options)
  let basedict.exists = Verdin#Dictionary#new('exists', s:const.EXISTSHELPERCONDITIONLIST, s:existshelperwordlist, 0, options)
  let basedict.feature = Verdin#Dictionary#new('feature', s:const.FEATURECONDITIONLIST, s:featurewordlist, 1)
  return basedict
endfunction "}}}
function! s:rebuildhelpbasedict() abort "{{{
  let basedict = {}
  let basedict.tag = Verdin#Dictionary#new('tag', s:const.HELPTAGCONDITIONLIST, s:helptagwordlist, 2)
  return basedict
endfunction "}}}

" vim:set ts=2 sts=2 sw=2 tw=0:
" vim:set foldmethod=marker: commentstring="%s:
