return {
	"akinsho/toggleterm.nvim",
	config = function()
		require("toggleterm").setup({
			size = 20,
			open_mapping = nil,
		})

		-- Definition of different terminal
		local Terminal = require("toggleterm.terminal").Terminal

		local keymap = vim.keymap.set
		-- Floating terminal
		local float_term = Terminal:new({ direction = "float" })
		keymap("n", "<leader>tf", function()
			float_term:toggle()
		end, { noremap = true, silent = true, desc = "toggle float terminal" })

		-- Horizontal terminal
		local horizontal_term = Terminal:new({ direction = "horizontal" })
		keymap("n", "<leader>th", function()
			horizontal_term:toggle()
		end, { noremap = true, silent = true, desc = "toggle horizontal terminal" })

		-- vertical terminal
		local vertical_term = Terminal:new({ direction = "vertical" })
		keymap("n", "<leader>tv", function()
			vertical_term:toggle()
		end, { noremap = true, silent = true, desc = "toggle vertical terminal" })

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
	end,
}
