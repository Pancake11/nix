require("telescope").setup({
  defaults = {
    history = false,
  },
})

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<Leader>b", builtin.buffers, {})
vim.keymap.set("n", "<Leader>f", builtin.find_files, {})
vim.keymap.set("n", "<Leader>g", builtin.git_files, {})
vim.keymap.set("n", "<Leader>h", builtin.help_tags, {})
vim.keymap.set("n", "<Leader>s", builtin.live_grep, {})
