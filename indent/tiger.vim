setlocal indentexpr=TgfIndent()
setlocal indentkeys==end,=in,=let,=if,e,=then,O,o

function! IncrementIndent(line)
  return indent(a:line) + &shiftwidth 
endfunction

function! IsNotOver(lst, times)
  let Count   = 1
  let NotOver = 1
  while Count < len(a:lst)
    let NotOver = NotOver && (a:times[a:lst[Count-1]] <= a:times[a:lst[Count]])
    let Count   = Count + 1
  endwhile
  return NotOver
endfunction

function! FindLast(...)
  let pNum   = v:lnum
  let times = {}
  for i in a:000
    let times[i] = 0
  endfor
  while IsNotOver(a:000, times)
    let pNum  = prevnonblank(pNum-1)
    let pLine = getline(pNum)
    for i in a:000
      let iStr = "\\\<" . i . "\\\>"
      if pLine =~ iStr
        let times[i] = times[i] + 1
      endif
    endfor
    if pNum == 1
      break
    endif
  endwhile
  return pNum
endfunction

function! CheckEmpty()
    if v:lnum == 1
        return 1
    endif
    let resu = 1
    let line = v:lnum - 1
    while (line >= 1)
        if (len(getline(line)) > 1)
            let resu = 0
        endif
        let line = line - 1
    endwhile
    return resu
endfunction

function! TgfIndent()
  let thisLine = getline(v:lnum)

  let synCount = {}
  let synCount['let'] = 0
  let synCount['in'] = 0
  let synCount['end'] = 0
  let synCount['if'] = 0
  let synCount['then'] = 0
  let synCount['else'] = 0
  let synCount['var'] = 0
  let synCount['function'] = 0
  let synCount['type'] = 0

  let pNum  = prevnonblank(v:lnum - 1)
  let pLine = getline(pNum)

  if (thisLine !~ '\<let\>' && (thisLine =~ '\<in\>' || thisLine =~ '\<end\>'))
    if (CheckEmpty() == 0)
        let lastN = FindLast('let', 'in', 'end')
        return indent(lastN)
    endif
  endif

  if (thisLine !~ '\<if\>' && thisLine =~ '\<else\>' && CheckEmpty() == 0)
    let lastN = FindLast('if', 'then', 'else')
    return indent(lastN)
  elseif (thisLine !~ '\<if\>' && thisLine =~ '\<then\>'&& CheckEmpty() == 0)
    return IncrementIndent(FindLast('if', 'then'))
  endif

  if (pLine =~ '\<function\>' && pLine =~ '\v\=\ *$') 
    return IncrementIndent(pNum)
  endif
  if (pLine =~ '\<var\>' && pLine =~ '\v\:\=\ *$') 
    return IncrementIndent(pNum)
  endif
  if (pLine =~ '\<type\>' && pLine =~ '\v\=\ *$')
    return IncrementIndent(pNum)
  endif
  if (pLine =~ '\<else\>' && pLine =~ '\Velse\ \*\$')
    return IncrementIndent(pNum)
  endif

  while pNum > 0 
    for i in keys(synCount)
      let iStr = "\\\<" . i . "\\\>"
      if pLine =~ iStr
        let synCount[i] = synCount[i] + 1
      endif
    endfor

    if (synCount['then'] > synCount['else']) || (synCount['if'] > synCount['then'])
      return IncrementIndent(pNum)
    endif

    if (synCount['in'] > synCount['end']) || (synCount['let'] > synCount['in'])
      return IncrementIndent(pNum)
    endif

    if pNum == 1
      let pNum = 0
    else
      let pNum  = prevnonblank(pNum - 1)
      let pLine = getline(pNum)
    endif

  endwhile

  return 0

endfunction
