local M = {}

function M:setup()
    local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
    local workspace_dir = vim.fn.stdpath("data") ..
        package.config:sub(1, 1) .. "jdtls-workspace" .. package.config:sub(1, 1) .. project_name

    -- See `:help vim.lsp.start` for an overview of the supported `config` options.
    local config = {
        name = "jdtls",


        -- `cmd` defines the executable to launch eclipse.jdt.ls.
        -- `jdtls` must be available in $PATH and you must have Python3.9 for this to work.
        --
        -- As alternative you could also avoid the `jdtls` wrapper and launch
        -- eclipse.jdt.ls via the `java` executable
        -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
        cmd = {
            "jdtls",
            "-data",
            workspace_dir,
        },


        -- `root_dir` must point to the root of your project.
        -- See `:help vim.fs.root`
        root_dir = vim.fs.root(0, {'pom.xml', 'gradlew', '.git', 'mvnw', 'src', 'target' }),


        -- Here you can configure eclipse.jdt.ls specific settings
        -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
        -- for a list of options
        settings = {
            java = {
                -- Importa proyectos automáticamente
                import = {
                    gradle = {
                        enabled = true
                    },
                    maven = {
                        enabled = true
                    }
                },
                -- Configuración de compilación Maven
                configuration = {
                    -- Actualiza la configuración automáticamente
                    updateBuildConfiguration = "automatic",
                    -- Usa Maven para compilar
                    maven = {
                        downloadSources = true,
                        updateSnapshots = true
                    }
                },
                -- Aumenta tolerancia en resolución de símbolos
                project = {
                    referencedLibraries = {
                        include = {"./**/*.jar"},
                        exclude = {"**/node_modules/**", "**/.git/**", "**/.venv/**", "**/build/**", "**/target/**"}
                    }
                },
                -- Evita errores de proyectos no presentes
                errors = {
                    incompleteClasspath = {
                        severity = "ignore"
                    }
                }
            }
        },


        -- This sets the `initializationOptions` sent to the language server
        -- If you plan on using additional eclipse.jdt.ls plugins like java-debug
        -- you'll need to set the `bundles`
        --
        -- See https://codeberg.org/mfussenegger/nvim-jdtls#java-debug-installation
        --
        -- If you don't plan on any eclipse.jdt.ls plugins you can remove this
        init_options = {
            bundles = {}
        },
    }
    require('jdtls').start_or_attach(config)
end

return M
