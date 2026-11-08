return {
	{
		"folke/todo-comments.nvim",
		opts = {
			highlight = {
				before = "",
				keyword = "wide",
				after = "fg",
				-- 写成 "// TODO 干活" 不会高亮，只有 "// TODO: 干活" 才行。
				-- 这里去掉冒号要求，两种写法都能命中。
				pattern = [[.*<(KEYWORDS)\s*]],
			},
			colors = {
				error = { "DiagnosticError", "ErrorMsg", "#DC2626" }, -- FIX 系列：Bug 红
				warning = { "DiagnosticWarn", "WarningMsg", "#FB923C" }, -- WARN 系列：告警橙
				info = { "DiagnosticInfo", "#60A5FA" }, -- TODO：行动蓝
				hint = { "DiagnosticHint", "#34D399" }, -- NOTE：中性青绿
				default = { "Identifier", "#A78BFA" }, -- PERF：性能紫
				test = { "Identifier", "#F472B6" }, -- TEST：测试品红
			},
			keywords = {
				FIX = {
					icon = " ",
					color = "error", -- 红
					alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
				},
				TODO = { icon = " ", color = "info" }, -- 蓝
				HACK = { icon = " ", color = "warning" }, -- 橙
				WARN = {
					icon = " ",
					color = "warning", -- 橙
					alt = { "WARNING", "XXX" },
				},
				PERF = {
					icon = " ",
					color = "default", -- 紫
					alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" },
				},
				NOTE = {
					icon = " ",
					color = "hint", -- 青
					alt = { "INFO" },
				},
				TEST = {
					icon = "⏲ ",
					color = "test", -- 品红
					alt = { "TESTING", "PASSED", "FAILED" },
				},
			},
		},
	},
}
