if g:doingPlugs

" Plugins
Plug 'neovim/nvim-lspconfig'
Plug 'nvimdev/lspsaga.nvim'

finish

endif

" Configuration

lua << EOF

local custom_attach = function(client)
    print("LSP started.");

    --require'completion'.on_attach(client)

    --[[
    utils.map('n','gD','<cmd>lua vim.lsp.buf.declaration()<CR>')
    utils.map('n','gd','<cmd>lua vim.lsp.buf.definition()<CR>')
    utils.map('n','K','<cmd>lua vim.lsp.buf.hover()<CR>')
    utils.map('n','gr','<cmd>lua vim.lsp.buf.references()<CR>')
    utils.map('n','gs','<cmd>lua vim.lsp.buf.signature_help()<CR>')
    utils.map('n','gi','<cmd>lua vim.lsp.buf.implementation()<CR>')
    utils.map('n','gt','<cmd>lua vim.lsp.buf.type_definition()<CR>')
    utils.map('n','<leader>gw','<cmd>lua vim.lsp.buf.document_symbol()<CR>')
    utils.map('n','<leader>gW','<cmd>lua vim.lsp.buf.workspace_symbol()<CR>')
    utils.map('n','<leader>ah','<cmd>lua vim.lsp.buf.hover()<CR>')
    utils.map('n','<leader>ac','<cmd>lua vim.lsp.buf.code_action()<CR>')
    utils.map('n','<leader>ee','<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>')
    utils.map('n','<leader>ar','<cmd>lua vim.lsp.buf.rename()<CR>')
    utils.map('n','<leader>=', '<cmd>lua vim.lsp.buf.formatting()<CR>')
    utils.map('n','<leader>ai','<cmd>lua vim.lsp.buf.incoming_calls()<CR>')
    utils.map('n','<leader>ao','<cmd>lua vim.lsp.buf.outgoing_calls()<CR>')
    utils.map('n','[q',':cnext<CR>')
    utils.map('n',']q',':cprev<CR>')
    utils.map('n',']h',':ClangdSwitchSourceHeader<CR>')
    --]]
end

_G.swap_arrows = function()
    if _G.arrowMode == 1 then
        print("Switching arrows to lsp")
        _G.arrowMode = 2
        vim.api.nvim_set_keymap('n',
                                '<left>',
                                ':lua vim.diagnostic.goto_prev()<CR>', {})
        vim.api.nvim_set_keymap('n',
                                '<right>',
                                ':lua vim.diagnostic.goto_next()<CR>', {})
        vim.api.nvim_set_keymap('n',
                                '<up>',
                                ':lua vim.diagnostic.show()<CR>', {})
    else
        print("Switching arrows to quickfix")
        _G.arrowMode = 1
        vim.api.nvim_set_keymap('n', '<left>', ':cp<CR>zz', {})
        vim.api.nvim_set_keymap('n', '<right>', ':cn<CR>zz', {})
        vim.api.nvim_set_keymap('n', '<up>', ':cc<CR>', {})
        vim.api.nvim_set_keymap('n', '<down>', ':make<CR>', {})
    end
end
_G.arrowMode = 2
swap_arrows()

--[[
require'lspconfig'.clangd.setup({
 cmd={"/opt/bb/lib/llvm-14.0/bin/clangd", "--background-index"},
 on_attach=custom_attach
})
]]--

--print(os.execute("cd"))
--package.path = package.path .. ";/root/.vim/plugs/nvim-lspconfig/lua/lspconfig.lua"
local lspconfig = require'lspconfig'
lspconfig.ccls.setup {
  init_options = {
    cache = {
      directory = "/root/.ccls-cache";
    };
  }
}

lspconfig.pylsp.setup{
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          ignore = {'E122', 'E126', 'E127',
                    'E201', 'E202', 'E221', 'E226', 'E241', 'E251',
                    'E301', 'E302', 'E303',
                    'E402',
                    'W504'},
          maxLineLength = 79
        }
      }
    }
  }
}

require('lspsaga').setup({

})

EOF

if has("nvim")
    nnoremap <leader>aa :lua swap_arrows()<CR>

    nmap <leader>ld :lua vim.lsp.buf.declaration()<CR>
    nmap <leader>lD :lua vim.lsp.buf.definition()<CR>
    nmap <leader>lr :Telescope lsp_references<CR>
    nmap <leader>lp :Lspsaga peek_definition<CR>
endif
