let s:const = Verdin#constants#distribute()

function! Verdin#lib#distribute() abort
  return s:lib
endfunction

function! s:distancemap(n) abort "{{{
  let d = [range(a:n + 1)]
  for i in range(1, a:n)
    let d += [[i] + repeat([0], a:n)]
  endfor
  return d
endfunction
let s:dmax = 5
let s:distancemap = s:distancemap(s:dmax)
"}}}

let s:lib = {}
function! s:lib.word(item) dict abort "{{{
  let itemtype = type(a:item)
  if itemtype == v:t_string
    return a:item
  elseif itemtype == v:t_dict
    return a:item.word
  elseif itemtype == v:t_list
    return a:item[1]
  endif
  return ''
endfunction "}}}
function! s:lib.__text__(item) dict abort "{{{
  let itemtype = type(a:item)
  if itemtype == v:t_string
    return a:item
  elseif itemtype == v:t_dict
    return get(a:item, '__text__', a:item.word)
  elseif itemtype == v:t_list
    return a:item[0]
  endif
  return ''
endfunction "}}}
function! s:lib.abbr(item) dict abort "{{{
  let itemtype = type(a:item)
  if itemtype == v:t_string
    return a:item
  elseif itemtype == v:t_dict
    return get(a:item, 'abbr', a:item.word)
  elseif itemtype == v:t_list
    return a:item[1]
  endif
  return ''
endfunction "}}}
function! s:lib.names(item) dict abort "{{{
  let itemtype = type(a:item)
  if itemtype == v:t_string
    return [a:item, a:item, a:item]
  elseif itemtype == v:t_dict
    return [a:item.word, get(a:item, '__text__', a:item.word), get(a:item, 'abbr', a:item.word)]
  elseif itemtype == v:t_list
    return [a:item[1], a:item[0], a:item[1]]
  endif
  return ''
endfunction "}}}
function! s:lib.sortbyoccurrence(list) dict abort "{{{
  let original = copy(a:list)
  call uniq(sort(a:list))
  call sort(a:list, {a, b -> count(original, b) - count(original, a)})
  return a:list
endfunction "}}}
function! s:lib.sortbylength(list) dict abort "{{{
  return sort(a:list, {a, b -> strchars(s:lib.word(a)) - strchars(s:lib.word(b))})
endfunction "}}}
function! s:lib.escape(string) dict abort "{{{
  return escape(a:string, '~"\.^$[]*')
endfunction "}}}
function! s:lib.pathjoin(parts) dict abort "{{{
  return join(a:parts, s:const.PATHSEPARATOR)
endfunction "}}}
function! s:lib.searchvimscripts() dict abort "{{{
  let searchpaths = Verdin#getoption('loadpath')
  let scriptpaths = []
  for path in searchpaths
    call extend(scriptpaths, glob(path, 0, 1))
  endfor
  return uniq(sort(scriptpaths))
endfunction "}}}
function! s:lib.searchvimhelps() dict abort "{{{
  let docpaths = glob(self.pathjoin(['doc', '*.txt']), 0, 1)
  if len(docpaths) > s:const.DOCPATHSMAX
    " not to load too much txt files
    let docpaths = docpaths[: s:const.DOCPATHSMAX]
  endif
  return docpaths
endfunction "}}}
function! s:lib.filetypematches(ft, ...) abort "{{{
  let bufnr = a:0 > 0 ? a:1 : bufnr('%')
  let filetype = getbufvar(bufnr, '&filetype')
  let ftpat = '\C^' . s:lib.escape(a:ft) . '$'
  return match(split(filetype, '\.'), ftpat) > -1
endfunction "}}}

" fuzzy match
function! s:lib.Damerau_Levenshtein_distance(a, b) dict abort "{{{
  " NOTE: Cannot apply for multi-byte strings
  let na = strchars(a:a)
  let nb = strchars(a:b)
  let nmax = max([na, nb])
  if nmax > s:dmax
    let d = s:distancemap(nmax)
  else
    let d = deepcopy(s:distancemap)
  endif
  for i in range(1, na)
    for j in range(1, nb)
      let const = a:a[i-1] ==? a:b[j-1] ? 0 : 1
      if i > 1 && j > 1 && a:a[i-1] ==? a:b[j-2] && a:a[i-2] ==? a:b[j-1]
        let d[i][j] = min([d[i-1][j] + 1, d[i][j-1] + 1, d[i-1][j-1] + const, d[i-2][j-2] + const])
      else
        let d[i][j] = min([d[i-1][j] + 1, d[i][j-1] + 1, d[i-1][j-1] + const])
      endif
    endfor
  endfor
  return d[na][nb]
endfunction "}}}
function! s:lib.DL_threshold(strlen) dict abort "{{{
  " NOTE: for Damerau_Levenshtein_distance()
  if a:strlen <= 4
    let threshold = 1
  elseif a:strlen <= 16
    let threshold = 2
  else
    let threshold = 3
  endif
  return threshold
endfunction "}}}
function! s:lib.Jaro_Winkler_distance(a, b) dict abort "{{{
  " NOTE: Cannot apply for multi-byte strings
  if a:a ==# '' || a:b ==# ''
    return 0.0
  elseif a:a ==? a:b
    return 1.0
  endif
  let na = strlen(a:a)
  let nb = strlen(a:b)
  let [c, acommons, bcommons] = s:commonchar(a:a, a:b, na, nb)
  if c == 0.0
    return 0.0
  endif
  let t = s:transposechar(acommons, bcommons)
  let dj = (c/na + c/nb + 1.0 - t/c)/3.0
  if dj < 0.7
    return dj
  endif
  let l = s:commonprefix(a:a, a:b, na, nb)
  let djw = dj + l*0.1*(1.0 - dj)
  return djw
endfunction "}}}

function! s:commonchar(a, b, na, nb) abort "{{{
  " NOTE: Cannot apply for multi-byte strings
  let window = max([a:na, a:nb, 4])/2 - 1
  let c = 0.0
  let acommons = []
  let bindexes = []
  for i in range(len(a:a))
    let j = i - window
    while j <= i + window
      let start = j
      let j = stridx(a:b, a:a[i], start)
      if j == -1
        if a:a[i] =~# '[A-Z]'
          let j = stridx(a:b, tolower(a:a[i]), start)
        else
          let j = stridx(a:b, toupper(a:a[i]), start)
        endif
      endif
      if j == -1 || !count(bindexes, j, 1)
        break
      endif
      let j += 1
    endwhile
    if j != -1 && j <= i + window
      call add(acommons, a:a[i])
      call add(bindexes, j)
      let c += 1.0
    endif
  endfor
  return [c, acommons, map(sort(bindexes), 'a:b[v:val]')]
endfunction "}}}
function! s:transposechar(acommons, bcommons) abort "{{{
  let n = len(a:acommons)
  if n <= 1
    return 0.0
  endif
  let t = 0.0
  for i in range(n)
    if a:acommons[i] !=? a:bcommons[i]
      let t += 1.0
    endif
  endfor
  return t/2
endfunction "}}}
function! s:commonprefix(a, b, na, nb) abort "{{{
  " NOTE: Cannot apply for multi-byte strings
  let l = 0
  while l < min([3, a:na, a:nb])
    if a:a[l] !=# a:b[l]
      break
    endif
    let l += 1
  endwhile
  return l > 4 ? 4 : l
endfunction "}}}

" vim:set ts=2 sts=2 sw=2 tw=0:
" vim:set foldmethod=marker: commentstring="%s:
