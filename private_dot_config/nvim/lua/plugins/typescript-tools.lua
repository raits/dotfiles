return {
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig", "hrsh7th/cmp-nvim-lsp" },
		-- opts = {},
		opts = function()
			return {
				filetypes = {
					"javascript",
					"typescript",
					"vue",
				},
				settings = {
					capabilities = require("cmp_nvim_lsp").default_capabilities(),
					-- Might be required for Deno projects
					-- root_dir = require("lspconfig").util.root_pattern_exclude({
					-- 	root = { "package.json" },
					-- 	exclude = { "deno.json", "deno.jsonc" },
					-- }),
					single_file_support = false,
					tsserver_plugins = {
						"@vue/typescript-plugin",
					},
				},
			}
		end,
	},
}
