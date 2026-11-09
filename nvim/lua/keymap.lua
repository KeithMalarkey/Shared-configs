---- buffer operation
--
vim.keymap.set({ "n", "v" }, "<C-q>", "<cmd>q!<CR>", { desc = "Force quit" })
vim.keymap.set({ "n", "v" }, "<C-s>", "<cmd>wall<CR>", { desc = "Force write all" })
vim.keymap.set("n", "<leader>nb", "<cmd>enew<cr>", { desc = "New File" })
vim.keymap.set("n", "<leader>R", function()
	local old_name = vim.fn.expand("%:p")
	if old_name == "" then
		vim.notify("current buffer has no name", vim.log.levels.WARN)
		return
	end
	vim.ui.input({ prompt = "New File Name: ", default = old_name }, function(new_name)
		if new_name and new_name ~= "" and new_name ~= old_name then
			vim.cmd("saveas " .. vim.fn.fnameescape(new_name))
			vim.cmd("silent! !rm " .. vim.fn.shellescape(old_name))
			vim.cmd("e!")
			vim.notify("buffer has been renamed as: " .. new_name)
		end
	end)
end, { desc = "Rename Current File" })

vim.keymap.set("n", "<leader>cb", "<cmd>%bd<cr>", { desc = "close other buffers" })
vim.keymap.set("n", "[b", "<cmd>bp<cr>", { desc = "Previous Buffer" })
vim.keymap.set("n", "]b", "<cmd>bn<cr>", { desc = "Next Buffer" })
vim.keymap.set("v", "<C-h>", "<C-w>h", { desc = "go to the left window/split" })
vim.keymap.set("v", "<C-l>", "<C-w>l", { desc = "go to the right window/split" })
vim.keymap.set("v", "<C-j>", "<C-w>j", { desc = "go to the down window/split" })
vim.keymap.set("v", "<C-k>", "<C-w>k", { desc = "go to the up window/split" })
vim.keymap.set({ "n", "v" }, "<leader>|", "<cmd>vsplit<CR>", {
	desc = "vertical split",
})
vim.keymap.set({ "n", "v" }, "<leader>\\", "<cmd>split<CR>", {
	desc = "horizontal split",
})
local function resize_window(direction)
	local win = vim.api.nvim_get_current_win()
	local config = vim.api.nvim_win_get_config(win)

	if direction == "left" then
		vim.cmd("vertical resize -2")
	elseif direction == "right" then
		vim.cmd("vertical resize +2")
	elseif direction == "up" then
		vim.cmd("resize -2")
	elseif direction == "down" then
		vim.cmd("resize +2")
	end
end
vim.keymap.set("n", "<C-Left>", function()
	resize_window("left")
end, { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", function()
	resize_window("right")
end, { desc = "Increase window width" })
vim.keymap.set("n", "<C-Up>", function()
	resize_window("up")
end, { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Down>", function()
	resize_window("down")
end, { desc = "Increase window height" })

vim.keymap.set("n", "]t", "<cmd>tabnext<cr>", { desc = "Next [T]ab" })
vim.keymap.set("n", "[t", "<cmd>tabprevious<cr>", { desc = "Previous [T]ab" })
vim.keymap.set("n", "<C-t>n", "<cmd>tabnew<cr>", { desc = "[T]ab [N]ew" })
vim.keymap.set("n", "<C-t>c", "<cmd>tabclose<cr>", { desc = "[T]ab [C]lose" })

-- better escape
vim.keymap.set("i", "jj", "<Esc>")

-- themes
vim.keymap.set("n", "<leader>ft", function()
	require("fzf-lua").fzf_exec(vim.fn.getcompletion("", "color"), {
		actions = {
			["default"] = function(selected)
				local name = selected[1]
				if name == "catppuccin" then
					name = "catppuccin-mocha"
				end
				vim.cmd("colorscheme " .. name)
			end,
		},
	})
end, { desc = "switch colorscheme" })
vim.keymap.set(
	"n",
	"<leader>fh",
	"<cmd>FzfLua combine oldfiles git_files<cr>",
	{ desc = "find recent history files and git files" }
)

-- lsp enhancement
vim.keymap.set("n", "gd", function()
	vim.lsp.buf.definition()
end, { desc = "go to definition" })
vim.keymap.set("n", "gD", function()
	vim.lsp.buf.declaration()
end, { desc = "go to declaration" })
vim.keymap.set("n", "gi", function()
	vim.lsp.buf.implementation()
end, { desc = "go to implementation" })
vim.keymap.set("n", "gr", function()
	vim.lsp.buf.references()
end, { desc = "go to references" })
vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc", { desc = "Hover" })
vim.keymap.set("n", "<leader>rn", function()
	vim.lsp.buf.rename()
end, { desc = "rename" })
vim.keymap.set("n", "<leader>ca", function()
	vim.lsp.buf.code_action()
end, { desc = "code action" })
