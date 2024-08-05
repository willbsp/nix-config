local auto_dark_mode = require("auto-dark-mode")

auto_dark_mode.setup({
	update_interval = 1000,
	set_dark_mode = function()
		vim.cmd("colorscheme rose-pine-main")
	end,
	set_light_mode = function()
		vim.cmd("colorscheme rose-pine-dawn")
	end,
})
