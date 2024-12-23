-- Diagnostics
vim.diagnostic.config({
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.HINT] = "",
      [vim.diagnostic.severity.INFO] = "",
    },
  },
  virtual_text = false,
})

-- Editing
vim.opt.backspace = ""
vim.opt.expandtab = true
vim.opt.mouse = ""
vim.opt.shiftwidth = 4

-- Visual
vim.opt.cursorline = true
vim.opt.list = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.showmode = false
vim.opt.signcolumn = "yes"

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
