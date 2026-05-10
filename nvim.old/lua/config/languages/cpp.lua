local M = {}
function M.setup()
    if vim.fn.executable("clangd") == 1 then
        require("config.languages.utils").setup_lsp("clangd")
    end
end
return M
