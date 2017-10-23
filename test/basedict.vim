let s:suite = themis#suite('basedict: ')
let s:lib = Verdin#lib#distribute()

" mapping for test {{{
function! TestMap() abort
  let s:startcol = -1
  let s:itemlist = []
  let Completer = Verdin#Completer#get()
  let s:startcol = Completer.startcol()
  if s:startcol >= 0
    let cursorcol = col('.')
    let base = cursorcol == 1 ? '' : getline('.')[s:startcol : cursorcol-2]
    let s:itemlist = copy(Completer.candidatelist)
    call sort(s:itemlist, {a, b -> b.priority - a.priority})
    call map(s:itemlist, 'v:val.name')
  endif
  return ''
endfunction
inoremap <Plug>(TestMap) <C-r>=TestMap()<CR>
"}}}

function! s:suite.before_each() abort "{{{
  %delete
  set virtualedit=onemore
  set filetype=
endfunction "}}}
function! s:suite.after() abort "{{{
  call s:suite.before_each()
  iunmap <Plug>(TestMap)
  set virtualedit&
endfunction "}}}

function! s:suite.basedict() dict abort "{{{
   " testset{{{
  let testset = [
        \   {
        \     'cursorline': '  le\%#',
        \     'expect': {
        \       'startcol': 2,
        \       'itemlist': ['command'],
        \     },
        \   },
        \
        \   {
        \     'cursorline': '  silent le\%#',
        \     'expect': {
        \       'startcol': 9,
        \       'itemlist': ['command'],
        \     },
        \   },
        \
        \   {
        \     'cursorline': '  autocmd CursorMoved * ech\%#',
        \     'expect': {
        \       'startcol': 24,
        \       'itemlist': ['command'],
        \     },
        \   },
        \
        \   {
        \     'cursorline': '  command -nargs=0 TestCmd ech\%#',
        \     'expect': {
        \       'startcol': 27,
        \       'itemlist': ['command'],
        \     },
        \   },
        \
        \   {
        \     'cursorline': '  if exists(":l\%#',
        \     'expect': {
        \       'startcol': 14,
        \       'itemlist': ['command'],
        \     },
        \   },
        \
        \   {
        \     'cursorline': '  noremap <Plug>(test) :ca\%#',
        \     'expect': {
        \       'startcol': 24,
        \       'itemlist': ['command'],
        \     },
        \   },
        \
        \   {
        \     'cursorline': 'let foo = "noautocm\%#"',
        \     'expect': {
        \       'startcol': 11,
        \       'match': 'command',
        \     },
        \   },
        \
        \   {
        \     'cursorline': 'call cur\%#',
        \     'expect': {
        \       'startcol': 5,
        \       'match': 'function',
        \     },
        \   },
        \
        \   {
        \     'cursorline': 'call cursor(get\%#',
        \     'expect': {
        \       'startcol': 12,
        \       'match': 'function',
        \     },
        \   },
        \
        \   {
        \     'cursorline': 'execute "normal! i\<C-r>=lin\%#"',
        \     'expect': {
        \       'startcol': 25,
        \       'match': 'function',
        \     },
        \   },
        \
        \   {
        \     'cursorline': 'call call("setr\%#")',
        \     'expect': {
        \       'startcol': 11,
        \       'itemlist': ['function'],
        \     },
        \   },
        \
        \   {
        \     'cursorline': 'if exists("*setr\%#")',
        \     'expect': {
        \       'startcol': 12,
        \       'itemlist': ['function'],
        \     },
        \   },
        \
        \   {
        \     'cursorline': 'inoremap <buffer><expr><silent> <Plug>(test) stri\%#',
        \     'expect': {
        \       'startcol': 45,
        \       'match': 'function',
        \     },
        \   },
        \
        \   {
        \     'cursorline': 'let win\%#',
        \     'expect': {
        \       'not_match': 'function',
        \     },
        \   },
        \
        \   {
        \     'cursorline': 'let foo = win\%#',
        \     'expect': {
        \       'startcol': 10,
        \       'match': 'function',
        \     },
        \   },
        \
        \   {
        \     'cursorline': 'if lin\%#',
        \     'expect': {
        \       'startcol': 3,
        \       'match': 'function',
        \     },
        \   },
        \
        \   {
        \     'cursorline': 'if foo.lin\%#',
        \     'expect': {
        \       'not_match': 'function',
        \     },
        \   },
        \
        \   {
        \     'cursorline': 'elseif lin\%#',
        \     'expect': {
        \       'startcol': 7,
        \       'match': 'function',
        \     },
        \   },
        \
        \   {
        \     'cursorline': 'for i in ran\%#',
        \     'expect': {
        \       'startcol': 9,
        \       'match': 'function',
        \     },
        \   },
        \
        \   {
        \     'cursorline': 'while le\%#',
        \     'expect': {
        \       'startcol': 6,
        \       'match': 'function',
        \     },
        \   },
        \
        \   {
        \     'cursorline': 'return stri\%#',
        \     'expect': {
        \       'startcol': 7,
        \       'match': 'function',
        \     },
        \   },
        \
        \   {
        \     'cursorline': 'execute prin\%#',
        \     'expect': {
        \       'startcol': 8,
        \       'match': 'function',
        \     },
        \   },
        \
        \   {
        \     'cursorline': 'echo prin\%#',
        \     'expect': {
        \       'startcol': 5,
        \       'match': 'function',
        \     },
        \   },
        \
        \   {
        \     'cursorline': 'echom prin\%#',
        \     'expect': {
        \       'startcol': 6,
        \       'match': 'function',
        \     },
        \   },
        \
        \   {
        \     'cursorline': 'echoerr prin\%#',
        \     'expect': {
        \       'startcol': 8,
        \       'match': 'function',
        \     },
        \   },
        \
        \   {
        \     'cursorline': 'PP! prin\%#',
        \     'expect': {
        \       'startcol': 4,
        \       'match': 'function',
        \     },
        \   },
        \
        \   {
        \     'cursorline': '" winrest\%#',
        \     'expect': {
        \       'startcol': 2,
        \       'match': 'function',
        \     },
        \   },
        \
        \   {
        \     'cursorline': 'echo &virtu\%#',
        \     'expect': {
        \       'startcol': 6,
        \       'itemlist': ['option'],
        \     },
        \   },
        \
        \   {
        \     'cursorline': 'let &l:inden\%#',
        \     'expect': {
        \       'startcol': 7,
        \       'itemlist': ['option'],
        \     },
        \   },
        \
        \   {
        \     'cursorline': 'set igno\%#',
        \     'expect': {
        \       'startcol': 4,
        \       'itemlist': ['option'],
        \     },
        \   },
        \
        \   {
        \     'cursorline': 'setl igno\%#',
        \     'expect': {
        \       'startcol': 5,
        \       'itemlist': ['option'],
        \     },
        \   },
        \
        \   {
        \     'cursorline': 'if exists(''&termg\%#',
        \     'expect': {
        \       'startcol': 12,
        \       'match': 'option',
        \     },
        \   },
        \
        \   {
        \     'cursorline': 'if exists(''+termg\%#',
        \     'expect': {
        \       'startcol': 12,
        \       'match': 'option',
        \     },
        \   },
        \
        \   {
        \     'cursorline': '''termgu\%#',
        \     'expect': {
        \       'startcol': 1,
        \       'match': 'option',
        \     },
        \   },
        \
        \   {
        \     'cursorline': 'autocmd Curs\%#',
        \     'expect': {
        \       'startcol': 8,
        \       'itemlist': ['event'],
        \     },
        \   },
        \
        \   {
        \     'cursorline': 'autocmd CursorMovedI,TextC\%#',
        \     'expect': {
        \       'startcol': 21,
        \       'itemlist': ['event'],
        \     },
        \   },
        \
        \   {
        \     'cursorline': 'if exists("#Focus\%#")',
        \     'expect': {
        \       'startcol': 12,
        \       'match': 'event',
        \     },
        \   },
        \
        \   {
        \     'cursorline': 'doautocmd FileT\%#',
        \     'expect': {
        \       'startcol': 10,
        \       'itemlist': ['event'],
        \     },
        \   },
        \
        \   {
        \     'cursorline': '" FileTy\%#',
        \     'expect': {
        \       'startcol': 2,
        \       'match': 'event',
        \     },
        \   },
        \
        \   {
        \     'cursorline': 'highlight \%#',
        \     'expect': {
        \       'startcol': 10,
        \       'itemlist': ['highlight', 'higroup'],
        \     },
        \   },
        \
        \   {
        \     'cursorline': 'highlight default \%#',
        \     'expect': {
        \       'startcol': 18,
        \       'itemlist': ['highlight', 'higroup'],
        \     },
        \   },
        \
        \   {
        \     'cursorline': 'highlight link Constant Stri\%#',
        \     'expect': {
        \       'startcol': 24,
        \       'itemlist': ['higroup'],
        \     },
        \   },
        \
        \   {
        \     'cursorline': 'call matchadd("Inc\%#")',
        \     'expect': {
        \       'startcol': 15,
        \       'match': 'higroup',
        \     },
        \   },
        \
        \   {
        \     'cursorline': 'call matchaddpos("Inc\%#")',
        \     'expect': {
        \       'startcol': 18,
        \       'match': 'higroup',
        \     },
        \   },
        \
        \   {
        \     'cursorline': '2match \%#',
        \     'expect': {
        \       'startcol': 7,
        \       'itemlist': ['higroup'],
        \     },
        \   },
        \
        \   {
        \     'cursorline': '" Cursor\%#',
        \     'expect': {
        \       'startcol': 2,
        \       'match': 'higroup',
        \     },
        \   },
        \
        \   {
        \     'cursorline': 'highlight default Incsearch term=\%#',
        \     'expect': {
        \       'startcol': 33,
        \       'itemlist': ['highlight'],
        \     },
        \   },
        \
        \   {
        \     'cursorline': 'highlight default Incsearch term=\%#',
        \     'expect': {
        \       'startcol': 33,
        \       'itemlist': ['highlight'],
        \     },
        \   },
        \
        \   {
        \     'cursorline': 'noremap <\%#',
        \     'expect': {
        \       'startcol': 8,
        \       'itemlist': ['mapattr', 'keys'],
        \     },
        \   },
        \
        \   {
        \     'cursorline': 'map <Space> <\%#',
        \     'expect': {
        \       'startcol': 12,
        \       'itemlist': ['keys'],
        \     },
        \   },
        \
        \   {
        \     'cursorline': 'normal! <\%#',
        \     'expect': {
        \       'startcol': 8,
        \       'itemlist': ['keys'],
        \     },
        \   },
        \
        \   {
        \     'cursorline': 'call feedkeys("\<\%#")',
        \     'expect': {
        \       'startcol': 16,
        \       'itemlist': ['keys'],
        \     },
        \   },
        \
        \   {
        \     'cursorline': '<P\%#',
        \     'expect': {
        \       'startcol': 0,
        \       'itemlist': ['mapattr', 'keys'],
        \     },
        \   },
        \
        \   {
        \     'cursorline': 'command! \%#',
        \     'expect': {
        \       'startcol': 9,
        \       'itemlist': ['commandattr'],
        \     },
        \   },
        \
        \   {
        \     'cursorline': 'command! -nargs=\%#',
        \     'expect': {
        \       'startcol': 15,
        \       'itemlist': ['commandattr'],
        \     },
        \   },
        \
        \   {
        \     'cursorline': 'command! -complete=\%#',
        \     'expect': {
        \       'startcol': 18,
        \       'itemlist': ['commandattr'],
        \     },
        \   },
        \
        \   {
        \     'cursorline': 'let cursorword = expand(''\%#'')',
        \     'expect': {
        \       'startcol': 25,
        \       'itemlist': ['expand'],
        \     },
        \   },
        \
        \   {
        \     'cursorline': 'let cursorword = expand(''%\%#'')',
        \     'expect': {
        \       'startcol': 25,
        \       'itemlist': ['expand'],
        \     },
        \   },
        \
        \   {
        \     'cursorline': 'let cursorword = expand(''%:\%#'')',
        \     'expect': {
        \       'startcol': 26,
        \       'itemlist': ['expand'],
        \     },
        \   },
        \
        \   {
        \     'cursorline': 'let cursorword = expand(''%:p:\%#'')',
        \     'expect': {
        \       'startcol': 28,
        \       'itemlist': ['expand'],
        \     },
        \   },
        \
        \   {
        \     'cursorline': 'let l:count = v:\%#',
        \     'expect': {
        \       'startcol': 14,
        \       'itemlist': ['vimvar'],
        \     },
        \   },
        \
        \   {
        \     'cursorline': 'if exists("\%#")',
        \     'expect': {
        \       'startcol': 11,
        \       'itemlist': ['exists'],
        \     },
        \   },
        \
        \   {
        \     'cursorline': 'if has("\%#")',
        \     'expect': {
        \       'startcol': 8,
        \       'itemlist': ['feature'],
        \     },
        \   },
        \ ]
  "}}}

  setlocal filetype=vim
  for test in testset
    let [precursor, postcursor] = split(test.cursorline, '\\%#', 1)
    let n = strchars(precursor)
    call setline(1, precursor . postcursor)
    execute printf("normal 1G0%dli\<Plug>(TestMap)", n)
    let expect = test.expect
    let basemessage = printf("cursorline:\n%s", test.cursorline)
    if has_key(expect, 'startcol')
      let message = basemessage
      let message .= "\nexpect base:\n" . precursor[expect.startcol :]
      let message .= "\nobtained base:\n" . precursor[s:startcol :]
      call g:assert.equals(s:startcol, expect.startcol, message)
    endif
    if has_key(expect, 'itemlist')
      let message = basemessage
      call g:assert.equals(s:itemlist, expect.itemlist, message)
    endif
    if has_key(expect, 'match')
      let message = basemessage
      let message .= printf("\n\n'%s' is expected to match here\n", expect.match)
      call g:assert.true(match(s:itemlist, printf('\m\C^%s$', s:lib.escape(expect.match))) > -1, message)
    endif
    if has_key(expect, 'not_match')
      let message = basemessage
      let message .= printf("\n\n'%s' is expected not to match here\n", expect.not_match)
      call g:assert.false(match(s:itemlist, printf('\m\C^%s$', s:lib.escape(expect.not_match))) > -1, message)
    endif
  endfor
endfunction "}}}

" vim:set foldmethod=marker:
" vim:set commentstring="%s:
" vim:set ts=2 sts=2 sw=2:
