
vim.cmd.packadd('packer.nvim')

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
    'neoclide/coc.nvim', branch = 'release',
  }
  
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use {'morhetz/gruvbox', config = function() vim.cmd.colorscheme("gruvbox") end }
  use('tpope/vim-fugitive')
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }
  use('nvim-tree/nvim-tree.lua')
  use('mbbill/undotree')
  use('tpope/vim-fugitive')
  use('raimondi/delimitmate')
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,}
    use("nvim-treesitter/nvim-treesitter-context");
    use('vuki656/package-info.nvim')
  end)
