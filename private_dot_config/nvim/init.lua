-- Don't use default netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
--
-- Leader to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.have_nerd_font = true

require("options")

require("keymaps")

require("lazy-bootstrap")

require("lazy-plugins")
