" Vim filetype plugin
" Language:	LACE
" Maintainer:	Doug Kearns <dougkearns@gmail.com>
" Last Change:	2016 Apr 28

if (exists("b:did_ftplugin"))
  finish
endif
let b:did_ftplugin = 1

let s:cpo_save = &cpo
set cpo&vim

setlocal comments=:--
setlocal commentstring=--\ %s

setlocal formatoptions-=t formatoptions+=croql

if (has("gui_win32") || has("gui_gtk")) && !exists("b:browsefilter")
  let b:browsefilter = "Eiffel Source Files (*.e)\t*.e\n" .
		     \ "Eiffel Control Files (*.ecf, *.ace, *.xace)\t*.ecf;*.ace;*.xace\n" .
		     \ "All Files (*.*)\t*.*\n"
endif

let b:undo_ftplugin = "setl fo< com< cms<" .
  \ "| unlet! b:browsefilter" 

let &cpo = s:cpo_save
unlet s:cpo_save

" vim: nowrap sw=2 sts=2 ts=8
