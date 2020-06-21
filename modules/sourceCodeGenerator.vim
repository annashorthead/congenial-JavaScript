" Routines required by text rendering functions
function! AddToDoc(dataToAdd) abort
  execute 'normal i'.a:dataToAdd
endfunction

function! IsTest(args) abort
  if a:args > 0
    return v:true
  else
    return v:false
  endif
endfunction

" check suggestion spelling, and make suggestions with input method instead of
" functions
function! Suggest(msg) abort
  echo 'Suggestion: '.a:msg
endfunction

function! GenerateVariableWithScope(...) abort
  if IsTest(a:0)
    let scopeSelection = a:1 " 1 | 2 | 3
    let varName = a:2 " health | lvl | money | etc
    let varValue = a:3 " 1 | 2 | true | 'hell world' | etc
  else
    let scopeSelection = input('var/let/const Pick 1/2/3: ')
    let varName = input('Name of Variable: ')
    let varValue = input('Value of Variable: ')
  endif
  let scopeOptions = ['var', 'let', 'const']
  let scopeSelected = scopeOptions[scopeSelection-1]
  call AddToDoc(scopeSelected.' '.varName.' = '.varValue.';')
endfunction

function! GenerateLabel(...) abort
"  if a:0 > 0
  if IsTest(a:0)
    let labelName = a:1
  else
    let labelName = input('Name of Label: ')
  endif
  call AddToDoc(labelName.':{}')
endfunction

function! LoopOverRange(...) abort
  if IsTest(a:0)
    let initialCounterValue = a:1
    let counterLimitCompatative = a:2
    let counterIterationValue = a:3
  else
    let initialCounterValue = input('Initial Counter Value: ')
    let counterLimitCompatative = input('Comparative (<10)/(>5)/(==20): ')
    let counterIterationValue = input('Counter Iteration Value (++/+2/-3): ') 
  endif
  call AddToDoc('for (let i='.initialCounterValue.'; i'.counterLimitCompatative.'; i'.counterIterationValue.'){}')
endfunction

function! LoopOverMembers(...) abort
  if IsTest(a:0)
    call AddToDoc('for (let m of '.a:1.'){}')
  else
    call Suggest('Give the name of an already declared array, for example: myList | myArray | myArr')
    let arrayToIterateOver = input('Array to Iterate Over: ')
    call AddToDoc('for (let m of '.arrayToIterateOver.'){}')
  endif
endfunction

function! LoopOverIndices(...) abort
  if IsTest(a:0)
    call AddToDoc('for (let i in '.a:1.'){}')
  else
    call Suggest('Give the name of an already declared array, for example: myList | myArray | myArr')
    let arrayToIterateOver = input('Array to Iterate Over: ')
    call AddToDoc('for (let i in '.arrayToIterateOver.'){}')
  endif
endfunction

function! GenerateForLoop(...) abort
  if IsTest(a:0)
    let loopTypeSelectionIndex = a:1
  else
    let loopTypeSelectionIndex = input('Loop over Range/Members/Indices Pick 1/2/3: ')
  endif
  let loopTypesShelf = [ 'loopOverRange', 'loopOverMembers', 'loopOverIndices' ]
  let loopSelection = loopTypesShelf[loopTypeSelectionIndex-1]
  if IsTest(a:0)
    "---------------------------------------------------
    if loopSelection == loopTypesShelf[0] "for
      call LoopOverRange(0, "<10", "++")
    elseif loopSelection == loopTypesShelf[1] "forOf
      call LoopOverMembers("myLoop")
    elseif loopSelection == loopTypesShelf[2] "forIn
      call LoopOverIndices("myLoop")
    endif
    "---------------------------------------------------
  else
    "---------------------------------------------------
    if loopSelection == loopTypesShelf[0] "for
      call LoopOverRange()
    elseif loopSelection == loopTypesShelf[1] "forOf
      call LoopOverMembers()
    elseif loopSelection == loopTypesShelf[2] "forIn
      call LoopOverIndices()
    endif
    "---------------------------------------------------
  endif
endfunction

function! GenerateArray() abort
  let arrayName = input('Name of Array: ')
  let numberOfMembersInArray = input('Number of Members in Array: ')
  call AddToDoc('let '.arrayName.' = [ ')

  let i = 0
  while i < numberOfMembersInArray
    let valueOfNthMember = input('Value of '.i.'th member: ')
    call AddToDoc(valueOfNthMember." ")
    if i < numberOfMembersInArray-1
      call AddToDoc(', ')
    endif
    let i = i+1
  endwhile

    call AddToDoc('];')
endfunction

function! GenerateLog() abort
  let valueToLog = input('Value to log: ')
  call AddToDoc('console.log('.valueToLog.');')
endfunction

function! GenerateTimer() abort
  let intervalName = input('IntervalName: ')
  let intervalLength = input('interval length in ms: ')
  call AddToDoc('const '.intervalName.' = setInterval(function(){/*code-here*/},'.intervalLength.');')
endfunction

function! SplitArray() abort
  call Suggest('Name an array you have already declared')
  let arrayName = input('Array Name: ')
  let splitByCharacter = input('Split by character: ')
  call AddToDoc(arrayName.'.split("'.splitByCharacter.'")')
endfunction

function! MapArray() abort
  call Suggest('Name an array you have already declared')
  call Suggest('console.log("This is an " + element)')
  let arrayName = input('Array Name: ')
  let expressionToExecute = input('Expression to execute per iteration: ')
  call AddToDoc(arrayName.'.map(element => '.expressionToExecute.');')
endfunction

" add more from simply es6


" End of routine list
" " Break suggestion into echo on preceding line
" " Make all featurs monolithic
