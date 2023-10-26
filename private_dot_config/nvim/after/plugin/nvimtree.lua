require("nvim-tree").setup({
  actions = {
    open_file = {
      quit_on_open = true
    }
  },
  view = { 
    adaptive_size = true
  }
})

vim.keymap.set('n', '<C-t>', '<cmd>NvimTreeOpen<CR>')
