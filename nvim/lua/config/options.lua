vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true
vim.opt.number = true
vim.wo.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.wrap = true
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.foldenable = false
vim.opt.conceallevel = 2
vim.opt.clipboard = "unnamedplus"

-- Fix clipboard in WSL
if vim.fn.has("wsl") == 1 then
	vim.g.clipboard = {
		name = "win32yank",
		copy = { ["+"] = "win32yank.exe -i --crlf", ["*"] = "win32yank.exe -i --crlf" },
		paste = { ["+"] = "win32yank.exe -o --lf", ["*"] = "win32yank.exe -o --lf" },
		cache_enabled = false,
	}
end

vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	update_in_insert = false,
	underline = true,
	severity_sort = true,
})

-- Help opens full window
vim.api.nvim_create_autocmd("FileType", {
	pattern = "help",
	callback = function()
		vim.cmd("only")
		vim.bo.buflisted = true
	end,
})
