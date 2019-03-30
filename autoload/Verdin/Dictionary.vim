let s:const = Verdin#constants#distribute()
let s:lib = Verdin#lib#distribute()

function! Verdin#Dictionary#new(name, conditionlist, wordlist, ...) abort "{{{
  let indexlen = max([get(a:000, 0, 1), 1])
  let options = get(a:000, 1, {})
  return s:Dictionary(a:name, a:conditionlist, a:wordlist, indexlen, options)
endfunction "}}}
function! Verdin#Dictionary#makeindex(name, wordlist, indexlen, ...) abort "{{{
  let options = get(a:000, 0, {})
  let sortbyoccurrence = get(options, 'sortbyoccurrence', 0)
  let sortbylength = get(options, 'sortbylength', 0)
  let menustr = a:name ==# '' ? '' : printf('[%s]', a:name)
  let initials = uniq(sort(map(copy(a:wordlist), 'strcharpart(s:lib.__text__(v:val), 0, a:indexlen)')))
  let wordlist = copy(a:wordlist)
  let index = {}
  for c in sort(initials, {a, b -> strchars(b) - strchars(a)})
    let pattern = '^' . s:lib.escape(c)
    let matched = s:extract(wordlist, pattern)
    if sortbyoccurrence
      call s:lib.sortbyoccurrence(matched)
    endif
    if sortbylength
      call s:lib.sortbylength(matched)
    endif
    let index[c] = map(copy(matched), 's:completeitem(v:val, menustr)')
  endfor
  return index
endfunction "}}}

" Dictionary object {{{
let s:Dictionary = {
      \   'name': '',
      \   'conditionlist': [],
      \   'wordlist': [],
      \   'indexlen': 0,
      \   'index': {},
      \ }

function! s:Dictionary(name, conditionlist, wordlist, indexlen, options) abort
  let Dictionary = deepcopy(s:Dictionary)
  let Dictionary.name = a:name
  let Dictionary.conditionlist = a:conditionlist
  let Dictionary.wordlist = copy(a:wordlist)
  let Dictionary.indexlen = a:indexlen
  let Dictionary.index = Verdin#Dictionary#makeindex(
        \ Dictionary.name, Dictionary.wordlist, Dictionary.indexlen, a:options)
  return Dictionary
endfunction
function! s:extract(list, pattern) abort "{{{
  let extracted = []
  for i in reverse(range(len(a:list)))
    if s:lib.__text__(a:list[i]) =~# a:pattern
      call insert(extracted, remove(a:list, i))
    endif
  endfor
  return extracted
endfunction "}}}
function! s:completeitem(item, menustr) abort "{{{
  let itemtype = type(a:item)
  if itemtype == v:t_string
    return {'word': a:item, 'menu': a:menustr, '__text__': a:item}
  elseif itemtype == v:t_list
    return {'word': a:item[1], 'menu': printf('%s %s', a:menustr, a:item[0]), '__text__': a:item[0]}
  elseif itemtype == v:t_dict
    let completeitem = copy(a:item)
    if !has_key(completeitem, 'menu')
      let completeitem.menu = a:menustr
    endif
    if !has_key(completeitem, '__text__')
      let completeitem.__text__ = a:item.word
    endif
    return completeitem
  else
    return {}
  endif
endfunction "}}}
"}}}

" vim:set ts=2 sts=2 sw=2 tw=0:
" vim:set foldmethod=marker: commentstring="%s:
