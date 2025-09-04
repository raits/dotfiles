return {
	{
		"vue-typescript-plugin-installer",
		dir = vim.fn.stdpath("config"), -- Dummy plugin for installation logic
		name = "vue-typescript-plugin-installer",
		ft = "vue", -- Only load when opening Vue files
		config = function()
			-- Check if plugin is already installed using async approach
			vim.fn.jobstart("npm list -g @vue/typescript-plugin --depth=0 --silent", {
				on_exit = function(_, exit_code)
					if exit_code ~= 0 then
						-- Plugin not installed, prompt user
						vim.schedule(function()
							local choice = vim.fn.confirm(
								"Vue files detected but @vue/typescript-plugin is not installed.\nInstall it now for better Vue TypeScript support?",
								"&Yes\n&No",
								1
							)
							
							if choice == 1 then
								vim.notify("Installing Vue TypeScript plugin...", vim.log.levels.INFO)
								vim.fn.jobstart("npm install -g @vue/typescript-plugin", {
									on_exit = function(_, install_exit_code)
										if install_exit_code == 0 then
											vim.notify("Vue TypeScript plugin installed successfully!", vim.log.levels.INFO)
										else
											vim.notify("Failed to install Vue TypeScript plugin. Exit code: " .. install_exit_code, vim.log.levels.ERROR)
										end
									end,
								})
							end
						end)
					end
				end,
				stdout_buffered = true,
				stderr_buffered = true,
			})
		end,
	}
}