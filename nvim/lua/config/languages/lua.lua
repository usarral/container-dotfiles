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

	-- Usar lspconfig para la configuración (maneja el bootstrapping de forma más completa)
	local ok, lspconfig = pcall(require, "lspconfig")
	if ok then
		lspconfig.lua_ls.setup(config)
	end
end

return M
