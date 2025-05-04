local M = {}

M.setup = function()
    local lspconfig = require("lspconfig")
    local configs = require("lspconfig.configs")

    if vim.fn.executable("cargotomllsp") == 0 then
        vim.api.nvim_echo({ { "Installing cargotomllsp..." } }, true, {})
        local on_exit = function(obj)
            print(obj.code)
            print(obj.signal)
            print(obj.stdout)
            print(obj.stderr)
        end
        vim.system({ "cargo", "install", "cargotomllsp" }, { text = true }, on_exit)
    end

    configs.cargotomllsp = {
        default_config = {
            cmd = { "cargotomllsp" },
            filetypes = { "toml" },
            root_dir = lspconfig.util.root_pattern("Cargo.toml"),
            settings = {},
        },
    }
end

return M
