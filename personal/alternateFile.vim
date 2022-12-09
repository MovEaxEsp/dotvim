if g:doingPlugs

" Plugins
Plug 'vim-scripts/a.vim'

finish
endif

" Configuration

" Open corresponding .h/.cpp in same window
map <silent> <Leader><TAB> :A<CR>

" So we'll get a .cpp instead of a .c when we use the above mapping before the
" .cpp exists.
let g:alternateExtensions_h = "cpp,c,cxx,cc,CC"
let g:alternateExtensions_H = "CPP,C,CXX,CC"
let g:alternateExtensions_js = "bml"
let g:alternateExtensions_bml = "js"
