return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		preset = "helix",
		delay = 0,
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = true })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
}
