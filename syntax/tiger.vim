if exists("b:current_syntax")
  finish
endif

syn keyword tigerStatements array let in end of break nil function var import primitive class extends method new
hi def link tigerStatements Statement

syn keyword tigerConditional if then else
hi def link tigerConditional Conditional

syn keyword tigerRepeat for to while do
hi def link tigerRepeat Repeat

syn keyword tigerTypeDef type
hi def link tigerTypeDef Typedef

syn match tigerNumber '\d\+'
hi def link tigerNumber Number

syntax match tigerEscapeSequence '\\[\\abfnrtv"]' contained
syn region tigerString oneline start='"' skip='\\' end='"' end='$' contains=tigerEscapeSequence
hi def link tigerString String
hi def link tigerEscapeSequence SpecialChar

syn match tigerDelimiter "[();\\]"
syn match tigerBraces display "[{}]"
hi def link tigerDelimiter Delimiter
hi def link tigerBraces Delimiter

syntax keyword tigerOperator := + - * / \| & = \<\> > < <= >=
hi link tigerOperator Operator

syn region tigerComments start="/\*" end="\*/"
hi def link tigerComments Comment

syn keyword tigerTypes int string Object
hi def link tigerTypes Type

syn keyword tigerFuncs chr concat exit flush getchar not ord print print_err print_int size strcmp streq substring
hi def link tigerFuncs Function
