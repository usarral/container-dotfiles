return {
	{
		"codingpotions/codely-vim-theme",
		lazy = false,
		priority = 1000,
		config = function()
			vim.opt.background = "dark"
			vim.cmd("colorscheme codely-theme")
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = {
				theme = "auto",
				component_separators = "|",
				section_separators = "",
			},
			sections = {
				lualine_c = { { "filename", path = 1 } },
				lualine_x = {
					{
						function()
							local lang = vim.env.DEVPOD_LANG
							return lang and lang ~= "" and ("[" .. lang .. "]") or ""
						end,
						color = { fg = "#a9b665" },
					},
					"filetype",
				},
			},
		},
	},
}
