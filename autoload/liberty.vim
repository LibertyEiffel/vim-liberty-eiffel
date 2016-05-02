" Vim Liberty Eiffel plugin support functions
" Maintainer:   Doug Kearns <dougkearns@gmail.com>
" Last Change:  2016 May 2

" Utility functions {{{1
function! liberty#FindFile(file) abort
  " TODO: handle binary detection separately
  let output = substitute(system("se find -raw " . a:file), '\n$', "", "")
  if v:shell_error
    return []
  else
    return split(output, '\n')
  endif
endfunction

function! liberty#EditFile(file, cmd) abort
  try
    exe "silent " . a:cmd . " " . fnameescape(a:file)
  catch /^Vim(edit):E37:/
    call liberty#EchoErrMsg(substitute(v:exception, '.\{-}:', "", ""))
  endtry
endfunction

function! liberty#EchoErr(expr)
  redrawstatus!
  echohl ErrorMsg
  echo a:expr
  echohl None
  let v:errmsg = a:expr
endfunction

function! liberty#EchoErrMsg(expr)
  redrawstatus!
  echohl ErrorMsg
  echomsg a:expr
  echohl None
  let v:errmsg = a:expr
endfunction

" Command and Mapping Actions {{{1
function! liberty#GotoFileMap(file, count, cmd) abort
  if empty(a:file)
    call liberty#EchoErrMsg("E446: No file name under cursor")
  else
    call liberty#GotoFile(a:file, a:count, a:cmd)
  endif
endfunction

function! liberty#GotoFile(file, count, cmd) abort
  let files = liberty#FindFile(a:file)
  if empty(files)
    call liberty#EchoErrMsg('E447: Cannot find file "' . a:file . '" in path')
  elseif a:count > len(files)
    call liberty#EchoErrMsg('E347: No more file "' . a:file . '" found in path')
  else
    call liberty#EditFile(files[a:count - 1], a:cmd)
  endif
endfunction

function! liberty#GotoDeclaration(word) abort
  let word = '^\%(\%(\--\)\@!.\)*\zs\<' . a:word . '\>'
  let @/ = word
  call search('^\s\+\%' . (&sw + 1) . 'v\a', 'bW')
  call search(word, 'W')
endfunction

" vim: nowrap sw=2 sts=2 ts=8 fdm=marker
