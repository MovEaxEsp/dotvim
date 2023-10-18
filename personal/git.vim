if g:doingPlugs

" Plugins
Plug 'tpope/vim-fugitive'

if has("nvim")
    Plug 'lewis6991/gitsigns.nvim'
    Plug 'ldelossa/litee.nvim'
    Plug 'ldelossa/gh.nvim'
else
    Plug 'airblade/vim-gitgutter'
endif

finish
endif

" Configuration
if has("nvim")

lua << EOF

require('gitsigns').setup {
    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        map({'n', 'v'}, '<leader>gs', ':Gitsigns stage_hunk<CR>')
        map({'n', 'v'}, '<leader>gr', ':Gitsigns reset_hunk<CR>')
        map('n',        '<leader>gl', ':Gitsigns preview_hunk_inline<CR>')
        map('n',        '<leader>gu', gs.undo_stage_hunk)
        map('n',        '<leader>gn', gs.next_hunk)
        map('n',        '<leader>gb', gs.toggle_current_line_blame)

    end
}

require('litee.lib').setup()
require('litee.gh').setup({
})

EOF

endif
