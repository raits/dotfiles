return {
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { 
			"nvim-lua/plenary.nvim", 
			"neovim/nvim-lspconfig", 
			"saghen/blink.cmp",
			"vue-typescript-plugin-installer",
		},
		opts = function()
			return {
				filetypes = {
					"javascript",
					"typescript",
					"vue",
				},
				settings = {
					capabilities = require('blink.cmp').get_lsp_capabilities(capabilities),
					single_file_support = false,
					tsserver_plugins = {
						"@vue/typescript-plugin",
					},
				},
			}
		end,
	},
}
