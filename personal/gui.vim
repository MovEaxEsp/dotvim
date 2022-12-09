if g:doingPlugs

" Plugins
" No plugins

finish
endif

" Gvim settings
set guioptions-=m "No menu bar
set guioptions-=T "No toolbar

"Show full path
set guitabtooltip=%F

if has("gui_running")
    " Make the window 80 columns wide and as tall as possible
    " 86 = 80 + numberwidth
    set columns=86
    set lines=999
endif

" Neovide settings
if exists("g:neovide")
    let g:neovide_cursor_vfx_mode="railgun"
endif

