local M = {}

function M.setup()
	local lspconfig = require("lspconfig")

	-- Configurar ts_ls
	lspconfig.ts_ls.setup({
		on_attach = function(client)
			vim.opt.tabstop = 2
			vim.opt.shiftwidth = 2
			vim.opt.softtabstop = 2
		end,
	})

	-- Otros setups específicos de Node/pnpm si los tienes
	if vim.fn.executable("pnpm") == 1 then
		-- Configuración especial si pnpm está presente
	end
end

return M
