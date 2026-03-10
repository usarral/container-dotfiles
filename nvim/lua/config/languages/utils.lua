local M = {}

-- Función para instalar y configurar un LSP con Mason
function M.setup_lsp(server_name, config)
	local mason_lspconfig = require("mason-lspconfig")

	-- Forzar instalación si no está presente
	local is_installed = #vim.fn.glob(vim.fn.stdpath("data") .. "/mason/packages/" .. server_name) > 0

	if not is_installed then
		vim.cmd("MasonInstall " .. server_name)
	end

	-- Configurar con la nueva API de 0.11 o lspconfig tradicional
	if vim.lsp.config then
		vim.lsp.config[server_name] = config or {}
	else
		local ok, lspconfig = pcall(require, "lspconfig")
		if ok and lspconfig[server_name] then
			lspconfig[server_name].setup(config or {})
		end
	end
end

return M
