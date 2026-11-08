return {
	{
		"mrpbennett/vault",
		priority = 1000,
		lazy = false,
		config = function()
			local ok, palette = pcall(require, "vault.palette")
			if ok then
				palette.colors.comment = "#f7f0c8"
				palette.colors.green = "#88b04b"
				palette.colors.string = "#a3c47a"
			else
				vim.notify("vault: can not find vault.palette", vim.log.levels.WARN)
			end
			vim.cmd.colorscheme("vault")
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		-- degrade to default colorscheme
		priority = 1000,
		opts = { flavour = "mocha", transparent_background = true },
		config = function(_, opts)
			require("catppuccin").setup(opts)
		end,
	},
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		config = true,
		opts = { transparent_mode = true },
	},
}
