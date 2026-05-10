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
}
