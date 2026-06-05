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
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "zbirenbaum/copilot.lua" },
			{ "nvim-lua/plenary.nvim" },
		},
		opts = {
			model = "gpt-4o",
			window = {
				layout = "float",
				border = "rounded",
				width = 0.8,
				height = 0.8,
			},
		},
		keys = {
			{ "<leader>ac", "<cmd>CopilotChatToggle<cr>",   mode = { "n", "v" }, desc = "Chat toggle" },
			{ "<leader>aR", "<cmd>CopilotChatReset<cr>",    desc = "Chat reset" },
			{ "<leader>ap", function() require("CopilotChat").select_prompt() end, desc = "Prompts" },
			{ "<leader>aq", function()
				local input = vim.fn.input("Ask Copilot: ")
				if input ~= "" then require("CopilotChat").ask(input) end
			end, desc = "Quick ask" },
			-- Acciones sobre código (normal + visual)
			{ "<leader>ae", "<cmd>CopilotChatExplain<cr>",  mode = { "n", "v" }, desc = "Explain" },
			{ "<leader>af", "<cmd>CopilotChatFix<cr>",      mode = { "n", "v" }, desc = "Fix" },
			{ "<leader>ao", "<cmd>CopilotChatOptimize<cr>", mode = { "n", "v" }, desc = "Optimize" },
			{ "<leader>at", "<cmd>CopilotChatTests<cr>",    mode = { "n", "v" }, desc = "Tests" },
			{ "<leader>ad", "<cmd>CopilotChatDocs<cr>",     mode = { "n", "v" }, desc = "Docs" },
			{ "<leader>ar", "<cmd>CopilotChatReview<cr>",   mode = { "n", "v" }, desc = "Review" },
			{ "<leader>ax", "<cmd>CopilotChatFixDiagnostic<cr>", desc = "Fix diagnostic" },
		},
	},
}
