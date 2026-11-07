-- 语法高亮及解析，很重要，作为很多插件的依赖，建议放在顶部优先load,设置优先级priority
return {
	"nvim-treesitter/nvim-treesitter",
	-- 启动时立即加载：treesitter 要尽早注册 parser 并注入，
	-- 保证打开文件时立刻就有语法高亮（这里不用 event，lazy = false 时它也不生效）
	lazy = false,
	build = ":TSUpdate",
	-- dependencies = {
	-- 	"nvim-treesitter/nvim-treesitter-textobjects",
	-- 	"nvim-treesitter/nvim-treesitter-refactor",
	-- 	"nvim-treesitter/nvim-treesitter-context",
	-- },
	config = function()
		require("nvim-treesitter").setup()
		require("nvim-treesitter").install({
			"c",
			"cpp",
			-- "java",
			"python",
			"zig",
			"rust",
			"ini",
			"kdl",
			"toml",
			"json",
			"zsh",
			"bash",
			"yaml",
			"markdown",
			"latex",
			"bibtex",
			"markdown_inline",
			"cmake",
			"meson",
			"lua",
			"vim",
			"vimdoc",
		})
	end,
	priority = 1000,
}
