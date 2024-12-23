local cmp = require("cmp")

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
  }),
  snippet = {
    expand = function(args)
      vim.snippet.expand(args.body)
    end,
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "nvim_lsp_signature_help" },
  },
})
