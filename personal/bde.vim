if g:doingPlugs

" Plugins
Plug 'MovEaxEsp/bdeformat'

finish
endif

" Configuration
vmap <silent> <Leader>r :call BlockRightAlignRange(79)<CR>gv
map <silent> <Leader>p :BDEFormat<CR>

