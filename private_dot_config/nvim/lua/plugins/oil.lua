return {
	"stevearc/oil.nvim",
	opts = {},
	-- Optional dependencies
	dependencies = { "nvim-tree/nvim-web-devicons" },
	init = function()
		vim.api.nvim_set_keymap(
			"n",
			"<C-t>",
			"<cmd>lua require('oil').open_float('.')<CR>",
			{ noremap = true, silent = true }
		)
	end,
}
