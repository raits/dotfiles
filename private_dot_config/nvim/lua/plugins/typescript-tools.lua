return {
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig", "saghen/blink.cmp" },
		-- opts = {},
		opts = function()
			-- Check for Vue files asynchronously
			vim.fn.jobstart("find . -name '*.vue' -type f | head -1", {
				on_stdout = function(_, data)
					local has_vue = data and data[1] and data[1] ~= ""
					if has_vue then
						-- Check if plugin is installed asynchronously
						vim.fn.jobstart("npm list -g @vue/typescript-plugin --depth=0 --silent", {
							on_exit = function(_, exit_code)
								if exit_code ~= 0 then
									-- Plugin not found, install it
									print("Vue files detected. Installing Vue TypeScript plugin...")
									vim.fn.jobstart("npm install -g @vue/typescript-plugin", {
										on_exit = function(_, install_exit_code)
											if install_exit_code == 0 then
												print("Vue TypeScript plugin installed successfully. Restart nvim to take effect.")
											else
												print("Failed to install Vue TypeScript plugin. Exit code: " .. install_exit_code)
											end
										end,
										stdout_buffered = true,
										stderr_buffered = true,
									})
								end
							end,
							stdout_buffered = true,
							stderr_buffered = true,
						})
					end
				end,
				stdout_buffered = true,
				stderr_buffered = true,
			})
			
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
