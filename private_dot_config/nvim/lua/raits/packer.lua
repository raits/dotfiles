local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

vim.cmd.packadd('packer.nvim')

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use 'github/copilot.vim'
  use 'tpope/vim-sleuth'
  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    requires = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},
      {'williamboman/mason.nvim'},
      {'mfussenegger/nvim-jdtls'},
      {'williamboman/mason-lspconfig.nvim'},

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-path'},
      {'saadparwaiz1/cmp_luasnip'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-nvim-lua'},

      -- Snippets
      {'L3MON4D3/LuaSnip'},
      {'rafamadriz/friendly-snippets'},
    }
  }
  use('j-hui/fidget.nvim')

  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end
  }
  use('nvim-treesitter/nvim-treesitter-context');

  use('windwp/nvim-autopairs')

  use('vuki656/package-info.nvim')

  use('mbbill/undotree')

  use('tpope/vim-fugitive')
  
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.6',
    requires = {
      { "nvim-telescope/telescope-live-grep-args.nvim" },
      {'nvim-lua/plenary.nvim'} 
    },
    config = function()
      require("telescope").load_extension("live_grep_args")
    end
  }
  use('nvim-tree/nvim-tree.lua')

  use {'morhetz/gruvbox', config = function() vim.cmd.colorscheme('gruvbox') end }
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }

  if packer_bootstrap then
    require('packer').sync()
  end

end)
