local mason = {}

mason = {
	"mason-org/mason.nvim",
	opts = {
		ui = {
			icons = {
				package_installed = "✓",
				package_pending = "➜",
				package_uninstalled = "✗",
			},
		},
	},
	config = function(_, opts)
		require("mason").setup(opts)

		-- confirm whether current operation system is nixos
		-- on nixos, runtime support of lsps is unavailable
		if vim.uv.fs_stat("/etc/nixos") ~= nil then
			return
		end

		-- 非 LSP 的工具（formatter 等）不在 mason-lspconfig 的 ensure_installed 里，
		-- 这里单独保证安装：shfmt 支持 bash/sh/zsh 三种方言，是 shell 的格式化器。
		local registry = require("mason-registry")
		local fmts = {
			"shfmt",
			"stylua",
			"black",
			"clang-format",
			"jq",
			"tex-fmt",
			"gersemi",
			"yamlfmt",
			"kdlfmt",
			"tombi",
			"doctoc",
		}
		for _, name in ipairs(fmts) do
			local ok, pkg = pcall(registry.get_package, name)
			if ok and not pkg:is_installed() then
				pkg:install()
			end
		end
	end,
}

return mason
