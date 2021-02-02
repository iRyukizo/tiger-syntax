if exists("b:current_syntax")
  finish
endif

syn keyword tigerStatements array if then else while for to do let in end of break nil function var type import primitive class extends method new
hi def link tigerStatements Statement

syn match tigerNumber '\d\+'
hi def link tigerNumber Number

syn region tigerString start='"' end='"'
hi def link tigerString String

syn match tigerDelimiter "[();\\]"
syn match tigerBraces display "[{}]"
hi def link tigerDelimiter Delimiter
hi def link tigerBraces Delimiter

syn match tigerOperator "[-+*/%&^|<>!=]="
syn match tigerOperator "[*&<>^|=+-/]"

syn region tigerComments start="/\*" end="\*/"
hi def link tigerComments Comment

syn keyword tigerTypes int string Object
hi def link tigerTypes Type

syn keyword tigerFuncs chr concat exit flush getchar not ord print print_err print_int size strcmp streq substring
hi def link tigerFuncs Function
