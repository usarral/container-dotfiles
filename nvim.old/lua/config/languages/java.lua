local M = {}

function M.setup()
	-- Solo configurar si java está instalado
	if vim.fn.executable("java") == 1 then
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "java",
			callback = function(args)
				require("jdtls.jdtls_setup").setup()
			end,
		})

		-- Configuración de mvnd si se desea usar como wrapper
		if vim.fn.executable("mvnd") == 1 then
			-- Puedes añadir integraciones específicas de mvnd aquí
		end
	end
end

return M
