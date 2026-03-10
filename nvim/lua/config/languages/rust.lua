local M = {}
function M.setup()
    if vim.fn.executable("rustc") == 1 or vim.fn.executable("cargo") == 1 then
        require("config.languages.utils").setup_lsp("rust_analyzer")
    end
end
return M
