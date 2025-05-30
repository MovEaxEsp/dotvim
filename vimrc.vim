" ********************** VIMRC ************************************************
let &runtimepath.=',$HOME/.vim'
if has("win32") || has("win64")
    set runtimepath+=$VIM/vimfiles
    set runtimepath+=$VIMRUNTIME
    set runtimepath+=$VIM/vimfiles/after
    set runtimepath+=$HOME/.vim/after
endif

let inVscode = exists('g:vscode')

set nocompatible
autocmd!
filetype off

" Plugins
call plug#begin('~/.vim/plugs')

let g:doingPlugs=1
for i in [0, 1]
    if i == 0
        " Load plugins not loaded by sub-files
        Plug 'tommcdo/vim-exchange'
        Plug 'vim-scripts/matchit.zip'
        Plug 'tomtom/tlib_vim'
        Plug 'junegunn/vim-easy-align'
        Plug 'github/copilot.vim'

        if inVscode
            Plug 'asvetliakov/vim-easymotion', { 'as': 'vscodevim-easymotion' }
        else
            if has("nvim")
                Plug 'nvim-treesitter/nvim-treesitter'
                Plug 'nvim-lua/plenary.nvim'
                Plug 'folke/which-key.nvim'
            endif
            Plug 'Lokaltog/vim-easymotion'
            Plug 'ervandew/sgmlendtag'
            Plug 'itchyny/lightline.vim'
            Plug 'godlygeek/tabular'
            Plug 'mbbill/undotree'
        endif
    else
        call plug#end()
        let g:doingPlugs=0
    endif

    " Source sub-files.  These can also load their own plugins
    source ~/.vim/personal/alternateFile.vim
    source ~/.vim/personal/colors.vim
    source ~/.vim/personal/snippets.vim
    source ~/.vim/personal/bde.vim
    source ~/.vim/personal/fuzzyfind.vim
    source ~/.vim/personal/git.vim
    source ~/.vim/personal/gui.vim
    source ~/.vim/personal/tabs.vim
    source ~/.vim/personal/spell.vim
    if has("nvim")
        source ~/.vim/personal/lsp.vim
        source ~/.vim/personal/completion.vim
        source ~/.vim/personal/gdb.vim
        source ~/.vim/personal/orgmode.vim
    endif
endfor

if !has("gui_running") && !has("nvim")
    set term=dtterm
endif

" For building
map <Left> :cp<CR>zz
map <Right> :cn<CR>zz
map <Up> :cc<CR>
map <Down> :make<CR>

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
set modeline
set number
set relativenumber
set textwidth=78
set numberwidth=6 " Width of 'number'/'relativenumber' section
set scrolloff=20 " Keep lines above and below cursor when possible
set hidden
set confirm
set signcolumn=yes
set colorcolumn=80

" Copilot
let g:copilot_proxy = "http://proxy.bloomberg.com:81"
let g:copilot_proxy_strict_ssl = v:false

if has("gui_running")
    if exists("g:neovide")
lua << EOF
_G.updateFont = function()
    if vim.g.neovide_scale_factor == 1.0 then
        vim.g.neovide_scale_factor = 2.0
    elseif vim.g.neovide_scale_factor == 2.0 then
        vim.g.neovide_scale_factor = 0.7
    else
        vim.g.neovide_scale_factor = 1.0
    end
end

EOF

        map <silent><leader>F :lua updateFont()<CR>
        let g:neovide_scroll_animation_length=0

    else
        if has("win32") || has("win64") || has("gui_macvim")
            let g:smallFont = "Consolas:h11"
            let g:bigFont = "Consolas:h24"
            set guifont=Consolas:h11
        elseif has("x11")
            let g:smallFont = "Consolas\\ 13"
            let g:bigFont = "Consolas\\ 24"
            set guifont=Consolas\ 13
        endif

        map <silent><Leader>F :if &guifont=~g:bigFont<Bar>call SetOptionString("guifont", g:smallFont)<Bar>else<Bar>call SetOptionString("guifont", g:bigFont)<Bar>endif<CR>
    endif
endif

" Init which-key
if has("nvim")
lua << EOF

require("which-key").setup {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
}
EOF
endif

" Terminal configuration
if has("nvim")

    function NewTerminalFn(bufName, ...)
      $tabnew
      let termCmd = get(a:, 1, "")
      if termCmd != ""
        exec "term " .termCmd
      else
        term
      endif

      exec "file {" . a:bufName . "}"
    endfunction

    command -nargs=1 NewTerminal :call NewTerminalFn("<args>")

    " Create terminal
    map <leader>xc :NewTerminal 

    " Rename terminal
    command -nargs=1 RenameTerminal exec "file {<args>}"
    map <leader>xr :RenameTerminal 

    " Maximum scrollback size
    set scrollback=10000

    tmap <leader><Esc> <C-\><C-n>

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

    " https://github.com/vim/vim/issues/6040
    tmap <S-Space> <Space>

    au TermOpen * setlocal nolist signcolumn=no nonumber
    au TermEnter * call clearmatches()

    " for tmux
    tmap <leader>b <C-b>
endif

" Undotree Settings
nnoremap <F5> :UndotreeToggle<CR>

" vim-easy-align Settings
vmap a= :EasyAlign =<CR>

" vim-easymotion settings
map <leader>f <Plug>(easymotion-s)
map <leader>w <Plug>(easymotion-bd-w)
map // <Plug>(easymotion-sn)

"**** BINDINGS
let mapleader = "\\"
let maplocalleader = "\\"

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
imap <S-Tab> <BS>

" For navigating splits
map <C-Right> <C-w>l
map <C-Left> <C-w>h
map <C-Down> <C-w>j
map <C-Up> <C-w>k

" Toggle displaying menu bar
map <silent><Leader>m :if &guioptions=~'m'<Bar>set guioptions-=m<Bar>else<Bar>set guioptions+=m<Bar>endif<CR>

" Toggle spell checking
map <silent><Leader>s :if &spell<Bar>set nospell<Bar>else<Bar>set spell<Bar>endif<CR>

" Expand line templates
"call template#AddPath($HOME . "/.vim/templates")
"map <silent> <leader>x :Template<CR>

" Select pasted text
nmap gV `[V`]

" Set width of window
"map <leader>c :set columns=86<CR>

" Align on =
map <leader>a :Tabularize /=.*[;,]<CR>

"**** AUTOCMDS
if !inVscode
    " Highlight trailing whitespace
    highlight ExtraWhitespace ctermbg=red guibg=red
    match ExtraWhitespace /\s\+$/
    autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
    autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
    autocmd InsertLeave * match ExtraWhitespace /\s\+$/
    autocmd BufWinLeave * call clearmatches()
endif

autocmd FileType xml setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType xsd setlocal shiftwidth=2 tabstop=2 softtabstop=2

autocmd BufNewFile,BufRead *.md  set filetype=markdown
autocmd BufNewFile,BufRead *.bml set filetype=xml

