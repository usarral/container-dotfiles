return {
	{
		"nvim-telescope/telescope.nvim",
		branch = "master",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{ "<leader>f", "<cmd>Telescope find_files<cr>", desc = "Find files" },
			{ "<leader>g", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
			{ "<leader>b", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
			{ "<leader>s", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document symbols" },
			{ "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command history" },
		},
		opts = {
			defaults = {
				mappings = {
					i = { ["<C-j>"] = "move_selection_next", ["<C-k>"] = "move_selection_previous" },
				},
			},
		},
	},
	{
		"ibhagwan/fzf-lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		keys = {
			{ "<leader>?",  "<cmd>FzfLua keymaps<cr>",  desc = "Keymaps" },
			{ "<leader>P",  "<cmd>FzfLua commands<cr>", desc = "Commands" },
			{ "<leader>H",  "<cmd>FzfLua helptags<cr>", desc = "Help tags" },
			{ "<leader>A",  "<cmd>FzfLua autocmds<cr>", desc = "Autocmds" },
		},
		opts = { "default" },
	},
}
