let s:lib = Verdin#lib#distribute()
let s:const = Verdin#constants#distribute()
let s:default = s:const.option.default

command! -buffer -nargs=0 -bang VerdinStartAutocompletion call Verdin#startautocomplete('<bang>')
command! -buffer -nargs=0 -bang VerdinStopAutocompletion  call Verdin#stopautocomplete('<bang>')
if s:lib.getoption('debugmodeon')
  command! -buffer -nargs=0 -bang VerdinRefreshAutocompletion call Verdin#refreshautocomplete('<bang>')
  command! -buffer -nargs=0 -bang VerdinFinishAutocompletion  call Verdin#finishautocomplete('<bang>')
endif

if !s:lib.getoption('donotsetomnifunc')
  setlocal omnifunc=Verdin#omnifunc
endif

if s:lib.getoption('autocomplete')
  VerdinStartAutocompletion
endif

