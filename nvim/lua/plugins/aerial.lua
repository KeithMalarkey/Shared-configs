return {
	"stevearc/aerial.nvim",
	event = { "VeryLazy", "BufReadPost" },
	config = function()
		require("aerial").setup({
			backends = { "lsp", "treesitter", "markdown" },
			backend_check = function(bufnr)
				local ts_ok, _ = pcall(require, "nvim-treesitter.parsers")
				if ts_ok then
					local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
					local lang = require("nvim-treesitter.parsers").ft_to_lang(ft)
					if lang ~= nil and lang ~= "" then
						return true
					end
				end
				local clients = vim.lsp.get_active_clients({ bufnr = bufnr })
				return #clients > 0
			end,

			filter_kind = false,
			layout = {
				min_width = 30,
				max_width = 50,
				default_direction = "prefer_right",
				placement = "window",
				resize_to_content = true,
			},

			show_guides = true,
			guide_chars = "│ ─├─└",
			autojump = false,
			close_on_select = true,
			highlight_on_hover = true,
			highlight_on_jump = true,

			filetype_map = {
				["json"] = "json",
				["yaml"] = "yaml",
				["toml"] = "toml",
				["markdown"] = "markdown",
				["python"] = "python",
				["javascript"] = "javascript",
				["typescript"] = "typescript",
				["lua"] = "lua",
				["go"] = "go",
				["rust"] = "rust",
				["cpp"] = "cpp",
				["java"] = "java",
			},
		})

		-- 快捷键
		vim.keymap.set("n", "<leader>ol", "<cmd>AerialToggle!<CR>", { desc = "Toggle outline" })
		vim.keymap.set("n", "[[", "<cmd>AerialPrev<CR>", { desc = "Previous symbol" })
		vim.keymap.set("n", "]]", "<cmd>AerialNext<CR>", { desc = "Next symbol" })
	end,
	keys = {
		{ "<leader>ol", desc = "Toggle outline" },
		{ "[[", desc = "Previous symbol" },
		{ "]]", desc = "Next symbol" },
	},
}
