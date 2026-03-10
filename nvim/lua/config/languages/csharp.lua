local M = {}

M.plugin = {
	"Decodetalkers/csharpls-extended-lsp.nvim",
	ft = { "cs" },
	cond = function()
		return vim.fn.executable("csharpls") == 1 or vim.fn.executable("dotnet") == 1
	end,
}

function M.setup()
	local lspconfig = require("lspconfig")

	-- Solo configurar si el servidor está disponible
	if vim.fn.executable("csharpls") == 1 or vim.fn.executable("dotnet") == 1 then
		lspconfig.csharpls.setup({
			handlers = {
				["textDocument/definition"] = function(...)
					local ok, cse = pcall(require, "csharpls_extended")
					if ok then
						return cse.handler(...)
					else
						-- Fallback al handler por defecto si el plugin falla
						return vim.lsp.handlers["textDocument/definition"](...)
					end
				end,
				["textDocument/typeDefinition"] = function(...)
					local ok, cse = pcall(require, "csharpls_extended")
					if ok then
						return cse.handler(...)
					else
						-- Fallback al handler por defecto si el plugin falla
						return vim.lsp.handlers["textDocument/typeDefinition"](...)
					end
				end,
			},
		})
	end
end

return M
