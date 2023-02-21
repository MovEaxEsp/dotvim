if g:doingPlugs

" Plugins
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

if has("nvim")
    Plug 'nvim-telescope/telescope.nvim'
endif

finish
endif

" Configuration

map <Leader>e :edit 

" Open files in new tabs
if has("nvim")

lua << EOF

require("telescope").setup{
    pickers = {
        buffers = {
          sort_mru = true,
          ignore_current_buffer = true,
          mappings = {
            i = {
              ["<c-d>"] = "delete_buffer",
              ["<tab>"] = "move_selection_previous",
              ["<s-tab>"] = "move_selection_next",
            }
          }
        },
        find_files = {
            follow = true
        }
    }
}

EOF

map <C-p> :lua require("telescope.builtin").find_files({follow=true, cwd=vim.g.codeLinksDir, search_dirs={vim.g.codeLinksDir}})<CR>
"map <C-p> :Telescope find_files<CR>

" Search from current dir
map <leader><C-p> :Telescope find_files cwd=.<CR>

map <Leader>b :Telescope buffers<CR>

map <Leader>g :Telescope live_grep<CR>

else
    " Non-nvim configuration
function! MYFZF(dir, findArg)
    let srcStr = 'find ' . a:findArg . ' -type f | grep -v "cmake.bld\|.ccls-cache\|.git"'
    echo srcStr
    call fzf#run(fzf#wrap({
            \ 'source': srcStr,
            \ 'sink': '$tabedit',
            \ 'dir': a:dir,
            \ 'options': '-e'}))
endfunction

nnoremap <C-p> :call MYFZF(g:codeLinksDir, '*/')<CR>
nnoremap <leader><C-p> :call MYFZF('.', ' ')<CR>

let g:fzf_action = {
  \ 'ctrl-e': 'split' }

map <Leader>b :b 

endif







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
