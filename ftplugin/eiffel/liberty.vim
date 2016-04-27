" Vim filetype plugin
" Language:	Liberty Eiffel
" Maintainer:	Doug Kearns <dougkearns@gmail.com>
" Last Change:	2016 Apr 27

" support Liberty Eiffel features in the generalised runtime files
let eiffel_liberty=1

" official style guidelines
set expandtab
set shiftwidth=3
set softtabstop=3

" syntastic support
if exists('g:syntastic_extra_filetypes')
  call add(g:syntastic_extra_filetypes, 'eiffel')
else
  let g:syntastic_extra_filetypes = ['eiffel']
endif

let g:syntastic_eiffel_checkers = ['se_class_check']
