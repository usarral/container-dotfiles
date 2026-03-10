return {
	"codingpotions/codely-vim-theme",
	lazy = false,
	priority = 1000,
	config = function()
		vim.cmd("set background=dark")
		vim.cmd.colorscheme("codely-theme")
	end,
}
