local M = {}

M.setup = function()
    local lspconfig = require("lspconfig")
    local configs = require("lspconfig.configs")

    configs.jails = {
        default_config = {
            cmd = { "jails" },
            filetypes = { "jai" },
            root_dir = lspconfig.util.root_pattern("build.jai"),
            settings = {},
        },
    }
end

return M
