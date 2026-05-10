local M = {}
function M.setup()
    if vim.fn.executable("python3") == 1 or vim.fn.executable("python") == 1 then
        require("config.languages.utils").setup_lsp("pyright")
    end
end
return M
