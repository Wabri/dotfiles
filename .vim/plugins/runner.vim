function! RunScript() abort
    let l:Interpreters = {'py': 'python', 'sh': 'bash'}
    let l:TermBufNr = 0
    let l:TerminalOpen = 0
    " get file extension
    let l:FileExt  = expand('%:e')
    " get file path
    let l:FilePath = expand('%:p')
    " get list of windows
    let l:WinList = getwininfo()
    " find terminal window
    for w in l:WinList
        if w["terminal"]
           let l:TermBufNr = w["bufnr"]
           let l:TerminalOpen = 1
           break
        endif
    endfor
    if l:TerminalOpen == 0
        " if not open create one
        vertical terminal
        " back to win
        wincmd p
        let l:WinList = getwininfo()
        for w in l:WinList
            if w["terminal"]
                let l:TermBufNr = w["bufnr"]
                break
            endif
        endfor
    endif
    " run script
    call term_sendkeys(l:TermBufNr, l:Interpreters[l:FileExt] .. " " .. l:FilePath .."\n")
endfunction
