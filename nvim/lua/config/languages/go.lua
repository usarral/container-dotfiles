local M = {}
function M.setup()
    if vim.fn.executable("go") == 1 then
        require("config.languages.utils").setup_lsp("gopls")
    end
end
return M
