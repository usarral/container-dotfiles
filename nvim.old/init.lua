require("config.lazy")
require("config.nodejs").setup({ silent = true })

vim.opt.termguicolors = true
vim.opt.conceallevel = 2
vim.diagnostic.config({
	virtual_text = true,
	signs = true, -- Enable signs in the gutter
	update_in_insert = true, -- Don't update diagnostics while in insert mode
	underline = true, -- Underline diagnostic issues
	severity_sort = true, -- Sort diagnostics by severity
	virtual_lines = true,
})

-- Fix copy and paste in WSL (Windows Subsystem for Linux)
vim.opt.clipboard = "unnamedplus" -- Use the system clipboard for all operations
if vim.fn.has("wsl") == 1 then
	vim.g.clipboard = {
		name = "win32yank", -- Use win32yank for clipboard operations
		copy = {
			["+"] = "win32yank.exe -i --crlf", -- Command to copy to the system clipboard
			["*"] = "win32yank.exe -i --crlf", -- Command to copy to the primary clipboard
		},
		paste = {
			["+"] = "win32yank.exe -o --lf", -- Command to paste from the system clipboard
			["*"] = "win32yank.exe -o --lf", -- Command to paste from the primary clipboard
		},
		cache_enabled = false, -- Disable clipboard caching
	}
end

--help files open in full window and are listed in buffer elements
vim.api.nvim_create_autocmd("FileType", {
	pattern = "help",
	callback = function()
		vim.cmd("only")
		vim.bo.buflisted = true
	end,
})

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- vim.o.tabstop = 4
-- vim.o.softtabstop = 4
-- vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.autoindent = false
vim.o.smartindent = true
vim.o.signcolumn = "yes"
vim.o.foldenable = false
vim.o.wrap = true
vim.wo.relativenumber = true

--KEYMAPS
vim.keymap.set("n", "<Tab>", function()
	require("oil").open()
end)

vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { silent = true })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { silent = true })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { silent = true })

--unhighlight
vim.keymap.set("n", "<leader>h", ":noh<CR>", { silent = true })

--terminal
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]])

--saving&quitting
vim.keymap.set("n", "<C-s>", ":w<CR>")
vim.keymap.set("n", "<F5>", ":wa<CR>")
vim.keymap.set("n", "<BS>", ":confirm bdelete<CR>")
vim.keymap.set("n", "<C-BS>", ":qa<CR>")

--copilot
--this is necessary to still allow default tab behavior when copilot suggestion is not visible
vim.keymap.set("i", "<Tab>", function()
	local copilot = require("copilot.suggestion")
	if copilot.is_visible() then
		copilot.accept_line()
	else
		return "\t"
	end
end, { expr = true })
vim.keymap.set({ "n", "v" }, "`", ":CopilotChat<CR>")
vim.keymap.set({ "n", "v" }, "<leader>aa", ":CopilotChatToggle<CR>", { desc = "Open Copilot Chat" })
vim.api.nvim_create_autocmd("BufWinEnter", {
	pattern = "copilot-chat",
	callback = function()
		vim.cmd("wincmd r")
	end,
})
