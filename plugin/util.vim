" Utility functions

"Set the value of the specified 'option' to the specified string 'value'
function! SetOptionString(option, value)
    let s = "set " . a:option . "=" . a:value
    exec s
endf

"Replace the lines in range (start, end) with the specified 'lines
function! ReplaceLines(start, end, lines)
    "Delete the lines first
    if a:start != a:end
        let cmd = string(a:start+1) . "," . string(a:end) . "d"
        exec cmd
    endif

    call setpos(".", [0, a:start, 0, 0])

    for i in range(1, len(a:lines) - 1)
        exec "normal o"
    endfor

    call setline(a:start, a:lines)
endf

" Indent all the specified 'strings' up to the specified 'column' and return
" the indented strings
function! SetIndentationStrings(strings, column)
    let prefix = repeat(' ', a:column)

    return map(a:strings, 'prefix . tlib#string#Strip(v:val)')
endf

" Right align the specified 'strings' so the longest has 'width' characters,
" and all the strings have the same amount of indentation.  Return the aligned
" strings
function! BlockRightAlignStrings(strings, width)
    let longestLength = 0
    let longestLine = 0
    for string in a:strings
        let stringLen = strlen(tlib#string#Strip(string))
        if stringLen > longestLength
            let longestLength = stringLen
            let longestLine = string
        endif
    endfor

    let prefixLength = (a:width - longestLength)
    return SetIndentationStrings(a:strings, prefixLength)
endf

" Right align a block of lines so their leftmost characters are in the same
" column
function! BlockRightAlign(first, last, width)
    let lines = BlockRightAlignStrings(getline(a:first, a:last), a:width)

    for lineNum in range(a:first, a:last)
        call setline(lineNum, lines[lineNum - a:first])
    endfor
endf

function! BlockRightAlignRange(width) range
    call BlockRightAlign(a:firstline, a:lastline, a:width)
endf

" Move the current tab page offset positions (positve right, negative left)
function! MoveTab(offset)
    let curTab = tabpagenr()

    let offset = 1
    if a:offset < 0
        let offset = -2
    endif

    let endPos = curTab + offset
    if endPos == -1
        return
    endif

    let cmd = "tabmove " . (curTab + offset)
    exec cmd
endf

" Build the BDE path to a component.  i.e. bdema_managedptr.h returns
" bde/bdema/bdema_managedptr.h
function! BDEFilePath(filename)
    let packageLength = stridx(a:filename, "_", 3)
    let package = strpart(a:filename, 0, packageLength)

    if strpart(package,0, 2) == "a_"
        " a_ are just packages with no package groups
        return package . "/" . a:filename
    endif

    if strpart(package,1,1) == "_"
        let group = strpart(a:filename, 0, 5)
    else
        let group = strpart(a:filename, 0, 3)
    endif

    return group . "/" . package . "/" . a:filename
endf

function! TabBDEFile(filename)
    let cmd = "tabfind " . BDEFilePath(a:filename)
    exec cmd
endf

