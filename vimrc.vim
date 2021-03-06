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

" Plugins
call plug#begin('~/.vim/plugs')

Plug 'scrooloose/nerdtree'
Plug 'vim-scripts/a.vim'
Plug 'MovEaxEsp/bdeformat'
Plug 'FelikZ/ctrlp-py-matcher'
Plug 'ctrlpvim/ctrlp.vim'
"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"Plug 'tweekmonster/deoplete-clang2'
Plug 'Valloric/YouCompleteMe'
Plug 'Lokaltog/vim-easymotion'
Plug 'tommcdo/vim-exchange'
Plug 'tpope/vim-fugitive'
Plug 'vim-scripts/matchit.zip'
Plug 'ervandew/sgmlendtag'
Plug 'ervandew/supertab'
Plug 'tomtom/tlib_vim'
Plug 'SirVer/ultisnips'
Plug 'junegunn/vim-easy-align'
Plug 'jnurmine/Zenburn'
Plug 'itchyny/lightline.vim'
Plug 'godlygeek/tabular'
Plug 'mbbill/undotree'
Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh \| UpdateRemotePlugins' }

call plug#end()

if !has("gui_running") && !has("nvim")
    set term=dtterm
endif

" YCM
map Yg :YcmCompleter GoTo<CR>
map Yf :YcmCompleter FixIt<CR>
map Yt :YcmCompleter GetType<CR>

set guioptions-=m "No menu bar
set guioptions-=T "No toolbar

filetype plugin indent on

set t_md=
syntax on
set mouse=a

if !has("nvim")
    set ttymouse=xterm
endif

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
set hidden
set confirm
set signcolumn=yes
set showtabline=2 "Always show tab line, even with only one tab
set colorcolumn=80

"Show if modified, buffer number, and filename
set guitablabel=%M\ %n\ %t

"Show full path
set guitabtooltip=%F

"Completion options
set wildignore+=*.o,*.tsk,*.d,*.dd,*.depends,*plink_timestamp.*,tmp,*.log.*
set wildignore+=*.linux,*.ibm,*.sundev1,*.linux.64,*.ibm.64,*.sundev1.64
set wildignore+=*.hp,*.lastlink,*.edited,*.mapfile,cmake.bld,buildDir,overlays
set wildignore+=*.obj
set wildmode=longest,list,full

if has("gui_running")
    set background=dark
    set list "Show hidden characters (controlled by listchars)
    set listchars=eol:�,tab:>\ 
    colorscheme zenburn

    if has("win32") || has("win64") || has("gui_macvim")
        let g:smallFont = "Consolas:h11"
        let g:bigFont = "Consolas:h24"
        set guifont=Consolas:h11
    elseif has("x11")
        let g:smallFont = "Consolas\\ 13"
        let g:bigFont = "Consolas\\ 24"
        set guifont=Consolas\ 13
    endif

    " Make the window 80 columns wide and as tall as possible
    " 86 = 80 + numberwidth
    set columns=86
    set lines=999

elseif has("nvim")
    colorscheme zenburn
else
    colorscheme ron
endif

" Terminal configuration
if has("nvim")
    tnoremap <C-\><C-\> <C-\><C-n>

    tnoremap <A-Left>  <C-\><C-N><C-w>h
    inoremap <A-Left>  <C-\><C-N><C-w>h
    nnoremap <A-Left>  <C-\><C-N><C-w>h
    tnoremap <A-Down>  <C-\><C-N><C-w>j
    inoremap <A-Down>  <C-\><C-N><C-w>j
    nnoremap <A-Down>  <C-\><C-N><C-w>j
    tnoremap <A-Up>    <C-\><C-N><C-w>k
    inoremap <A-Up>    <C-\><C-N><C-w>k
    nnoremap <A-Up>    <C-\><C-N><C-w>k
    tnoremap <A-Right> <C-\><C-N><C-w>l
    inoremap <A-Right> <C-\><C-N><C-w>l
    nnoremap <A-Right> <C-\><C-N><C-w>l

	au TermOpen * setlocal list signcolumn=no nonumber
endif

highlight OverLength guibg=#592929
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59

" For finding BDE files in 'groups' directories in the path
set includeexpr=BDEFilePath(v:fname)

" CtrlP Settings
let g:ctrlp_max_height = 30
let g:ctrlp_max_files = 0
let g:ctrlp_by_filename = 0
let g:ctrlp_open_new_file = 't'
let g:ctrlp_working_path_mode = 'rw'
let g:ctrlp_follow_symlinks = 1
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<c-cr>'],
    \ 'AcceptSelection("t")': ['<cr>', '<c-t>'],
    \ }
let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
nnoremap <leader><C-P> :CtrlP<CR>
nnoremap <leader>b :CtrlPBuffer<CR>

" Undotree Settings
nnoremap <F5> :UndotreeToggle<CR>

" UltiSnips Settings
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-l>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" nvim-gdb
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

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'


" vim-easy-align Settings
vmap a= :EasyAlign =<CR>

" vim-easymotion settings
map <leader>f <Plug>(easymotion-s)
map <leader>w <Plug>(easymotion-w)
map / <Plug>(easymotion-sn)
nnoremap // /

"**** BINDINGS
let mapleader = "\\"
let maplocalleader = "\\"

" Next/Prev tab
map <TAB> gt
map <S-TAB> gT

"Opening files
map <Leader>t :tabedit 
map <Leader>e :edit 

" Open corresponding .h/.cpp in same window
map <silent> <Leader><TAB> :A<CR>

" So we'll get a .cpp instead of a .c when we use the above mapping before the
" .cpp exists.
let g:alternateExtensions_h = "cpp,c,cxx,cc,CC"
let g:alternateExtensions_H = "CPP,C,CXX,CC"
let g:alternateExtensions_js = "bml"
let g:alternateExtensions_bml = "js"

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

" Set width of window
"map <leader>c :set columns=86<CR>

" Align on =
map <leader>a :Tabularize /=.*[;,]<CR>

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

autocmd FileType xml setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType xsd setlocal shiftwidth=2 tabstop=2 softtabstop=2

autocmd BufNewFile,BufRead *.md  set filetype=markdown
autocmd BufNewFile,BufRead *.bml set filetype=xml

