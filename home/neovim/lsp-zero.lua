local lsp = require('lsp-zero')

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})
end)

lsp.setup_servers({ 'ccls', 'pyright', 'cmake', 'tsserver', 'terraformls', 'vhdl_ls', 'rust_analyzer', 'arduino_language_server' })

require('lspconfig').tsserver.setup{}
require('lspconfig').vhdl_ls.setup{}
require('lspconfig').rust_analyzer.setup{}
require('lspconfig').arduino_language_server.setup{}

require'lspconfig'.terraformls.setup{}
vim.api.nvim_create_autocmd({"BufWritePre"}, {
  pattern = {"*.tf", "*.tfvars"},
  callback = function()
    vim.lsp.buf.format()
  end,
})
