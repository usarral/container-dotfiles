local M = {}

function M.setup()
	if vim.fn.executable("node") == 1 or vim.fn.executable("pnpm") == 1 then
		require("config.languages.utils").setup_lsp("ts_ls", {
			on_attach = function(client)
				vim.opt.tabstop = 2
				vim.opt.shiftwidth = 2
				vim.opt.softtabstop = 2
			end,
		})
	end
end

return M
