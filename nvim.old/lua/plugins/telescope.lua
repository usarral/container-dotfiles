return {
	"nvim-telescope/telescope.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	main = "telescope",
	opts = {
		defaults = {
			vimgrep_arguments = {
				"rg",
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
				"--no-ignore",
				"--fixed-strings",
			},
		},
		pickers = {
			find_files = {
				no_ignore_parent = true,
			},
		},
	},
	config = function(_, opts)
		local telescope = require("telescope")
		telescope.setup(opts)

		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>f", builtin.find_files, {})
		vim.keymap.set("n", "<leader>g", builtin.live_grep, {})
		vim.keymap.set("n", "<leader>b", builtin.buffers, {})
		vim.keymap.set("n", "<leader><leader>", builtin.find_files, { desc = "Find files" })
		vim.keymap.set("n", "<leader>/", builtin.live_grep, { desc = "Ripgrep search" })
	end,
}
