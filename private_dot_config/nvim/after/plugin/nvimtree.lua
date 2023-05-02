require("nvim-tree").setup({
  actions = {
    open_file = {
      quit_on_open = true
    }
  }
})

vim.keymap.set('n', '<C-t>', '<cmd>NvimTreeOpen<CR>')
