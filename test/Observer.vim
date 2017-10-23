let s:suite = themis#suite('Observer: ')
let s:lib = Verdin#lib#distribute()

function! s:scopecorrectedvaritems(varlist) abort "{{{
  let varlist = copy(a:varlist)
  for var in varlist
    let word = s:lib.word(var)
    if word =~# '^[abglstw]:\h\w*$'
      let withoutscope = matchstr(word, '^[abglstw]:\zs\h\w*$')
      let completeitem = {'word': word, 'menu': '[var]', '__text__': withoutscope}
      call add(a:varlist, completeitem)
    endif
  endfor
  return a:varlist
endfunction "}}}
function! s:funcitem(name, body, ...) abort "{{{
  return extend({'word': a:name, 'abbr': a:body, '__text__': a:name, '__func__': 1}, get(a:000, 0, {'menu': '[function]'}))
endfunction "}}}

function! s:suite.inspect() dict abort "{{{
  " testset{{{
  let testset = [
        \   {
        \     'buffer': [
        \       'function! Test()',
        \       '  let l:foo = "foo"',
        \       '  let bar = "bar"',
        \       '  let g:baz = "baz"',
        \       '  let b:baz = "baz"',
        \       '  let t:baz = "baz"',
        \       '  let w:baz = "baz"',
        \       '  let s:baz = "baz"',
        \       'endfunction',
        \     ],
        \     'expect': {
        \       'buffervar': ['b:baz', 'bar', 'g:baz', 'l:foo',
        \                     's:baz', 't:baz', 'w:baz'],
        \       'bufferfunc': [s:funcitem('Test', 'Test()')],
        \     },
        \   },
        \
        \   {
        \     'buffer': [
        \       'function! Test(list, ...)',
        \       '  let [foo1, foo2] = getpos(".")[1:2]',
        \       '  for i in range(10)',
        \       '     echo i',
        \       '  endfor',
        \       '  for [bar, baz] in a:list',
        \       '     echo i',
        \       '  endfor',
        \       'endfunction',
        \     ],
        \     'expect': {
        \       'buffervar': ['bar', 'baz', 'foo1', 'foo2', 'i', 'a:list',
        \                     'a:000', 'a:0', 'a:1', 'a:2', 'a:3'],
        \       'bufferfunc': [s:funcitem('Test', 'Test(list, ...)')],
        \     },
        \   },
        \
        \   {
        \     'buffer': [
        \       'function! Test(foo)',
        \       '  let foo = a:foo.bar',
        \       'endfunction',
        \     ],
        \     'expect': {
        \       'buffervar': ['foo', 'a:foo'],
        \       'buffermember': ['bar'],
        \       'bufferfunc': [s:funcitem('Test', 'Test(foo)')],
        \     },
        \   },
        \
        \   {
        \     'buffer': [
        \       'let g:foo = {"baz": 1, "qux": 2}',
        \       'function! g:Test()',
        \       '  let bar = {}',
        \       '  let bar.bar = g:foo.baz',
        \       'endfunction',
        \     ],
        \     'startline': 2,
        \     'expect': {
        \       'buffervar': ['bar', 'g:foo'],
        \       'buffermember': ['bar', 'baz', 'qux'],
        \       'bufferfunc': [s:funcitem('g:Test', 'g:Test()')],
        \     },
        \   },
        \
        \   {
        \     'buffer': [
        \       'let s:foo = {"bar": 1}',
        \       'function! s:foo.method()',
        \       '  return 2',
        \       'endfunction',
        \     ],
        \     'startline': 2,
        \     'expect': {
        \       'buffervar': ['s:foo', 'self'],
        \       'buffermember': ['bar', s:funcitem('method', 'method()', {'menu': '[member]', 'dup': 1})],
        \     },
        \   },
        \
        \   {
        \     'buffer': [
        \       'noremap <Plug>(test) /test<CR>',
        \     ],
        \     'expect': {
        \       'bufferkeymap': ['<Plug>(test)'],
        \     },
        \   },
        \
        \   {
        \     'buffer': [
        \       'command! -nargs=0 -buffer TestCmd :call Testfunc()<CR>',
        \     ],
        \     'expect': {
        \       'buffercommand': ['TestCmd'],
        \     },
        \   },
        \
        \   {
        \     'buffer': [
        \       'highlight TestColor ctermfg=0 ctermbg=15 guifg=#00000 guibg=#ffffff',
        \     ],
        \     'expect': {
        \       'bufferhigroup': ['TestColor'],
        \     },
        \   },
        \
        \   {
        \     'buffer': [
        \       'let g:test_foo_bar = 1',
        \     ],
        \     'expect': {
        \       'buffervar': ['g:test_foo_bar'],
        \       'varfragment': ['g:test_'],
        \     },
        \   },
        \
        \   {
        \     'buffer': [
        \       'if has_key(foo, "bar")',
        \     ],
        \     'expect': {
        \       'buffermember': ['bar'],
        \     },
        \   },
        \ ]
  "}}}

  setlocal filetype=vim
  for test in testset
    let expect = test.expect
    let basemessage = printf("----- buffer start -----\n%s\n----- buffer end -----", join(test.buffer, "\n"))
    call append(0, test.buffer)
    let startline = get(test, 'startline', 1)
    execute printf('normal! %dG', startline)
    let Observer = Verdin#Observer#new('', 'vim', 1)
    call Observer.inspect()
    if has_key(expect, 'buffervar')
      let got = Observer.shelf.buffervar.wordlist
      let exp = s:scopecorrectedvaritems(expect.buffervar)
      let message = "Mismatches in 'buffervar' items.\n\n" . basemessage
      call g:assert.equals(sort(got), sort(exp), message)
    endif
    if has_key(expect, 'buffermember')
      let got = Observer.shelf.buffermember.wordlist
      let exp = expect.buffermember
      let message = "Mismatches in 'buffermember' items.\n\n" . basemessage
      call g:assert.equals(sort(got), sort(exp), message)
    endif
    if has_key(expect, 'bufferfunc')
      let got = Observer.shelf.bufferfunc.wordlist
      let exp = expect.bufferfunc
      let message = "Mismatches in 'bufferfunc' items.\n\n" . basemessage
      call g:assert.equals(sort(got), sort(exp), message)
    endif
    if has_key(expect, 'bufferkeymap')
      let got = Observer.shelf.bufferkeymap.wordlist
      let exp = expect.bufferkeymap
      let message = "Mismatches in 'bufferkeymap' items.\n\n" . basemessage
      call g:assert.equals(sort(got), sort(exp), message)
    endif
    if has_key(expect, 'buffercommand')
      let got = Observer.shelf.buffercommand.wordlist
      let exp = Verdin#Dictionary#new('command', [], expect.buffercommand, 2, {'delimitermatch': 1}).wordlist
      let message = "Mismatches in 'buffercommand' items.\n\n" . basemessage
      call g:assert.equals(sort(got), sort(exp), message)
    endif
    if has_key(expect, 'bufferhigroup')
      let got = Observer.shelf.bufferhigroup.wordlist
      let exp = Verdin#Dictionary#new('higroup', [], expect.bufferhigroup, 2, {'delimitermatch': 1}).wordlist
      let message = "Mismatches in 'bufferhigroup' items.\n\n" . basemessage
      call g:assert.equals(sort(got), sort(exp), message)
    endif
    if has_key(expect, 'varfragment')
      let got = Observer.shelf.varfragment.wordlist
      let exp = map(expect.varfragment, '{"word": v:val, "menu": "[fragment]", "__text__": v:val}')
      let message = "Mismatches in 'varfragment' items.\n\n" . basemessage
      call g:assert.equals(sort(got), sort(exp), message)
    endif
    %delete
  endfor
endfunction "}}}

" vim:set foldmethod=marker:
" vim:set commentstring="%s:
" vim:set ts=2 sts=2 sw=2:

