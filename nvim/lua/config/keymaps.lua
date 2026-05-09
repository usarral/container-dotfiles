-- Oil file explorer
vim.keymap.set("n", "<Tab>", function()
	require("oil").open()
end)

-- Move lines up/down
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { silent = true })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { silent = true })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { silent = true })

-- Clear search highlight
vim.keymap.set("n", "<leader>h", ":noh<CR>", { silent = true })

-- Terminal: exit with Esc
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]])

-- Save / Quit
vim.keymap.set("n", "<C-s>", ":w<CR>")
vim.keymap.set("n", "<F5>", ":wa<CR>")
vim.keymap.set("n", "<BS>", ":confirm bdelete<CR>")
vim.keymap.set("n", "<C-BS>", ":qa<CR>")
