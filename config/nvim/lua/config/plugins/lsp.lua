local servers = {
    "astro",
    "gopls",
    "ruff",
    "basedpyright",
    "lua_ls",
    "ts_ls",
    "html",
    "marksman",
    "ols",
    "bashls",
    -- NOTE: install from source into ~/.local/bin instead to follow nightly zig
    -- "zls",
    "nil_ls",
    "clangd",
    "ocamllsp",
    -- "gleam",
}

function table.contains(table, element)
    for _, value in pairs(table) do
        if value == element then
            return true
        end
    end
    return false
end

return {
    {
        "williamboman/mason-lspconfig.nvim",
        lazy = true,
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = servers,
                automatic_installation = {
                    exclude = {
                        "zls",
                        "gleam",
                    },
                },
            })
        end,
    },

    {
        "williamboman/mason.nvim",
        lazy = true,
        config = function()
            require("mason").setup()
        end,
    },

    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        cmd = { "Mason", "LspInfo", "LspInstall", "LspUninstall" },
        config = function()
            local function lsp_highlight_document(client)
                local ok, illuminate = pcall(require, "illuminate")
                if ok then
                    illuminate.on_attach(client)
                end
            end

            local function lsp_keymaps(bufnr)
                local opts = { noremap = true, silent = true }
                vim.api.nvim_buf_set_keymap(
                    bufnr,
                    "n",
                    "gD",
                    "<cmd>lua vim.lsp.buf.declaration()<CR>zm",
                    opts
                )
                vim.api.nvim_buf_set_keymap(
                    bufnr,
                    "n",
                    "gd",
                    "<cmd>lua vim.lsp.buf.definition()<CR>zm",
                    opts
                )
                vim.api.nvim_buf_set_keymap(
                    bufnr,
                    "n",
                    "<leader>k",
                    "<cmd>lua vim.lsp.buf.hover()<CR>",
                    opts
                )
                vim.api.nvim_buf_set_keymap(
                    bufnr,
                    "n",
                    "gi",
                    "<cmd>lua vim.lsp.buf.implementation()<CR>zm",
                    opts
                )
                vim.api.nvim_buf_set_keymap(
                    bufnr,
                    "n",
                    "gr",
                    "<cmd>lua vim.lsp.buf.references()<CR>",
                    opts
                )
                vim.api.nvim_buf_set_keymap(
                    bufnr,
                    "n",
                    "[d",
                    '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>',
                    opts
                )
                vim.api.nvim_buf_set_keymap(
                    bufnr,
                    "n",
                    "]d",
                    '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>',
                    opts
                )
                vim.api.nvim_buf_set_keymap(
                    bufnr,
                    "n",
                    "gl",
                    '<cmd>lua vim.diagnostic.open_float({ border = "rounded" })<CR>',
                    opts
                )
                vim.api.nvim_buf_set_keymap(
                    bufnr,
                    "n",
                    "<leader>.",
                    "<cmd>lua vim.diagnostic.setloclist()<CR>",
                    opts
                )
                vim.cmd(
                    [[ command! Format execute "<cmd>lua require('conform').format({ async = true })<cr>" ]]
                )
            end

            local on_attach = function(client, bufnr)
                client.server_capabilities.documentFormattingProvider = false
                client.server_capabilities.semanticTokensProvider = nil
                lsp_keymaps(bufnr)
                lsp_highlight_document(client)
            end

            local function setup_cargotomllsp()
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

            local function setup_diagnostics()
                local signs = {
                    { name = "DiagnosticSignError", text = "" },
                    { name = "DiagnosticSignWarn", text = "" },
                    { name = "DiagnosticSignHint", text = "" },
                    { name = "DiagnosticSignInfo", text = "" },
                }

                for _, sign in ipairs(signs) do
                    vim.fn.sign_define(
                        sign.name,
                        { texthl = sign.name, text = sign.text, numhl = "" }
                    )
                end

                local config = {
                    -- disable virtual text
                    virtual_text = true,
                    -- show signs
                    signs = {
                        active = signs,
                    },
                    update_in_insert = true,
                    underline = true,
                    severity_sort = true,
                    float = {
                        focusable = false,
                        -- style = "minimal",
                        border = "rounded",
                        source = "always",
                        header = "",
                        prefix = "",
                    },
                }

                vim.diagnostic.config(config)
            end
            if table.contains(servers, "cargotomllsp") then
                setup_cargotomllsp()
            end

            local custom_server_settings = {
                basedpyright = {
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
                },
                emmet_ls = {
                    filetypes = {
                        "html",
                        "typescriptreact",
                        "javascriptreact",
                        "css",
                        "sass",
                        "scss",
                        "less",
                    },
                    init_options = {
                        html = {
                            options = {
                                -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
                                ["bem.enabled"] = true,
                            },
                        },
                    },
                },
                lua_ls = {
                    settings = {
                        Lua = {
                            diagnostics = {
                                globals = { "vim" },
                            },
                            workspace = {
                                library = {
                                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                                    [vim.fn.stdpath("config") .. "/lua"] = true,
                                },
                            },
                        },
                    },
                },
                cargotomllsp = {
                    filetypes = { "toml" },
                },
            }

            local lspconfig = require("lspconfig")
            local opts = {
                capabilities = require("blink.cmp").get_lsp_capabilities(),
                on_attach = on_attach,
            }

            -- local _servers = servers
            -- table.insert(_servers, "zls")
            for _, server in pairs(servers) do
                local server_opts =
                    vim.tbl_deep_extend("force", opts, custom_server_settings[server] or {})
                lspconfig[server].setup(server_opts)
            end
            -- TODO: factor this out next time this needs to happen
            local server_opts =
                vim.tbl_deep_extend("force", opts, custom_server_settings["zls"] or {})
            lspconfig["zls"].setup(server_opts)
            server_opts = vim.tbl_deep_extend("force", opts, custom_server_settings["gleam"] or {})
            lspconfig["gleam"].setup(server_opts)

            setup_diagnostics()
        end,
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
    },

    {
        "folke/neodev.nvim",
        ft = "lua",
        config = function()
            require("neodev").setup({})
        end,
        opts = {},
    },

    {
        "mrcjkb/rustaceanvim",
        ft = "rs",
        version = "^5", -- Recommended
        lazy = false, -- This plugin is already lazy
    },
}
