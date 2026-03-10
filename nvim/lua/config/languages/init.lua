local M = {}

function M.setup()
	-- Siempre cargar Lua (esencial para Neovim)
	require("config.languages.lua").setup()

	-- Cargar Node si está instalado
	if vim.fn.executable("node") == 1 then
		require("config.languages.node").setup()
	end

	-- Cargar Java si está instalado
	if vim.fn.executable("java") == 1 then
		require("config.languages.java").setup()
	end

	-- Cargar otros lenguajes (GDScript por ejemplo)
	if vim.fn.executable("gdscript") == 1 then
		require("lspconfig").gdscript.setup({})
	end
end

return M
