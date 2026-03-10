local M = {}

function M.setup()
	local lspconfig = require("lspconfig")

	-- Solo configurar si el servidor está disponible
	if vim.fn.executable("csharpls") == 1 or vim.fn.executable("dotnet") == 1 then
		lspconfig.csharpls.setup({
			handlers = {
				["textDocument/definition"] = require("csharpls_extended").handler,
				["textDocument/typeDefinition"] = require("csharpls_extended").handler,
			},
		})
	end
end

return M
