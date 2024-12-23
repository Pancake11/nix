require("conform").setup({
  formatters_by_ft = {
    c = { "clang_format" },
    cpp = { "clang_format" },
    css = { "prettier" },
    cuda = { "clang_format" },
    javascript = { "prettier" },
    json = { "prettier" },
    lua = { "stylua" },
    markdown = { "prettier" },
    nix = { "nixpkgs_fmt" },
    ocaml = { "ocamlformat" },
    python = { "ruff", "black" },
    rust = { "rustfmt" },
    typescript = { "prettier" },
    yaml = { "prettier" },
  },

  format_on_save = function(bufnr)
    if vim.g.conform_disable then
      return
    end
    return {
      -- These options will be passed to conform.format()
      timeout_ms = 500,
      lsp_fallback = true,
    }
  end,
})

vim.api.nvim_create_user_command("ConformToggle", function(args)
  vim.g.conform_disable = not vim.g.conform_disable
  vim.api.nvim_echo({ { "Format on save " }, { vim.g.conform_disable and "disabled" or "enabled" } }, false, {})
end, { desc = "Toggle format on save" })
