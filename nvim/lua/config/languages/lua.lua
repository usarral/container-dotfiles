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

	-- Usar la nueva API de Neovim 0.11 si está disponible, si no, usar lspconfig
	if vim.lsp.config then
		vim.lsp.config.lua_ls = config
	else
		local ok, lspconfig = pcall(require, "lspconfig")
		if ok then
			lspconfig.lua_ls.setup(config)
		end
	end
end

return M
