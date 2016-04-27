"============================================================================
"File:	      se_class_check.vim
"Description: Syntax checking plugin for syntastic.vim
"Maintainer:  Doug Kearns <dougkearns@gmail.com>
"License:     This program is free software. It comes without any warranty,
"             to the extent permitted by applicable law. You can redistribute
"             it and/or modify it under the terms of the Do What The Fuck You
"             Want To Public License, Version 2, as published by Sam Hocevar.
"             See http://sam.zoy.org/wtfpl/COPYING for more details.
"
"============================================================================

if exists('g:loaded_syntastic_eiffel_se_class_check_checker')
    finish
endif
let g:loaded_syntastic_eiffel_se_class_check_checker = 1

let s:save_cpo = &cpo
set cpo&vim

function! SyntaxCheckers_eiffel_se_class_check_IsAvailable() dict
  return executable(self.getExec())
endfunction

function! SyntaxCheckers_eiffel_se_class_check_GetHighlightRegex(item)
  " Catches a bit too much and misses some inconsistencies in the message
  " format but good enough for now™
  let term = matchstr(a:item['text'], "`\\zs[^']\\+\\ze'")
  return empty(term) ? '' : '\V\<' . term . '\>'
endfunction

function! SyntaxCheckers_eiffel_se_class_check_GetLocList() dict
  let makeprg = self.makeprgBuild({
      \ 'args_before': 'class_check',
      \ 'args': '-style_warning' })

  let errorformat = '%W******\ Warning:\ %m,' .
		  \ '%E******\ Fatal\ Error:\ %m,' .
		  \ '%E******\ Error:\ %m,' .
		  \ '%ZLine\ %l\ column\ %c\ in\ %.%#\ (%f)\ %\\=:,' .
		  \ '%ZLine\ %l\ columns\ %c\\,\ %\\d%\\+\ %.%#\ (%f)\ %\\=:,' .
		  \ '%+C%*[^\ ]%.%#,' .
		  \ '%-GThe\ source\ lines\ involved,' .
		  \ '%-G%.%#'

  return SyntasticMake({
      \ 'makeprg': makeprg,
      \ 'errorformat': errorformat,
      \ 'cwd': expand('%:p:h', 1) })
endfunction

call g:SyntasticRegistry.CreateAndRegisterChecker({
    \ 'filetype': 'eiffel',
    \ 'name': 'se_class_check',
    \ 'exec': 'se' })

" vim: sw=2 sts=2 ts=8:
