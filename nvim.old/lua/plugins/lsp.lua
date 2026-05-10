return {
	{
		"neovim/nvim-lspconfig",
		dependencies = { "saghen/blink.cmp" },
	},
	{
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
	},
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			ensure_installed = {}, -- Lo llenaremos dinámicamente o dejaremos que se maneje por módulo
			automatic_installation = true,
		},
	},
	{ "mfussenegger/nvim-jdtls" },
	require("config.languages.csharp").plugin,
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
		opts = {
			file_types = { "markdown", "copilot-chat" },
		},
	},
}
