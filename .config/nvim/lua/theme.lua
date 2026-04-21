return {
	-- {
	-- 	"ellisonleao/gruvbox.nvim",
	-- 	priority = 1000,
	-- 	init = function()
	-- 		vim.cmd.colorscheme("gruvbox")
	-- 	end,
	-- },
	{
		"rebelot/kanagawa.nvim",
		priority = 1000,
		init = function()
			vim.cmd.colorscheme("kanagawa-wave")
			vim.api.nvim_set_hl(0, "LineNr", { bg = "NONE" })
			vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "NONE" })
			vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
			vim.api.nvim_set_hl(0, "FoldColumn", { bg = "NONE" })
		end,
	},
	-- {
	-- 	"catppuccin/nvim",
	-- 	name = "catppuccin",
	-- 	priority = 1000,
	-- 	init = function()
	-- 		vim.cmd.colorscheme("catppuccin-mocha")
	--
	-- 		require("catppuccin").setup({
	-- 			default_integrations = true,
	-- 		})
	-- 	end,
	-- },
}
