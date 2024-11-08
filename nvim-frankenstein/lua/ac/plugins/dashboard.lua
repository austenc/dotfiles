local logo = "\n"
	.. [[
 ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
 ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⣿⣿⣿⣦⣄⡀⠀⠀⠀⠀
 ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⣄⠀
 ⠀⢀⣤⣤⣀⠀⠀⠀⠀⠀⢠⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀
 ⣴⣿⣿⣿⣿⣷⣤⡀⣠⣶⣿⣿⣿⣿⣿⣿⣿⣿⠟⣿⣿⣿⣿⣿⣿⣿⠀
 ⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠋⠉⠀⣿⣿⣿⣿⣿⣿⣿⠀
 ⠀⠈⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠋⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⠀
 ⠀⠀⠀⢈⣿⣿⣿⣿⣿⣿⣿⣿⣏⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⠀
 ⠀⢀⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⡄⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⠀
 ⠻⣿⣿⣿⣿⡿⠛⠁⠀⠀⠙⢿⣿⣿⣿⣿⣿⣿⣦⣿⣿⣿⣿⣿⣿⣿⠀
 ⠀⠈⠛⠛⠉⠀⠀⠀⠀⠀⠀⠀⠘⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀
 ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⣿⣿⣿⣿⣿⣿⣿⠟⠋⠀⠀
]]
	.. "\n⚡️🧙  VS Code Has No Power Here!"

return {
	"nvimdev/dashboard-nvim",
	enabled = false,
	event = "VimEnter",
	config = function()
		require("dashboard").setup({
			config = {
				shortcut = {},
				header = vim.split(logo, "\n"),
				-- TODO: look into projects
				project = { enable = false },
				mru = { limit = 4 },
			},
		})
	end,
	dependencies = { { "nvim-tree/nvim-web-devicons" } },
}
