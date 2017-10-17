command! -buffer -nargs=? -complete=custom,Verdin#Verdin#scanbuffer_compl VerdinScanBuffer call Verdin#Verdin#scanbuffer(<q-args>)
command! -buffer -nargs=0 -bang VerdinStartAutocompletion call Verdin#Verdin#startautocomplete('<bang>')
command! -buffer -nargs=0 -bang VerdinStopAutocompletion  call Verdin#Verdin#stopautocomplete('<bang>')
if Verdin#getoption('debugmodeon')
  command! -buffer -nargs=0 -bang VerdinRefreshAutocompletion call Verdin#Verdin#refreshautocomplete('<bang>')
  command! -buffer -nargs=0 -bang VerdinFinishAutocompletion  call Verdin#Verdin#finishautocomplete('<bang>')
endif

if !Verdin#getoption('donotsetomnifunc')
  setlocal omnifunc=Verdin#omnifunc
endif

if Verdin#getoption('autocomplete')
  VerdinStartAutocompletion
endif
