require("nvim-tree").setup({
  sync_root_with_cwd = true,
  view = {
    side = "right",
    number = true,
    relativenumber = true,
  },
  renderer = {
    indent_markers = {
      enable = true,
    },
    icons = {
      glyphs = {
        git = {
          untracked = "",
        },
      },
    },
  },
  actions = {
    open_file = {
      resize_window = false,
    },
  },
  tab = {
    sync = {
      open = true,
      close = true,
    },
  },
})

local api = require("nvim-tree.api")
vim.keymap.set("n", "<Leader>t", api.tree.toggle, {})
