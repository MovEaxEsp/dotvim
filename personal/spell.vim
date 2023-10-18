if g:doingPlugs

" Plugins
Plug 'kamykn/spelunker.vim'

finish
endif

" Configuration
set nospell

" Disable default autogroup. (default: 0)
let g:spelunker_disable_auto_group = 1

" Create own custom autogroup to enable spelunker.vim for specific filetypes.
augroup spelunker
  autocmd!
  " Setting for g:spelunker_check_type = 1:
  "autocmd BufWinEnter,BufWritePost *.vim,*.js,*.jsx,*.json,*.md,*.h,*.cpp call spelunker#check()

  " Setting for g:spelunker_check_type = 2:
  autocmd CursorHold *.vim,*.js,*.jsx,*.json,*.md,*.h,*.cpp call spelunker#check_displayed_words()
augroup END
