return {
	"saghen/blink.cmp",
	dependencies = { "rafamadriz/friendly-snippets", "fang2hou/blink-copilot" },
	version = "1.*",
	opts = {
		keymap = {
			preset = "default",
			["<C-k>"] = { "select_prev", "fallback" },
			["<C-j>"] = { "select_next", "fallback" },
			["<C-e>"] = { "hide", "fallback" },
			["<Tab>"] = { "accept", "fallback" },
		},

		appearance = {
			nerd_font_variant = "mono",
		},

		completion = { documentation = { auto_show = true, auto_show_delay_ms = 500 } },

		-- Default list of enabled providers defined so that you can extend it
		-- elsewhere in your config, without redefining it, due to `opts_extend`
		sources = {
			default = { "copilot", "lsp", "path", "snippets", "buffer" },
			providers = {
				copilot = {
					name = "copilot",
					module = "blink-copilot",
					score_offset = 100,
					async = true,
				},
			},
		},

		fuzzy = { implementation = "prefer_rust_with_warning" },
	},
	opts_extend = { "sources.default" },
}
