if g:doingPlugs

" Plugins
Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh \| UpdateRemotePlugins' }

finish

endif

" Configuration
function! SetGdbMappings()
    " Set up mapping for the 'nvimgdb' code window
    call GdbCallAsync("keymaps.set")

    map <buffer> <localleader>c :GdbContinue<CR>
    map <buffer> <localleader>s :GdbBreakpointToggle<CR>
    map <buffer> <localleader>e :GdbEvalWord<CR>
    map <buffer> <localleader>r :GdbRun<CR>
    map <buffer> <UP> :GdbFrameUp<CR>
    map <buffer> <C-UP> :GdbFinish<CR>
    map <buffer> <DOWN> :GdbFrameDown<CR>
    map <buffer> <C-DOWN> :GdbUntil<CR>
    map <buffer> <RIGHT> :GdbNext<CR>
    map <buffer> <C-RIGHT> :GdbStep<CR>
endfunction

function! UnsetGdbMappings()
    " Clear the buffer-local GDB mappings
    call GdbCallAsync("keymaps.unset")

    unmap <buffer> <localleader>c
    unmap <buffer> <localleader>s
    unmap <buffer> <localleader>e
    unmap <buffer> <localleader>r
    unmap <buffer> <UP>
    unmap <buffer> <C-UP>
    unmap <buffer> <DOWN>
    unmap <buffer> <C-DOWN>
    unmap <buffer> <RIGHT>
    unmap <buffer> <C-RIGHT>
endfunction

let g:nvimgdb_config_override = {
    \ 'key_frameup': '',
    \ 'key_framedown': '',
    \ 'set_keymaps': 'SetGdbMappings',
    \ 'unset_keymaps': 'UnsetGdbMappings'
\ }

map <leader>g :call SetGdbMappings()<CR>
