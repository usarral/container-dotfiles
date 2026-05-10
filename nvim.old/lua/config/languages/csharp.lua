local M = {}

M.plugin = {
	"Decodetalkers/csharpls-extended-lsp.nvim",
	ft = { "cs" },
	cond = function()
		return vim.fn.executable("csharpls") == 1 or vim.fn.executable("dotnet") == 1
	end,
}

function M.setup()
	local config = {
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
	}

	-- Solo configurar si el servidor está disponible
	if vim.fn.executable("csharpls") == 1 or vim.fn.executable("dotnet") == 1 then
		if vim.fn.has("nvim-0.11") == 1 then
			vim.lsp.config.csharpls.setup(config)
		else
			require("lspconfig").csharpls.setup(config)
		end
	end
end

return M
