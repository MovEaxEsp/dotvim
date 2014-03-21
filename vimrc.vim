" ********************** VIMRC ************************************************
if has("win32") || has("win64")
    set runtimepath=$HOME/.vim
    set runtimepath+=$VIM/vimfiles
    set runtimepath+=$VIMRUNTIME
    set runtimepath+=$VIM/vimfiles/after
    set runtimepath+=$HOME/.vim/after
endif

set nocompatible
autocmd!
filetype off

call pathogen#infect()
call pathogen#helptags()

if !has("gui_running")
    set term=dtterm
endif

set guioptions-=m "No menu bar
set guioptions-=T "No toolbar

filetype plugin indent on

set t_md=
syntax on
set mouse=a
set ttymouse=xterm

set vb
set t_vb=

set splitright
set expandtab
set ignorecase
set autoindent
set smartindent
set cindent
set ruler
set backspace=indent,eol,start
set backupcopy=yes " So vim doesn't change permissions of files
set shiftwidth=4
set tabstop=4
set softtabstop=4
set incsearch
set hlsearch
set number
set relativenumber
set textwidth=78
set numberwidth=6 " Width of 'number'/'relativenumber' section
set scrolloff=20 " Keep lines above and below cursor when possible
set list "Show hidden characters (controlled by listchars)
set hidden "Allow switching away from buffers with unsaved changes
set showtabline=2 "Always show tab line, even with only one tab
set listchars=eol:�,tab:>\ 
set colorcolumn=80

"Show if modified, buffer number, and filename
set guitablabel=%M\ %n\ %t

"Show full path
set guitabtooltip=%F

"Completion options
set wildignore+=*.o,*.tsk,*.d,*.dd,*.depends,*.linux,*.ibm,*.sundev1
set wildignore+=*.hp,*.lastlink,*.edited,*.mapfile
set wildmode=longest,list,full

if has("gui_running")
    set background=dark
    colorscheme zenburn

    if has("win32") || has("win64")
        let g:smallFont = "Consolas:h11"
        let g:bigFont = "Consolas:h24"
        set guifont=Consolas:h11
    elseif has("x11")
        let g:smallFont = "Bitstream\\ Vera\\ Sans\\ Mono\\ 11"
        let g:bigFont = "Bitstream\\ Vera\\ Sans\\ Mono\\ 24"
        set guifont=Bitstream\ Vera\ Sans\ Mono\ 11
    endif

    " Make the window 80 columns wide and as tall as possible
    " 86 = 80 + numberwidth
    set columns=86
    set lines=999

else
    colorscheme zenburn
endif

highlight OverLength guibg=#592929
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59

" For finding BDE files in 'groups' directories in the path
set includeexpr=BDEFilePath(v:fname)

" CtrlP Settings
"let g:ctrlp_map = ''
let g:ctrlp_cmd = 'CtrlP ~/codelinks/own'
let g:ctrlp_max_height = 30
let g:ctrlp_by_filename = 0
let g:ctrlp_open_new_file = 't'
let g:ctrlp_working_path_mode = '0'
let g:ctrlp_follow_symlinks = 1
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_cache_dir = '/tmp/ctrlpcache'
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<c-cr>'],
    \ 'AcceptSelection("t")': ['<cr>', '<c-t>'],
    \ }
nnoremap <leader><C-P> :CtrlP ~/codelinks/bde<CR>

" Gundo settings
nnoremap <F5> :GundoToggle<CR>
let g:gundo_preview_height=30
let g:gundo_preview_bottom=1

" Gundo Settings
nnoremap <F5> :GundoToggle<CR>
let g:gundo_preview_height = 40
let g:gundo_preview_bottom = 1

"**** BINDINGS
let mapleader = "\\"

" Next/Prev tab
map <TAB> gt
map <S-TAB> gT

"Opening files
map <Leader>t :tabedit 
map <Leader>e :edit 
map <Leader>b :tab sb 

" BDEFile is defined  later
map <Leader>f :BDEFile 

" Open corresponding .h/.cpp in same window
map <silent> <Leader><TAB> :A<CR>

" So we'll get a .cpp instead of a .c when we use the above mapping before the
" .cpp exists.
let g:alternateExtensions_h = "cpp,c,cxx,cc,CC"
let g:alternateExtensions_H = "CPP,C,CXX,CC"

" Run the last Ex command again
map <C-Return> :<Up><CR>

" Right align line (for BDE)
map <silent> <Leader>r :ri 79<CR>

" Clear highlighting
map <silent> <leader>/ :let @/=""<CR>

map <Leader>v :tabedit $MYVIMRC<CR>
map <Leader>V :source $MYVIMRC<CR>

imap <C-BS> <C-w>
imap <S-Del> <Del>

" For building
map <Left> :cp<CR>zz
map <Right> :cn<CR>zz
map <Up> :cc<CR>
map <Down> :make<CR>

" For navigating splits
map <C-Right> <C-w>l
map <C-Left> <C-w>h
map <C-Down> <C-w>j
map <C-Up> <C-w>k

" For moving tabs
map <silent><C-H> :call MoveTab(-1)<CR>
map <silent><C-L> :call MoveTab(1)<CR>

" Toggle displaying menu bar
map <silent><Leader>m :if &guioptions=~'m'<Bar>set guioptions-=m<Bar>else<Bar>set guioptions+=m<Bar>endif<CR>

" Toggle big/small font
map <silent><Leader>F :if &guifont=~g:bigFont<Bar>call SetOptionString("guifont", g:smallFont)<Bar>else<Bar>call SetOptionString("guifont", g:bigFont)<Bar>endif<CR>

" Toggle spell checking
map <silent><Leader>s :if &spell<Bar>set nospell<Bar>else<Bar>set spell<Bar>endif<CR>

" Expand line templates
call template#AddPath($HOME . "/.vim/templates")
map <silent> <leader>x :Template<CR>

" BDE aligning
vmap <silent> <Leader>r :call BlockRightAlignRange(79)<CR>gv
map <silent> <Leader>p :BDEFormat<CR>

" Select pasted text
nmap gV `[V`]

"**** AUTOCMDS
" Open the specified file (using BDE naming scheme) in new tab
command! -nargs=1 BDEFile :call TabBDEFile("<args>")

" Highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()