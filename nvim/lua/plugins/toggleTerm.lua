return {
	"akinsho/toggleterm.nvim",
	config = function()
		require("toggleterm").setup({
			size = 20,
			open_mapping = nil,
		})

		-- 定义各种终端
		local Terminal = require("toggleterm.terminal").Terminal

		-- 快捷键映射
		local keymap = vim.keymap.set

		-- 浮动终端
		local float_term = Terminal:new({ direction = "float" })
		keymap("n", "<leader>tf", function()
			float_term:toggle()
		end, { noremap = true, silent = true, desc = "toggle float terminal" })

		-- 水平终端
		local horizontal_term = Terminal:new({ direction = "horizontal" })
		keymap("n", "<leader>th", function()
			horizontal_term:toggle()
		end, { noremap = true, silent = true, desc = "toggle horizontal terminal" })

		-- 垂直终端
		local vertical_term = Terminal:new({ direction = "vertical" })
		keymap("n", "<leader>tv", function()
			vertical_term:toggle()
		end, { noremap = true, silent = true, desc = "toggle vertical terminal" })

		-- Lazygit
		local lazygit = Terminal:new({
			cmd = "lazygit",
			direction = "float",
			hidden = true,
		})
		keymap("n", "<leader>tl", function()
			lazygit:toggle()
		end, { noremap = true, silent = true, desc = "toggle lazygit" })

		-- Node REPL
		local node = Terminal:new({ cmd = "node", direction = "float", hidden = true })
		keymap("n", "<leader>tn", function()
			node:toggle()
		end, { noremap = true, silent = true, desc = "toggle node.js terminal" })

		-- Python REPL
		local python = Terminal:new({ cmd = "python", direction = "float", hidden = true })
		keymap("n", "<leader>tp", function()
			python:toggle()
		end, { noremap = true, silent = true, desc = "toggle python terminal" })

		-- btm 监控
		local btm = Terminal:new({ cmd = "btm", direction = "float", hidden = true })
		keymap("n", "<leader>tt", function()
			btm:toggle()
		end, { noremap = true, silent = true, desc = "toggle bottom system mintor" })
	end,
}
