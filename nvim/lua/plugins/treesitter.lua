return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local lang = require("config.lang")

			local parsers = {
				"lua", "vim", "vimdoc",
				"markdown", "markdown_inline",
				"bash", "json", "yaml", "toml", "dockerfile",
			}

			if lang.has("node") then
				vim.list_extend(parsers, { "javascript", "typescript", "tsx", "html", "css" })
			end
			if lang.has("java") then
				vim.list_extend(parsers, { "java" })
			end
			if lang.has("python") then
				vim.list_extend(parsers, { "python" })
			end
			if lang.has("go") then
				vim.list_extend(parsers, { "go", "gomod", "gowork" })
			end
			if lang.has("rust") then
				vim.list_extend(parsers, { "rust" })
			end
			if lang.has("php") then
				vim.list_extend(parsers, { "php" })
			end

			require("nvim-treesitter.configs").setup({
				ensure_installed = parsers,
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
}
