" Vim syntax file
" Language:	Liberty Eiffel ACE
" Maintainer:	Doug Kearns <dougkearns@gmail.com>
" Last Change:	2016 Apr 27

syn keyword laceOptionClause no_strip split no_split clean
syn keyword laceOptionClause assertion_flat_check no_warning verbose
syn keyword laceOptionClause manifest_string_trace high_memory_compiler
syn keyword laceOptionClause style_warning no_style_warning relax

syn keyword laceOptionMark boost

syn region  laceMultilineComment start="^\s*--.*\n\%(\s*--\)\@=" end="^\s*--.*\n\%(\s*--\)\@!" contains=laceComment transparent keepend fold
syn cluster laceComment		 contains=laceComment,laceMultilineComment
