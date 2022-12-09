if g:doingPlugs

" Plugins
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

finish
endif

" Configuration

" Open files in new tabs
function! MYFZF(dir, findArg)
    let srcStr = 'find ' . a:findArg . ' -type f | grep -v "cmake.bld\|.ccls-cache\|.git"'
    echo srcStr
    call fzf#run(fzf#wrap({
            \ 'source': srcStr,
            \ 'sink': 'tabedit',
            \ 'dir': a:dir,
            \ 'options': '-e'}))
endfunction

nnoremap <C-p> :call MYFZF('~/dev/repoLinks', '*/')<CR>
nnoremap <leader><C-p> :call MYFZF('.', ' ')<CR>

let g:fzf_action = {
  \ 'ctrl-e': 'split' }

" Defunct ctrlp configuration
"if g:doingPlugs

" Plugins
"Plug 'FelikZ/ctrlp-py-matcher'
"Plug 'ctrlpvim/ctrlp.vim'
"finish
"endif

" Configuration
"let g:ctrlp_max_height = 30
"let g:ctrlp_max_files = 0
"let g:ctrlp_by_filename = 0
"let g:ctrlp_open_new_file = 't'
"let g:ctrlp_working_path_mode = 'rw'
"let g:ctrlp_follow_symlinks = 1
"let g:ctrlp_clear_cache_on_exit = 0
"let g:ctrlp_prompt_mappings = {
"    \ 'AcceptSelection("e")': ['<c-cr>'],
"    \ 'AcceptSelection("t")': ['<cr>', '<c-t>'],
"    \ }
"let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }

" Mappings
"nnoremap <leader><C-P> :CtrlP<CR>
"nnoremap <leader>b :CtrlPBuffer<CR>
