" Vim compiler file
" Compiler:	ace_check (Liberty Eiffel Compiler)
" Maintainer:	Doug Kearns <dougkearns@gmail.com>
" Last Change:	2016 May 4

if exists("current_compiler")
  finish
endif
let current_compiler = "ace_check"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpo
set cpo-=C

CompilerSet makeprg=se\ ace_check

CompilerSet errorformat=%W******\ Warning:\ %m,
		    \%E******\ Fatal\ Error:\ %m,
		    \%E******\ Error:\ %m,
		    \%ZLine\ %l\ in\ %.%#\ (%f)\ %\\=:,
		    \%+C%*[^\ ]%.%#,
		    \%-G%.%#

let &cpo = s:cpo_save
unlet s:cpo_save
