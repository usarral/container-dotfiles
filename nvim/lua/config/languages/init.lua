local M = {}

function M.setup()
	-- 1. Lenguajes ESENCIALES
	require("config.languages.lua").setup()

	-- 2. Lenguajes de DESARROLLO (Detección dinámica)
	if vim.fn.executable("node") == 1 then
		require("config.languages.node").setup()
	end

	if vim.fn.executable("java") == 1 then
		require("config.languages.java").setup()
	end

	if vim.fn.executable("dotnet") == 1 or vim.fn.executable("csharpls") == 1 then
		require("config.languages.csharp").setup()
	end

	if vim.fn.executable("python3") == 1 or vim.fn.executable("python") == 1 then
		require("config.languages.python").setup()
	end

	if vim.fn.executable("php") == 1 then
		require("config.languages.php").setup()
	end

	if vim.fn.executable("go") == 1 then
		require("config.languages.go").setup()
	end

	if vim.fn.executable("rustc") == 1 or vim.fn.executable("cargo") == 1 then
		require("config.languages.rust").setup()
	end

	if vim.fn.executable("clangd") == 1 then
		require("config.languages.cpp").setup()
	end

	if vim.fn.executable("dart") == 1 then
		require("config.languages.dart").setup()
	end

	-- 3. Lenguajes GENERALISTAS / INFRA (Carga directa si están disponibles)
	local general_lsps = {
		"dockerls",
		"bashls",
		"yamlls",
		"jsonls",
		"marksman",
		"gdscript",
		"cmake",
	}

	local ok, lspconfig = pcall(require, "lspconfig")
	if ok then
		for _, lsp in ipairs(general_lsps) do
			if lspconfig[lsp] then
				lspconfig[lsp].setup({})
			end
		end
	end
end

return M
