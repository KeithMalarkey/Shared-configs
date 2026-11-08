return {
	"saghen/blink.cmp",
	dependencies = {
		"rafamadriz/friendly-snippets",
		"onsails/lspkind-nvim",
	},

	-- use a release tag to download pre-built binaries
	version = "1.*",
	opts = {
		keymap = {
			preset = "none",

			["<Tab>"] = {
				function(cmp)
					if cmp.is_visible() then
						return cmp.select_next()
					end

					if cmp.snippet_active({ direction = 1 }) then
						return cmp.snippet_forward()
					end

					return false
				end,
				"fallback",
			},

			["<S-Tab>"] = {
				function(cmp)
					if cmp.is_visible() then
						return cmp.select_prev()
					end
					if cmp.snippet_active({ direction = -1 }) then
						return cmp.snippet_backward()
					end
					return false
				end,
				"fallback",
			},
			["<Up>"] = { "select_prev", "fallback" },
			["<Down>"] = { "select_next", "fallback" },
			["<CR>"] = { "accept", "fallback" },
			["<Esc>"] = { "hide", "fallback" },
			["<C-.>"] = { "show", "show_documentation", "hide_documentation" },
			["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
		},

		appearance = {
			-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			-- Adjusts spacing to ensure icons are aligned
			nerd_font_variant = "mono",
		},

		-- (Default) Only show the documentation popup when manually triggered
		completion = {
			list = {
				selection = {
					preselect = false,
				},
			},
			menu = {
				auto_show = true,
				scrollbar = false,
				border = "rounded",
				winhighlight = "Normal:BlinkCmpMenu,FloatBorder:FloatBorder,CursorLine:BlinkCmpMenuSelection,Search:None",

				draw = {
					components = {
						kind_icon = {
							text = function(ctx)
								local icon = ctx.kind_icon
								if vim.tbl_contains({ "Path" }, ctx.source_name) then
									local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
									if dev_icon then
										icon = dev_icon
									end
								else
									icon = require("lspkind").symbol_map[ctx.kind] or ""
								end

								return icon .. ctx.icon_gap
							end,

							-- Optionally, use the highlight groups from nvim-web-devicons
							-- You can also add the same function for `kind.highlight` if you want to
							-- keep the highlight groups in sync with the icons.
							highlight = function(ctx)
								local hl = ctx.kind_hl
								if vim.tbl_contains({ "Path" }, ctx.source_name) then
									local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
									if dev_icon then
										hl = dev_hl
									end
								end
								return hl
							end,
						},

						source_name = {
							text = function(ctx)
								return "[" .. ctx.source_name .. "]"
							end,
							highlight = "Comment",
							width = { fill = true },
						},
					},
					columns = {
						{ "kind_icon", "kind", gap = 1 },
						{ "label", "label_description", gap = 1 },
						{ "source_name" },
					},
				},
			},
			documentation = {
				auto_show = false,
				window = {
					border = "rounded",
					scrollbar = false,
					winhighlight = "Normal:BlinkCmpDoc,FloatBorder:FloatBorder,EndOfBuffer:BlinkCmpDoc",
				},
			},
		},

		signature = {
			enabled = true,
			window = {
				border = "rounded",
				scrollbar = false,
			},
		},

		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},

		fuzzy = { implementation = "prefer_rust_with_warning" },
	},
	opts_extend = { "sources.default" },
}
