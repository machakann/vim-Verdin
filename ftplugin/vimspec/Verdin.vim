if exists("b:did_ftplugin_Verdin_complete")
  finish
endif
let b:did_ftplugin_Verdin_complete = 1

if exists(':VerdinStartAutocompletion')
  finish
endif

runtime macros/Verdin/ftplugin.vim
