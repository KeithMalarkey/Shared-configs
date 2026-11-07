-- 主题设置
return {
	{
		-- vault（mrpbennett/vault）：Fallout 终端 + Matrix 绿的配色
		"mrpbennett/vault",
		priority = 1000,
		lazy = false,
		config = function()
			-- 直接改 palette 一次改全：vault 的注释散落在 syntax / treesitter
			-- 多个组里（Comment、@comment、@comment.documentation、SpecialComment…），
			-- 逐个写 overrides 反而容易漏。
			local ok, palette = pcall(require, "vault.palette")
			if ok then
				palette.colors.comment = "#f7f0c8" -- 注释：暖奶白（偏黄）
				palette.colors.green = "#88b04b" -- 荧光绿 → 牛油果绿
				palette.colors.string = "#a3c47a" -- 柠绿 → 浅牛油果绿
			else
				vim.notify("vault: 找不到 vault.palette，配色未打补丁", vim.log.levels.WARN)
			end
			vim.cmd.colorscheme("vault")
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		-- 降级为备选主题：启动时只 setup 不应用配色，
		-- 否则会和 vault 抢 colorscheme（加载顺序决定谁赢）。
		-- 想切回来：:colorscheme catppuccin-mocha
		priority = 1000,
		opts = { flavour = "mocha", transparent_background = true },
		config = function(_, opts)
			require("catppuccin").setup(opts)
		end,
	},
	{
		"ellisonleao/gruvbox.nvim",
		-- priority=1000 已让它启动时加载，原来的 event = "VeryLazy" 在此无效，已删除
		-- gruvbox 的 setup() 不会自动应用配色，不会和 vault 冲突
		priority = 1000,
		config = true,
		opts = { transparent_mode = true },
	},
}
