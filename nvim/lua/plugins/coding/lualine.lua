return {
	"nvim-lualine/lualine.nvim",
	event = { "BufWinEnter" },
	config = function()
		local function workdir_component()
			return {
				function()
					local is_local = vim.fn.haslocaldir() == 1
					local username = os.getenv("USER") or os.getenv("USERNAME") or "user"
					local icon = (is_local and "L" or "G") .. "  "

					local cwd = vim.fn.getcwd()
					local short_cwd = vim.fn.pathshorten(vim.fn.fnamemodify(cwd, ":~"))

					local trail = cwd:sub(-1) == "/" and "" or "/"

					return username .. " @ " .. icon .. short_cwd .. trail .. " "
				end,
				icon = nil,
				color = { fg = "#cba6f7", bold = true },
			}
		end

		local function get_current_time()
			return os.date("%Y-%m-%d %H:%M %a")
		end

		local function get_lsp_status()
			local clients = vim.lsp.get_clients({ bufnr = 0 })

			if not clients or #clients == 0 then
				return "" -- return nil if no lsp
			end

			local lsp_names = {}
			for _, client in ipairs(clients) do
				if client and client.name then
					if
						not ({
							["null-ls"] = true,
							["stylua"] = true,
							["eslint"] = true, -- eslint 通常作为格式化工具
							["prettier"] = true,
						})[client.name]
					then
						table.insert(lsp_names, client.name)
					end
				end
			end

			if #lsp_names == 0 then
				return ""
			end

			-- 如果只有一个 LSP，直接显示名字
			if #lsp_names == 1 then
				return " " .. lsp_names[1]
			end

			-- 如果有多个 LSP，显示数量和图标
			return " " .. #lsp_names
		end

		require("lualine").setup({
			options = {
				theme = "auto", -- 自动检测主题
				-- component_separators = { left = "|", right = "|" },
				-- component_separators = { left = "", right = "" },
				-- section_separators = { left = "", right = "" },
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = {
					statusline = {
						"aerial", --outline
						"neo-tree", -- neo-tree 文件浏览器
						"NeoTree", -- 大写版本
						"NvimTree", -- 其他可能的名称
						"nvimtree", -- 小写版本
						"packer", -- packer 插件管理器
						"help", -- 帮助文件
						"startify", -- vim-startify
						"dashboard", -- 仪表板
						"snacks_dashboard", -- 仪表板
						"lazy", -- lazy.nvim 界面
						"alpha", -- alpha 启动页
						"toggleterm", -- 终端
					},
					winbar = {},
				},
				ignore_focus = {},
				always_divide_middle = true,
				globalstatus = false,
				refresh = {
					statusline = 1000,
					tabline = 1000,
					winbar = 1000,
				},
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = {
					{
						"filename",
						-- active buffer 文件名：亮青色 + 加粗
						color = function()
							if vim.fn.win_getid() == vim.g.statusline_winid then
								return { fg = "#89dceb", bold = true } -- 活动窗口：亮青色
							end
							return { fg = "#6c7086" } -- 非活动窗口：暗灰色
						end,
					},
					workdir_component(),
				},
				lualine_x = {
					{
						get_current_time,
						icon = "󰥔 ", -- 时钟图标
						color = { fg = "#f38ba9" },
					},
					{
						get_lsp_status,
						color = function()
							local clients = vim.lsp.get_clients({ bufnr = 0 })
							if clients and #clients > 0 then
								return { fg = "#a6e3a1" } -- 有 LSP 时显示绿色
							else
								return { fg = "#9399b2" } -- 无 LSP 时显示灰色
							end
						end,
					},
					"encoding",
					"fileformat",
					"filetype",
				},
				lualine_y = { "progress" },
				lualine_z = {
					"location",
				},
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			winbar = {},
			inactive_winbar = {},
			extensions = {},
		})
	end,
}
