return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		opts = {
			suggestion = { enabled = false },
			panel = { enabled = false },
		},
	},
	{
		"fang2hou/blink-copilot",
		dependencies = { "zbirenbaum/copilot.lua" },
	},
	{
		"saghen/blink.cmp",
		opts = function(_, opts)
			opts.sources.default = vim.list_extend(opts.sources.default or {}, { "copilot" })
			opts.sources.providers = opts.sources.providers or {}
			opts.sources.providers.copilot = {
				name = "copilot",
				module = "blink-copilot",
				score_offset = 100,
				async = true,
			}
			return opts
		end,
	},
}
