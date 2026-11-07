-- mason：管理 LSP / linter / formatter 等外部工具
return {
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

		-- NixOS 上 Mason 的预编译二进制缺少标准动态链接器，装了也跑不起来；
		-- 外部工具改由 home-manager 安装（进 PATH 后 conform 等自动找到），
		-- 检测到 NixOS 就跳过这里的自动安装。/etc/NIXOS 是 NixOS 的标志文件。
		if vim.uv.fs_stat("/etc/NIXOS") ~= nil then
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
