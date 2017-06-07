let s:save_cpo = &cpo
set cpo&vim

let s:lib = Verdin#lib#distribute()
let s:const = Verdin#constants#distribute()

let s:matcher = {
      \   'name': 'matcher_Verdin',
      \ }
function! s:matcher.filter(context) dict abort "{{{
  let Completer = Verdin#Completer#get()
  let itemlist = Completer.match(a:context.complete_str)
  let fuzzymatch = s:lib.getoption('fuzzymatch')
  if fuzzymatch && strchars(a:context.complete_str) >= 3
    let timeout = s:const.FUZZYMATCHINTERVAL
    let totaltimeout = s:lib.getoption('autocompletedelay')
    call Completer.clock.start()
    while Completer.fuzzycandidatelist != [] && Completer.clock.elapsed() < totaltimeout
      if getchar(1) isnot# 0 || len(itemlist) > s:const.ITEMLISTTHRESHOLD
        break
      endif
      let itemlist += Completer.fuzzymatch(a:context.complete_str, timeout)
    endwhile
  endif
  return itemlist
endfunction
"}}}

function! neocomplete#filters#matcher_Verdin#define() abort
  return s:matcher
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

" vim:set ts=2 sts=2 sw=2 tw=0:
" vim:set foldmethod=marker: commentstring="%s:
