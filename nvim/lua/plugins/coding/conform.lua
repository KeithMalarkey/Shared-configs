-- fmts manager
return {
	"stevearc/conform.nvim",
	lazy = true,
	event = {
		"BufReadPost",
		"BufNewFile",
		"InsertLeave",
		"TextChanged",
	},
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "black" },
			rust = { "rustfmt" },
			cpp = { "clang-format" },
			hpp = { "clang-format" },
			cu = { "clang-format" },
			cc = { "clang-format" },
			h = { "clang-format" },
			cxx = { "clang-format" },
			tpp = { "clang-format" },
			json = { "jq" },
			tex = { "tex-fmt" },
			bib = { "tex-fmt" },
			c = { "clang-format" },
			cmake = { "gersemi" },
			yaml = { "yamlfmt" },
			yml = { "yamlfmt" },
			bash = { "shfmt" }, -- applied for .zshrc/zsh/bash/sh
			sh = { "shfmt" },
			zsh = { "shfmt" },
			kdl = { "kdlfmt" },
			toml = { "tombi" },
			markdown = { "doctoc" },
			nix = { "nixfmt" },
		},
		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback",
		},
		-- just keep log for errors
		log_level = vim.log.levels.ERROR,
		formatters = {
			shfmt = {
				args = function(_, ctx)
					local args = { "-filename", "$FILENAME" }
					local has_editorconfig = vim.fs.find(".editorconfig", { path = ctx.dirname, upward = true })[1]
						~= nil
					if not has_editorconfig then
						vim.list_extend(args, { "-i", "4" })
					end
					return args
				end,
			},
		},
	},
}
