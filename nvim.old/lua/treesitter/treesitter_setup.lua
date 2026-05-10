local M = {}

function M:setup()
    require 'nvim-treesitter.install'.compilers = { "clang", "gcc", "cc", "cl" }
    require('nvim-treesitter.configs').setup {
        ensure_installed = { "c", "cpp", "java", "javascript", "dart", "python", "html", "css", "kotlin", "bash", "cmake", "make", "php", "lua", "rust", "json", "go", "markdown", "markdown_inline", "csv", "diff", "dockerfile", "gitignore", "typescript", "yaml", "groovy" },
        auto_install = true,
        highlight = { enable = true },
    }

    vim.api.nvim_create_autocmd('FileType', {
        pattern = { "c", "cpp", "java", "javascript", "dart", "python", "html", "css", "kotlin", "bash", "cmake", "make", "php", "lua", "rust", "json", "go", "markdown", "csv", "diff", "dockerfile", "gitignore", "typescript", "yaml", "groovy" },
        callback = function()
            local has_parser = pcall(vim.treesitter.start)
            if not has_parser then
                vim.notify("TreeSitter parser not available for " .. vim.bo.filetype, vim.log.levels.WARN)
            end
        end,
    })
end

return M
