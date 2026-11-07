-- 语言服务器
-- NixOS 上 Mason 装的预编译二进制跑不起来，LSP server 改由 Nix 安装进 PATH，
-- 检测到 NixOS 就不让 mason-lspconfig 自动安装（vim.lsp.enable 不受影响）。
-- /etc/NIXOS 是 NixOS 的标志文件。
local is_nixos = vim.uv.fs_stat("/etc/NIXOS") ~= nil

return {
	"mason-org/mason-lspconfig.nvim",
	event = "BufEnter",
	opts = {
		ensure_installed = is_nixos and {} or {
			"lua_ls",
			"rust_analyzer",
			"clangd",
			"pyright",
			"zls",
			"neocmake",
			"bashls",
			"jsonls",
			"yamlls",
			-- "ltex",
			-- "jdtls",
			"shuck",
			"texlab",
			"vimls",
			"tombi",
		},
		automatic_enable = false,
	},
	-- mason 和 nvim-lspconfig 都有自己的顶层 spec（config 里 require 时自动加载），无需声明依赖
}
