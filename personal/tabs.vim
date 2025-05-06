if g:doingPlugs

" Plugins
Plug 'gcmt/taboo.vim'
Plug 'kien/tabman.vim'

finish
endif

" Configuration
set showtabline=2 "Always show tab line, even with only one tab

if !has("nvim")
    "Show if modified, buffer number, and filename
    set guitablabel=%M\ %n\ %t
endif

" Next/Prev tab
map <silent> <TAB> :tabn<CR>

" To allow us to move forward in the jump list (Since C-I == TAB)
noremap <C-S-o> <C-I>
map <silent> <S-TAB> :tabp<CR>

"Opening files
map <Leader>te :$tabedit 
map <silent> <leader>T :$tabedit <cfile><CR>

" For moving tabs
map <silent><C-H> :call MoveTab(-1)<CR>
map <silent><C-L> :call MoveTab(1)<CR>

