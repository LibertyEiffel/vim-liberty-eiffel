" Vim filetype plugin
" Language:	Liberty Eiffel
" Maintainer:	Doug Kearns <dougkearns@gmail.com>
" Last Change:  2016 May 2

" support Liberty Eiffel features in the generalised runtime files
let eiffel_liberty=1

" syntastic support {{{1
if exists('g:syntastic_extra_filetypes')
  call add(g:syntastic_extra_filetypes, 'eiffel')
else
  let g:syntastic_extra_filetypes = ['eiffel']
endif

let g:syntastic_eiffel_checkers = ['se_class_check']

" official style guidelines {{{1
set expandtab
set shiftwidth=3
set softtabstop=3

" mappings {{{1
nnoremap <silent> <buffer> gf         :<C-U>call liberty#GotoFileMap(expand("<cword>"), v:count1, "edit")<CR>
nnoremap <silent> <buffer> <C-w>gf    :<C-U>call liberty#GotoFileMap(expand("<cword>"), v:count1, "tabedit")<CR>
nnoremap <silent> <buffer> <C-w>f     :<C-U>call liberty#GotoFileMap(expand("<cword>"), v:count1, "split")<CR>
nnoremap <silent> <buffer> <C-w><C-f> :<C-U>call liberty#GotoFileMap(expand("<cword>"), v:count1, "split")<CR>

nnoremap <silent> <buffer> gd         :<C-U>call liberty#GotoDeclaration(expand("<cfile>"))<CR>:set invhls<CR>:set invhls<CR>

" commands {{{1
command! -nargs=1 -count=1 -bang LEFind call liberty#GotoFile(<f-args>, <count>, "edit<bang>")

" vim: nowrap sw=2 sts=2 ts=8 fdm=marker
