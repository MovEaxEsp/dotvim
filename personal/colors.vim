if g:doingPlugs

" Plugins
Plug 'jnurmine/Zenburn'
Plug 'junegunn/rainbow_parentheses.vim'

finish
endif

" Configuration
colorscheme zenburn

highlight OverLength guibg=#592929
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59

" The default color for removed lines makes them almost invisible on zenburn
highlight diffRemoved guifg=#b20e0e

" Activate Rainbow parentheses
call rainbow_parentheses#activate()
let g:rainbow#max_level = 16
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]

