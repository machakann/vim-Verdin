let s:lib = Verdin#lib#distribute()

function! Verdin#Worddictionary#new(name, conditionlist, wordlist, ...) abort "{{{
  return s:Worddictionary(a:name, a:conditionlist, a:wordlist, max([get(a:000, 0, 1), 1]))
endfunction
"}}}

" Word dictionary object {{{
let s:Worddictionary = {
      \   'name': '',
      \   'conditionlist': [],
      \   'wordlist': [],
      \   'indexlen': 0,
      \   'index': {},
      \ }

function! s:Worddictionary(name, conditionlist, wordlist, indexlen) abort
  let Dictionary = deepcopy(s:Worddictionary)
  let Dictionary.name = a:name
  let Dictionary.conditionlist = a:conditionlist
  let Dictionary.indexlen = a:indexlen
  let Dictionary.index = s:makeindex(Dictionary, a:wordlist)
  return Dictionary
endfunction
function! s:makeindex(Dictionary, wordlist) abort "{{{
  let menustr = printf('[%s]', a:Dictionary.name)
  let indexlen = a:Dictionary.indexlen
  let wordlist = sort(copy(a:wordlist))
  let initials = uniq(map(copy(wordlist), 'strcharpart(v:val, 0, indexlen)'))
  let partialdict = {}
  for c in initials
    if strchars(c) < a:Dictionary.indexlen
      let pattern = '^' . s:lib.escape(c) . '$'
    else
      let pattern = '^' . s:lib.escape(c)
    endif
    let partialdict[c] = {}
    let partialdict[c]['itemlist'] = s:extract(wordlist, pattern)
  endfor
  return partialdict
endfunction
"}}}
function! s:extract(list, pattern) abort "{{{
  let extracted = []
  let i = s:matchend(a:list, a:pattern)
  if i > -1
    let extracted = remove(a:list, 0, i)
  endif
  return extracted
endfunction
"}}}
function! s:matchend(list, pattern) abort "{{{
  if a:list == []
    return -1
  endif
  let start = match(a:list, a:pattern)
  if start == -1
    return -1
  endif
  let end = len(a:list) - 1
  if a:list[end] =~# a:pattern
    return end
  endif
  for i in range(start+1, start+11)
    if a:list[i] !~# a:pattern
      return start
    endif
    let start = i
  endfor

  let needle = -1
  while needle != end-1
    let needle = (start + end)/2
    if a:list[needle] =~# a:pattern
      let start = needle
    else
      let end = needle
    endif
  endwhile
  return needle
endfunction
"}}}
function! s:completeitem(item, menustr) abort "{{{
  return {'word': a:item, 'menu': a:menustr, '__text__': a:item}
endfunction
"}}}
"}}}


" vim:set ts=2 sts=2 sw=2 tw=0:
" vim:set foldmethod=marker: commentstring="%s:
