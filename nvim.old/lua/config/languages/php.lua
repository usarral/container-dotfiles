local M = {}
function M.setup()
    if vim.fn.executable("php") == 1 then
        require("config.languages.utils").setup_lsp("intelephense")
    end
end
return M
