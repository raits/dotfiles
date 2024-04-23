require('oil').setup()
vim.api.nvim_set_keymap('n', '<C-t>', "<cmd>lua require('oil').open_float('.')<CR>", { noremap = true, silent = true })
