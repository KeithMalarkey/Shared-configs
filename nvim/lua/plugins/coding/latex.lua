-- lazy.nvim plugin config
return {
	"lervag/vimtex",
	lazy = false, -- 不要 lazy load
	init = function()
		vim.g.vimtex_view_method = "zathura_simple" -- PDF 查看器（无 xdotool，用 simple 变体，仍支持正反向搜索）
		vim.g.vimtex_compiler_method = "latexmk"
		vim.g.vimtex_quickfix_mode = 0
		vim.g.vimtex_view_automatic = 1
		vim.g.vimtex_compiler_latexmk = {
			executable = "latexmk",
			options = {
				"-xelatex", -- 这里关键，fontspec 必须用 XeLaTeX
				"-shell-escape",
				"-file-line-error",
				"-synctex=1",
				"-interaction=nonstopmode",
			},
		}
	end,
	config = function()
		vim.keymap.set("n", "<leader>ll", "<cmd>VimtexCompile<CR>", { desc = "LaTeX: compile and refresh PDF" })
		vim.keymap.set("n", "<leader>lv", "<cmd>VimtexView<CR>", { desc = "LaTeX: open PDF (zathura)" })
		vim.keymap.set("n", "<leader>ls", "<cmd>VimtexStop<CR>", { desc = "LaTeX: stop compilation" })
		vim.keymap.set("n", "<leader>le", "<cmd>VimtexErrors<CR>", { desc = "LaTeX: view compilation erroe" })
		vim.keymap.set("n", "<leader>lt", "<cmd>VimtexTocToggle<CR>", { desc = "LaTeX: show content outline" })
		vim.keymap.set(
			"n",
			"<leader>lf",
			"<cmd>LspTexlabForward<CR>",
			{ desc = "LaTeX: 正向搜索到 PDF (zathura)" }
		)
		vim.keymap.set("n", "<leader>lb", "<cmd>LspTexlabBuild<CR>", { desc = "LaTeX: TexLab 编译" })
		vim.keymap.set("n", "<leader>le2", "<cmd>LspTexlabFindEnvironments<CR>", { desc = "LaTeX: 查找可用环境" })
	end,
}
