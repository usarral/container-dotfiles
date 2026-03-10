local M = {}

-- Función para instalar y configurar un LSP con Mason
function M.setup_lsp(server_name, config)
	local mason_lspconfig = require("mason-lspconfig")

	-- Forzar instalación si no está presente
	local is_installed = #vim.fn.glob(vim.fn.stdpath("data") .. "/mason/packages/" .. server_name) > 0

	if not is_installed then
		vim.cmd("MasonInstall " .. server_name)
	end

	-- Configurar con lspconfig (más robusto mientras se estabiliza la API de 0.11+)
	local ok, lspconfig = pcall(require, "lspconfig")
	if ok and lspconfig[server_name] then
		lspconfig[server_name].setup(config or {})
	end
end

return M
