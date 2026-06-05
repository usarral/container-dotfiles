-- LSP setup with conditional language support via DEVPOD_LANG env var.
-- Mason auto-installs only the servers needed for the active language.
return {
	{ "mason-org/mason.nvim", opts = {} },

	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = { "mason-org/mason.nvim" },
		opts = function()
			local lang = require("config.lang")

			-- Base servers always available
			local servers = {
				"lua_ls",
				"marksman",
				"bashls",
				"jsonls",
				"yamlls",
				"dockerls",
			}

			if lang.has("node") then
				vim.list_extend(servers, { "vtsls", "eslint", "tailwindcss" })
			end
			if lang.has("python") then
				vim.list_extend(servers, { "pyright", "ruff" })
			end
			if lang.has("go") then
				vim.list_extend(servers, { "gopls" })
			end
			if lang.has("rust") then
				vim.list_extend(servers, { "rust_analyzer" })
			end
			if lang.has("php") then
				vim.list_extend(servers, { "intelephense" })
			end
			-- java is handled by nvim-jdtls, not mason-lspconfig

			return { ensure_installed = servers }
		end,
	},

	{
		"neovim/nvim-lspconfig",
		dependencies = { "saghen/blink.cmp", "mason-org/mason-lspconfig.nvim" },
		config = function()
			local lang = require("config.lang")
			local caps = require("blink.cmp").get_lsp_capabilities()

			-- Global capabilities for all servers
			vim.lsp.config("*", { capabilities = caps })

			-- Base server configs
			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						workspace = { checkThirdParty = false },
						telemetry = { enable = false },
					},
				},
			})

			local servers = { "lua_ls", "marksman", "bashls", "jsonls", "yamlls", "dockerls" }

			if lang.has("node") then
				vim.lsp.config("vtsls", {
					settings = {
						typescript = { preferences = { importModuleSpecifier = "relative" } },
					},
				})
				vim.list_extend(servers, { "vtsls", "eslint", "tailwindcss" })
			end
			if lang.has("python") then
				vim.list_extend(servers, { "pyright", "ruff" })
			end
			if lang.has("go") then
				vim.list_extend(servers, { "gopls" })
			end
			if lang.has("rust") then
				vim.list_extend(servers, { "rust_analyzer" })
			end
			if lang.has("php") then
				vim.list_extend(servers, { "intelephense" })
			end

			vim.lsp.enable(servers)

			-- Global LSP keymaps on attach
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local buf = args.buf
					vim.keymap.set("n", "gd", "<cmd>FzfLua lsp_definitions     jump_to_single_result=true<cr>", { buffer = buf, desc = "Go to definition" })
					vim.keymap.set("n", "gD", "<cmd>FzfLua lsp_declarations    jump_to_single_result=true<cr>", { buffer = buf, desc = "Go to declaration" })
					vim.keymap.set("n", "gr", "<cmd>FzfLua lsp_references       jump_to_single_result=true<cr>", { buffer = buf, desc = "References" })
					vim.keymap.set("n", "gi", "<cmd>FzfLua lsp_implementations  jump_to_single_result=true<cr>", { buffer = buf, desc = "Implementation" })
					vim.keymap.set("n", "gy", "<cmd>FzfLua lsp_typedefs         jump_to_single_result=true<cr>", { buffer = buf, desc = "Type definition" })
					vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = buf, desc = "Hover" })
					vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { buffer = buf, desc = "Rename" })
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = buf, desc = "Code action" })
					vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { buffer = buf, desc = "Diagnostics" })
					vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { buffer = buf, desc = "Next diagnostic" })
					vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { buffer = buf, desc = "Prev diagnostic" })
					vim.keymap.set("n", "<leader>fmt", function()
						vim.lsp.buf.format({ async = true })
					end, { buffer = buf, desc = "Format" })
				end,
			})
		end,
	},

	-- Java: nvim-jdtls (only loaded when DEVPOD_LANG includes "java")
	{
		"mfussenegger/nvim-jdtls",
		cond = function() return require("config.lang").has("java") end,
		ft = "java",
		config = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "java",
				callback = function()
					local jdtls = require("jdtls")
					local mason_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
					local launcher = vim.fn.glob(mason_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")

					if launcher == "" then
						vim.notify("jdtls not found. Run :MasonInstall jdtls", vim.log.levels.WARN)
						return
					end

					local workspace_dir = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
					local data_dir = vim.fn.stdpath("data") .. "/jdtls/workspaces/" .. workspace_dir

					-- Detect OS config dir
					local config_dir
					local sysname = vim.loop.os_uname().sysname
					if sysname == "Darwin" then
						config_dir = mason_path .. "/config_mac"
					elseif sysname:find("Windows") then
						config_dir = mason_path .. "/config_win"
					else
						config_dir = mason_path .. "/config_linux"
					end

					-- Spring Boot Tools bundles (si están instalados via Mason)
					local spring_path = vim.fn.stdpath("data") .. "/mason/packages/spring-boot-tools"
					local bundles = {}
					local spring_jar = vim.fn.glob(spring_path .. "/extension/jars/spring-tools-language-server-*.jar")
					if spring_jar ~= "" then
						vim.list_extend(bundles, { spring_jar })
					end

					local config = {
						cmd = {
							"java",
							"-Declipse.application=org.eclipse.jdt.ls.core.id1",
							"-Dosgi.bundles.defaultStartLevel=4",
							"-Declipse.product=org.eclipse.jdt.ls.core.product",
							"-Dlog.level=ALL",
							"-Xmx2g",
							"--add-modules=ALL-SYSTEM",
							"--add-opens", "java.base/java.util=ALL-UNNAMED",
							"--add-opens", "java.base/java.lang=ALL-UNNAMED",
							"-jar", launcher,
							"-configuration", config_dir,
							"-data", data_dir,
						},
						root_dir = jdtls.setup.find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),
						settings = { java = {} },
						init_options = { bundles = bundles },
					}
					jdtls.start_or_attach(config)
				end,
			})
		end,
	},
}
