local status_ok, lsp_installer = pcall(require, "mason")
if not status_ok then
    return
end

lsp_installer.setup()
local lspconfig = require("lspconfig")
local mason_lspconfig = require("mason-lspconfig")

local servers = {
    -- "ocamllsp",
    -- "ocamlformat",
    "gopls",
    "ruff",
    "basedpyright",
    -- "pyright",
    "arduino_language_server",
    -- "pylyzer",
    "ltex",
    -- "jedi_language_server",
    -- "rust_analyzer",
    "texlab",
    "jsonls",
    "lua_ls",
    "ts_ls",
    "cssls",
    "emmet_ls",
    "html",
    "marksman",
    "ols",
    -- "taplo",
    -- "yamlls",
    "marksman",
    "kotlin_language_server",
    "bashls",
    -- "tailwindcss",
    "zls",
    "nil_ls",
    "clangd",
}

mason_lspconfig.setup({
    ensure_installed = servers,
})
-- table.insert(servers, "rust_analyzer")

-- local cargotomllsp_cfg = require("config.lsp.cargotomllsp")
-- cargotomllsp_cfg.setup_cargotomllsp()

for _, server in pairs(servers) do
    local capabilities = require("config.lsp.handlers").capabilities
    local on_attach = require("config.lsp.handlers").on_attach
    local opts = {
        capabilities = capabilities,
        on_attach = on_attach,
    }

    local has_custom_opts, server_custom_opts = pcall(require, "config.lsp.settings." .. server)
    if has_custom_opts then
        opts = vim.tbl_deep_extend("force", opts, server_custom_opts)
    end

    if server == "ltex" then
        require("lspconfig").ltex.setup({
            on_attach = function(client, bufnr)
                -- your other on_attach functions.
                require("ltex_extra").setup({
                    load_langs = { "pl-PL", "en-US" }, -- table <string> : languages for witch dictionaries will be loaded
                    init_check = true, -- boolean : whether to load dictionaries on startup
                    path = nil, -- string : path to store dictionaries. Relative path uses current working directory
                    log_level = "warn", -- string : "none", "trace", "debug", "info", "warn", "error", "fatal"
                })
            end,
            settings = {
                ltex = {
                    checkFrequency = "save",
                    language = "auto",
                },
            },
        })

        goto continue
    end

    if server == "basedpyright" then
        local settings = {
            on_attach = opts.on_attach,
            settings = {
                basedpyright = {
                    disableOrganizeImports = true, -- Using Ruff
                    analysis = {
                        ignore = { "*" }, -- Using Ruff
                        typeCheckingMode = "off", -- Using mypy
                        diagnosticMode = "workspace",
                    },
                },
            },
        }
        require("lspconfig").basedpyright.setup(settings)
        goto continue
    end

    if server == "pyright" then
        local settings = {
            on_attach = opts.on_attach,
            settings = {
                pyright = {
                    disableOrganizeImports = true, -- Using Ruff
                },
                python = {
                    analysis = {
                        ignore = { "*" }, -- Using Ruff
                        typeCheckingMode = "off", -- Using mypy
                    },
                },
            },
        }
        require("lspconfig").pyright.setup(settings)
        goto continue
    end

    lspconfig[server].setup(opts)
    ::continue::
end
