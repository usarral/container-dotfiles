local M = {}

function M.setup()
	local config = {
		on_init = function(client)
			if client.workspace_folders then
				local path = client.workspace_folders[1].name
				if
					path ~= vim.fn.stdpath("config")
					and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
				then
					return
				end
			end

			client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
				runtime = {
					version = "LuaJIT",
					path = {
						"lua/?.lua",
						"lua/?/init.lua",
					},
				},
				workspace = {
					checkThirdParty = false,
					library = {
						vim.env.VIMRUNTIME,
					},
				},
			})
		end,
		settings = {
			Lua = {
				diagnostics = {
					disable = {
						"undefined-global",
						"undefined-field",
					},
				},
			},
		},
	}

	-- Intentar usar la nueva API de 0.11, si no, usar lspconfig tradicional
	if vim.fn.has("nvim-0.11") == 1 then
		if vim.lsp.config and vim.lsp.config.lua_ls then
			vim.lsp.config.lua_ls.setup(config)
		else
			-- Si no está en vim.lsp.config, intentamos cargar lspconfig
			-- pero solo si realmente es necesario.
			local ok, lspconfig = pcall(require, "lspconfig")
			if ok then
				lspconfig.lua_ls.setup(config)
			end
		end
	else
		require("lspconfig").lua_ls.setup(config)
	end
end

return M
