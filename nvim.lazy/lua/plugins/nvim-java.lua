return {
  "nvim-java/nvim-java",
  config = false,
  dependencies = {
    {
      "neovim/nvim-lspconfig",
      opts = {
        servers = {
          -- Your JDTLS configuration goes here
          jdtls = {
            settings = {
              java = {
                configuration = {
                  runtimes = {
                    {
                      name = "JavaSE-24",
                      path = "/home/csesmau/.sdkman/candidates/java/24-amzn",
                    },
                    {
                      name = "Java-8",
                      path = "/home/csesmau/.sdkman/candidates/java/8.0.442-amzn",
                    },
                  },
                },
              },
            },
          },
        },
        setup = {
          jdtls = function()
            --Your nvim-java configuration goes here
            require("java").setup({
              root_markers = {
                "settings.gradle",
                "settings.gradle.kts",
                "pom.xml",
                "build.gradle",
                "mvnw",
                "gradlew",
                "build.gradle",
                "build.gradle.kts",
              },
            })
          end,
        },
      },
    },
  },
}
