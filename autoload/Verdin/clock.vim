" clock object - measuring elapsed time in a operation

" variables "{{{
" features
let s:has_reltime_and_float = has('reltime') && has('float')
"}}}


" Constructor of clock object
function! Verdin#clock#new() abort  "{{{
  return deepcopy(s:clock)
endfunction "}}}


" clock object "{{{
let s:clock = {
      \   'started' : 0,
      \   'paused'  : 0,
      \   'zerotime': reltime(),
      \   'stoptime': reltime(),
      \   'losstime': 0,
      \ }
"}}}

" start measuring time
function! s:clock.start() dict abort  "{{{
  if self.started && self.paused
    let self.losstime += str2float(reltimestr(reltime(self.stoptime)))
    let self.paused = 0
  else
    if s:has_reltime_and_float
      let self.zerotime = reltime()
      let self.started = 1
    endif
  endif
endfunction "}}}

" pause measuring time
" NOTE: call clock.start() again to re-start measurement.
function! s:clock.pause() dict abort "{{{
  let self.stoptime = reltime()
  let self.paused = 1
endfunction "}}}

" return the elapsed time
function! s:clock.elapsed() dict abort "{{{
  if self.started
    let total = str2float(reltimestr(reltime(self.zerotime)))
    return floor((total - self.losstime)*1000)
  else
    return 0.0
  endif
endfunction "}}}

" stop the current measurement
function! s:clock.stop() dict abort  "{{{
  let self.started = 0
  let self.paused = 0
  let self.losstime = 0
endfunction "}}}


" vim:set foldmethod=marker:
" vim:set commentstring="%s:
" vim:set ts=2 sts=2 sw=2:
