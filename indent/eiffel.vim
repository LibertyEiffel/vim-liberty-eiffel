" Vim indent file
" Language:	Eiffel
" Maintainer:	Jocelyn Fiat <jfiat@eiffel.com>
" Previous-Maintainer:	David Clarke <gadicath@dishevelled.net>
" Contributions from: Thilo Six
" $Date: 2004/12/09 21:33:52 $
" $Revision: 1.3 $
" URL: https://github.com/eiffelhub/vim-eiffel

" Only load this indent file when no other was loaded.
if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

setlocal indentexpr=GetEiffelIndent(v:lnum)
setlocal nolisp
setlocal nosmartindent
setlocal nocindent
setlocal autoindent

" kitchen sink for now
setlocal indentkeys+==note,=class,=obsolete,=inherit,=create,=convert,=feature,=invariant
if exists("eiffel_liberty") | setlocal indentkeys+==insert | endif
setlocal indentkeys+==undefine,=redefine,=rename,=export,=select
setlocal indentkeys+==do,=once,=external,=deferred,=attribute,=require,=local,=ensure
setlocal indentkeys+==if,=then,=elseif,=else
setlocal indentkeys+==check,=debug,=rescue
setlocal indentkeys+==from,=until,=loop,=variant,=across
setlocal indentkeys+==inspect,=when
setlocal indentkeys+==end

let b:undo_indent = "setl smartindent< indentkeys< indentexpr< autoindent< comments<"

" Define some stuff
" keywords grouped by indenting
let s:trust_user_indent = '\(+\)\(\s*\(--\).*\)\=$'

let s:relative_indent  = '^\s*\(note\|class\|obsolete\|inherit\|create\|convert\|feature\|invariant\|'
if exists("eiffel_liberty") | let s:relative_indent .= 'insert\|' | endif
let s:relative_indent .=       'undefine\|redefine\|rename\|export\|select\|'
let s:relative_indent .=       'do\|once\|external\|deferred\|attribute\|local\|require\|ensure\|'
let s:relative_indent .=       'across\|from\|until\|loop\|variant\|if\|then\|else\|elseif\|inspect\|when\|check\|debug\|rescue\)\>'

let s:outdent = '^\s*\(obsolete\|require\|local\|do\|once\|deferred\|external\|attribute\|rescue\|ensure\|then\|else\|until\|loop\|invariant\|variant\|when\)\>'

let s:inheritance_indent = '\s*\(undefine\|redefine\|rename\|export\|select\)\>'

let s:single_indent = '^[^-]\+[[:alnum:]]\+ \(\s*\(--\).*\)\=$'

let s:no_indent = '^\s*\(note\|class\|obsolete\|inherit\|'
if exists("eiffel_liberty") | let s:no_indent .=    'insert\|' | endif
let s:no_indent   .=    'create\|convert\|feature\|invariant\)\>'

" Only define the function once.
if exists("*GetEiffelIndent")
  finish
endif

let s:keepcpo= &cpo
set cpo&vim

function GetEiffelIndent(lnum)

  " Eiffel Class indenting
  "
  " Find a non-blank line above the current line.
  let lnum = prevnonblank(a:lnum - 1)

  " At the start of the file use zero indent.
  if lnum == 0
    return 0
  endif

  " trust the user's indenting
  if getline(lnum) =~ s:trust_user_indent
    return -1
  endif

  " Add a 'shiftwidth' after lines that start with an indent word
  let ind = indent(lnum)
  if getline(lnum) =~ s:relative_indent
    let ind = ind + &sw
  endif

  " Indent to single indent
  if getline(a:lnum) =~ s:single_indent && getline(a:lnum) !~ s:relative_indent
	   \ && getline(a:lnum) !~ '\s*\<\(and\|or\|implies\)\>'
    let ind = &sw
  endif

  " Indent to double indent
  if getline(a:lnum) =~ s:inheritance_indent
    let ind = 2 * &sw
  endif

  " Indent line after the first line of the function definition
  if getline(lnum) =~ s:single_indent
    let ind = ind + &sw
  endif

  " The following should always be at the start of a line, no indenting
  if getline(a:lnum) =~ s:no_indent
    let ind = 0
  endif

  " Subtract a 'shiftwidth', if this isn't the first thing after the 'is'
  " or first thing after the 'do'
  if getline(a:lnum) =~ s:outdent && getline(a:lnum - 1) !~ s:single_indent
	\ && getline(a:lnum - 1) !~ '^\s*do\>'
   let ind = ind - &sw
  endif

  " Subtract a shiftwidth for end statements
  if getline(a:lnum) =~ '^\s*end\>'
    let ind = ind - &sw
  endif

  " set indent of zero end statements that are at an indent of 3, this should
  " only ever be the class's end.
  if getline(a:lnum) =~ '^\s*end\>' && ind == &sw
    let ind = 0
  endif

  return ind
endfunction

let &cpo = s:keepcpo
unlet s:keepcpo

" vim: nowrap sw=2 sts=2 ts=8
