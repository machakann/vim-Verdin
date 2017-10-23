let s:suite = themis#suite('Dictionary: ')

function! s:suite.index() dict abort "{{{
  " testset {{{
  let testset = [ 
        \   {
        \     'input': {
        \       'name': '',
        \       'wordlist': [],
        \       'indexlen': 1,
        \     },
        \     'expect': {},
        \   },
        \
        \   {
        \     'input': {
        \       'name': 'test',
        \       'wordlist': [],
        \       'indexlen': 1,
        \     },
        \     'expect': {},
        \   },
        \
        \   {
        \     'input': {
        \       'name': '',
        \       'wordlist': ['aaa'],
        \       'indexlen': 1,
        \     },
        \     'expect': {
        \       'a': [{'word': 'aaa', 'menu': '', '__text__': 'aaa'}],
        \     },
        \   },
        \
        \   {
        \     'input': {
        \       'name': 'test',
        \       'wordlist': ['aaa'],
        \       'indexlen': 1,
        \     },
        \     'expect': {
        \       'a': [{'word': 'aaa', 'menu': '[test]', '__text__': 'aaa'}],
        \     },
        \   },
        \
        \   {
        \     'input': {
        \       'name': 'test',
        \       'wordlist': ['aaa'],
        \       'indexlen': 2,
        \     },
        \     'expect': {
        \       'aa': [{'word': 'aaa', 'menu': '[test]', '__text__': 'aaa'}],
        \     },
        \   },
        \
        \   {
        \     'input': {
        \       'name': 'test',
        \       'wordlist': ['aaa', 'bbb'],
        \       'indexlen': 1,
        \     },
        \     'expect': {
        \       'a': [{'word': 'aaa', 'menu': '[test]', '__text__': 'aaa'}],
        \       'b': [{'word': 'bbb', 'menu': '[test]', '__text__': 'bbb'}],
        \     },
        \   },
        \
        \   {
        \     'input': {
        \       'name': 'test',
        \       'wordlist': ['aaa', 'bbb', 'ccc'],
        \       'indexlen': 1,
        \     },
        \     'expect': {
        \       'a': [{'word': 'aaa', 'menu': '[test]', '__text__': 'aaa'}],
        \       'b': [{'word': 'bbb', 'menu': '[test]', '__text__': 'bbb'}],
        \       'c': [{'word': 'ccc', 'menu': '[test]', '__text__': 'ccc'}],
        \     },
        \   },
        \
        \   {
        \     'input': {
        \       'name': 'test',
        \       'wordlist': ['aa', 'ab', 'ac'],
        \       'indexlen': 1,
        \     },
        \     'expect': {
        \       'a': [{'word': 'aa', 'menu': '[test]', '__text__': 'aa'},
        \             {'word': 'ab', 'menu': '[test]', '__text__': 'ab'},
        \             {'word': 'ac', 'menu': '[test]', '__text__': 'ac'}],
        \     },
        \   },
        \
        \   {
        \     'input': {
        \       'name': 'test',
        \       'wordlist': ['aa', 'ac', 'ab'],
        \       'indexlen': 1,
        \     },
        \     'expect': {
        \       'a': [{'word': 'aa', 'menu': '[test]', '__text__': 'aa'},
        \             {'word': 'ac', 'menu': '[test]', '__text__': 'ac'},
        \             {'word': 'ab', 'menu': '[test]', '__text__': 'ab'}],
        \     },
        \   },
        \
        \   {
        \     'input': {
        \       'name': 'test',
        \       'wordlist': ['a', 'aa', 'aaa'],
        \       'indexlen': 3,
        \     },
        \     'expect': {
        \       'a': [{'word': 'a', 'menu': '[test]', '__text__': 'a'}],
        \       'aa': [{'word': 'aa', 'menu': '[test]', '__text__': 'aa'}],
        \       'aaa': [{'word': 'aaa', 'menu': '[test]', '__text__': 'aaa'}],
        \     },
        \   },
        \ ] "}}}

  for test in testset
    let input = test.input
    let expect = test.expect
    let Dictionary = Verdin#Dictionary#new(input.name, [], input.wordlist, input.indexlen)
    call g:assert.equals(Dictionary.index, expect,
          \ printf("name: %s,\nindexlen: %d,\nwordlist: %s",
          \         input.name, input.indexlen, string(input.wordlist)))
  endfor
endfunction "}}}
function! s:suite.sortbylength() dict abort "{{{
  " testset {{{
  let testset = [
        \   {
        \     'input': {
        \       'name': 'test',
        \       'wordlist': ['aaa', 'aa', 'a'],
        \       'indexlen': 1,
        \       'options': {}
        \     },
        \     'expect': {
        \       'a': [{'word': 'aaa', 'menu': '[test]', '__text__': 'aaa'},
        \             {'word': 'aa', 'menu': '[test]', '__text__': 'aa'},
        \             {'word': 'a', 'menu': '[test]', '__text__': 'a'}],
        \     },
        \   },
        \
        \   {
        \     'input': {
        \       'name': 'test',
        \       'wordlist': ['aaa', 'aa', 'a'],
        \       'indexlen': 1,
        \       'options': {'sortbylength': 1}
        \     },
        \     'expect': {
        \       'a': [{'word': 'a', 'menu': '[test]', '__text__': 'a'},
        \             {'word': 'aa', 'menu': '[test]', '__text__': 'aa'},
        \             {'word': 'aaa', 'menu': '[test]', '__text__': 'aaa'}],
        \     },
        \   },
        \ ] "}}}

  for test in testset
    let input = test.input
    let expect = test.expect
    let Dictionary = Verdin#Dictionary#new(input.name, [], input.wordlist, input.indexlen, input.options)
    call g:assert.equals(Dictionary.index, expect,
          \ printf("name: %s,\nindexlen: %d,\nwordlist: %s,\noption: %s",
          \         input.name, input.indexlen, string(input.wordlist), string(input.options)))
  endfor
endfunction "}}}
function! s:suite.sortbyoccurrence() dict abort "{{{
  " testset {{{
  let testset = [
        \   {
        \     'input': {
        \       'name': 'test',
        \       'wordlist': ['aaa', 'aa', 'aa', 'a', 'a', 'a'],
        \       'indexlen': 1,
        \       'options': {}
        \     },
        \     'expect': {
        \       'a': [{'word': 'aaa', 'menu': '[test]', '__text__': 'aaa'},
        \             {'word': 'aa', 'menu': '[test]', '__text__': 'aa'},
        \             {'word': 'aa', 'menu': '[test]', '__text__': 'aa'},
        \             {'word': 'a', 'menu': '[test]', '__text__': 'a'},
        \             {'word': 'a', 'menu': '[test]', '__text__': 'a'},
        \             {'word': 'a', 'menu': '[test]', '__text__': 'a'}],
        \     },
        \   },
        \
        \   {
        \     'input': {
        \       'name': 'test',
        \       'wordlist': ['aaa', 'aa', 'aa', 'a', 'a', 'a'],
        \       'indexlen': 1,
        \       'options': {'sortbyoccurrence': 1}
        \     },
        \     'expect': {
        \       'a': [{'word': 'a', 'menu': '[test]', '__text__': 'a'},
        \             {'word': 'aa', 'menu': '[test]', '__text__': 'aa'},
        \             {'word': 'aaa', 'menu': '[test]', '__text__': 'aaa'}],
        \     },
        \   },
        \ ] "}}}

  for test in testset
    let input = test.input
    let expect = test.expect
    let Dictionary = Verdin#Dictionary#new(input.name, [], input.wordlist, input.indexlen, input.options)
    call g:assert.equals(Dictionary.index, expect,
          \ printf("name: %s,\nindexlen: %d,\nwordlist: %s,\noptions: %s",
          \         input.name, input.indexlen, string(input.wordlist), string(input.options)))
  endfor
endfunction "}}}
function! s:suite.delimitermatch() dict abort "{{{
  " testset {{{
  let testset = [
        \   {
        \     'input': {
        \       'name': 'test',
        \       'wordlist': ['aa_bb_cc'],
        \       'indexlen': 1,
        \       'options': {'delimitermatch': 1},
        \     },
        \     'expect': {
        \       'a': [{'word': 'aa_bb_cc', 'menu': '[test]', '__text__': 'aa_bb_cc'},
        \             {'word': 'aa_bb_cc', 'menu': '[test] abc', 'dup': 1, '__text__': 'abc', '__delimitermatch__': 1}],
        \     },
        \   },
        \
        \   {
        \     'input': {
        \       'name': 'test',
        \       'wordlist': ['AaBbCc'],
        \       'indexlen': 1,
        \       'options': {'delimitermatch': 1},
        \     },
        \     'expect': {
        \       'A': [{'word': 'AaBbCc', 'menu': '[test]', '__text__': 'AaBbCc'},
        \             {'word': 'AaBbCc', 'menu': '[test] abc', 'dup': 1, '__text__': 'ABC', '__delimitermatch__': 1}],
        \     },
        \   },
        \ ] "}}}

  for test in testset
    let input = test.input
    let expect = test.expect
    let Dictionary = Verdin#Dictionary#new(input.name, [], input.wordlist, input.indexlen, input.options)
    call g:assert.equals(Dictionary.index, expect,
          \ printf("name: %s,\nindexlen: %d,\nwordlist: %s,\noptions: %s",
          \         input.name, input.indexlen, string(input.wordlist), string(input.options)))
  endfor
endfunction "}}}

" vim:set foldmethod=marker:
" vim:set commentstring="%s:
" vim:set ts=2 sts=2 sw=2:
