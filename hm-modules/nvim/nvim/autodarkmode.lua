local auto_dark_mode = require("auto-dark-mode")

auto_dark_mode.setup({
	update_interval = 1000,
	set_dark_mode = function()
		vim.cmd("colorscheme catppuccin-frappe")
	end,
	set_light_mode = function()
		vim.cmd("colorscheme catppuccin-latte")
	end,
})
