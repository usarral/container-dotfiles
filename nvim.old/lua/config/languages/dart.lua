local M = {}
function M.setup()
    if vim.fn.executable("dart") == 1 then
        require("config.languages.utils").setup_lsp("dartls")
    end
end
return M
