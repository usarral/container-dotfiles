return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
		ft = { "markdown" },
		opts = {
			file_types = { "markdown" },
			heading = { enabled = true },
			code = { enabled = true, sign = true },
			dash = { enabled = true },
			bullet = { enabled = true },
			checkbox = { enabled = true },
			table = { enabled = true },
		},
	},
}
