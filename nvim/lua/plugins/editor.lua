return {
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = { view_options = { show_hidden = true } },
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			preset = "helix",
			spec = {
				{ "<leader>",  group = "leader" },
				{ "g",         group = "goto" },
				{ "<leader>g", group = "git" },
				{ "<leader>d", group = "docker" },
				{ "<leader>x", group = "diagnostics" },
				{ "]",         group = "next" },
				{ "[",         group = "prev" },
				{ "z",         group = "fold/spell" },
			},
		},
	},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local harpoon = require("harpoon")
			harpoon:setup()
			vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Harpoon add" })
			vim.keymap.set("n", "<leader>e", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon menu" })
			vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
			vim.keymap.set("n", "<C-j>", function() harpoon:list():select(2) end)
			vim.keymap.set("n", "<C-k>", function() harpoon:list():select(3) end)
			vim.keymap.set("n", "<C-l>", function() harpoon:list():select(4) end)
		end,
	},
	{
		"chrisgrieser/nvim-rip-substitute",
		cmd = "RipSubstitute",
		keys = {
			{
				"<leader>fs",
				function() require("rip-substitute").sub() end,
				mode = { "n", "x" },
				desc = "Rip substitute",
			},
		},
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		keys = {
			{ [[<C-\>]],    desc = "Toggle terminal" },
			{ "<leader>gg", desc = "Lazygit" },
			{ "<leader>dd", desc = "Lazydocker" },
		},
		config = function()
			require("toggleterm").setup({
				open_mapping = [[<C-\>]],
				direction = "horizontal",
				size = 15,
			})

			local Terminal = require("toggleterm.terminal").Terminal

			local lazygit = Terminal:new({
				cmd = "lazygit",
				hidden = true,
				direction = "float",
				float_opts = { border = "rounded" },
			})

			local lazydocker = Terminal:new({
				cmd = "lazydocker",
				hidden = true,
				direction = "float",
				float_opts = { border = "rounded" },
			})

			vim.keymap.set("n", "<leader>gg", function() lazygit:toggle() end, { desc = "Lazygit" })
			vim.keymap.set("n", "<leader>dd", function() lazydocker:toggle() end, { desc = "Lazydocker" })
		end,
	},
	{
		"folke/trouble.nvim",
		cmd = "Trouble",
		keys = {
			{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",                        desc = "Diagnostics" },
			{ "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",           desc = "Buffer diagnostics" },
			{ "<leader>xs", "<cmd>Trouble symbols toggle<cr>",                            desc = "Symbols" },
			{ "<leader>xl", "<cmd>Trouble lsp toggle<cr>",                                desc = "LSP definitions / references" },
			{ "<leader>xq", "<cmd>Trouble qflist toggle<cr>",                             desc = "Quickfix" },
		},
		opts = {},
	},
	{
		"folke/twilight.nvim",
		cmd = { "Twilight", "TwilightEnable", "TwilightDisable" },
		keys = {
			{ "<leader>tw", "<cmd>Twilight<cr>", desc = "Twilight toggle" },
		},
		opts = {
			dimming = { alpha = 0.25 },
			context = 10,
		},
	},
}
