local M = {}

function M.setup()
	local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
	local workspace_dir = vim.fn.stdpath("data")
		.. package.config:sub(1, 1)
		.. "jdtls-workspace"
		.. package.config:sub(1, 1)
		.. project_name

	-- Detectar ruta de Java actual
	local java_path = ""
	if vim.env.JAVA_HOME then
		java_path = vim.env.JAVA_HOME
	else
		local handle = io.popen("readlink -f $(which java) | sed 's:/bin/java::'")
		if handle then
			java_path = handle:read("*a"):gsub("%s+", "")
			handle:close()
		end
	end

	-- See `:help vim.lsp.start` for an overview of the supported `config` options.
	local config = {
		name = "jdtls",

		-- `cmd` defines the executable to launch eclipse.jdt.ls.
		-- `jdtls` must be available in $PATH and you must have Python3.9 for this to work.
		cmd = {
			"jdtls",
			"-data",
			workspace_dir,
		},

		-- `root_dir` must point to the root of your project.
		root_dir = vim.fs.root(0, { "pom.xml", "gradlew", ".git", "mvnw", "src", "target" }),

		-- Here you can configure eclipse.jdt.ls specific settings
		settings = {
			java = {
				-- Importa proyectos automáticamente
				import = {
					gradle = {
						enabled = true,
					},
					maven = {
						enabled = true,
					},
				},
				-- Configuración de runtimes para detección de JDK
				configuration = {
					runtimes = {
						{
							name = "JavaSE-17",
							path = java_path,
							default = true,
						},
					},
					-- Actualiza la configuración automáticamente
					updateBuildConfiguration = "automatic",
					-- Usa Maven para compilar
					maven = {
						downloadSources = true,
						updateSnapshots = true,
					},
				},
				-- Aumenta tolerancia en resolución de símbolos
				project = {
					referencedLibraries = {
						include = { "./**/*.jar" },
						exclude = { "**/node_modules/**", "**/.git/**", "**/.venv/**", "**/build/**", "**/target/**" },
					},
				},
				-- Evita errores de proyectos no presentes
				errors = {
					incompleteClasspath = {
						severity = "ignore",
					},
				},
			},
		},

		-- Bundles para depuración (vacío por defecto)
		init_options = {
			bundles = {},
		},
	}
	require("jdtls").start_or_attach(config)
end

return M
