if exists("b:current_syntax")
  finish
endif

syn keyword tigerStatements let in end of break class extends method new
hi def link tigerStatements Statement

syn keyword tigerConditional if then else
hi def link tigerConditional Conditional

syn keyword tigerRepeat for to while do
hi def link tigerRepeat Repeat

syn keyword tigerStructure array
hi def link tigerStructure Structure

syn keyword tigerStorageClass var
hi def link tigerStorageClass StorageClass

syn keyword tigerDecl function primitive
hi def link tigerDecl Type

syn keyword tigerImport import
hi def link tigerImport Include

syn keyword tigerTypeDef type
hi def link tigerTypeDef Typedef

syn match tigerNumber '\d\+'
hi def link tigerNumber Number

syn match tigerIdentifier '[a-zA-Z_][a-zA-Z_0-9]\+'

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

syn keyword tigerTodo contained TODO FIXME XXX NOTE[S]
hi def link tigerTodo Todo
syn region tigerComments start="/\*" end="\*/" contains=tigerTodo
hi def link tigerComments Comment

syn keyword tigerTypes int string Object
hi def link tigerTypes Type

syn keyword tigerNil nil
hi def link tigerNil Constant

syn keyword tigerFuncs chr concat exit flush getchar not ord print print_err print_int size strcmp streq substring
hi def link tigerFuncs Function
