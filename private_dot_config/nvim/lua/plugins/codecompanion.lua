return {
	"olimorris/codecompanion.nvim",
	config = true,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"j-hui/fidget.nvim",
	},
	-- Initialize the code companion fidget
	init = function()
		require("utilities.codecompanion-fidget"):init()
	end,
	-- Key mappings for Code Companion plugin
	keys = {
		{ "<leader>ac", "<cmd>CodeCompanionChat<CR>", desc = "Code Companion Chat" },
		{ "<leader>aa", "<cmd>CodeCompanionActions<CR>", mode = { "n", "v" }, desc = " Code Companion Actions" },
		{ "<leader>ap", "<cmd>CodeCompanion<CR>", mode = { "n", "v" }, desc = " Code Companion Prompt" },
	},
}
