local servers = {
    "gopls",
    "ruff",
    "basedpyright",
    "lua_ls",
    "ts_ls",
    "html",
    "ols",
    "bashls",
    "clangd",
    "ocamllsp",
}

local non_mason_servers = {
    "zls",
    "gleam",
}

local servers_lists = { servers, non_mason_servers }

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
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        cmd = { "Mason", "LspInfo", "LspInstall", "LspUninstall" },
        dependencies = {
            {
                "williamboman/mason.nvim",
                config = function()
                    require("mason").setup()
                end,
            },
            {
                "williamboman/mason-lspconfig.nvim",
                config = function()
                    require("mason-lspconfig").setup({
                        ensure_installed = servers,
                        automatic_installation = {
                            exclude = non_mason_servers,
                        },
                    })
                end,
            },
        },
        config = function()
            local diagnostic = vim.diagnostic
            local codelens = vim.lsp.codelens
            local buf = vim.lsp.buf
            local set = vim.keymap.set

            local func_map = {
                declaration = function()
                    buf.declaration()
                    vim.cmd("norm zz")
                end,
                definition = function()
                    buf.definition()
                    vim.cmd("norm zz")
                end,

                implementation = function()
                    buf.implementation()
                    vim.cmd("norm zz")
                end,
                diag_goto_prev = function()
                    diagnostic.jump({ count = -1, float = true })
                    vim.cmd("norm zz")
                end,
                diag_goto_next = function()
                    diagnostic.jump({ count = 1, float = true })
                    vim.cmd("norm zz")
                end,
            }

            local on_attach = function(client, _bufnr)
                client.server_capabilities.documentFormattingProvider = false
                client.server_capabilities.semanticTokensProvider = nil
            end

            local signs_text = {
                -- [vim.diagnostic.severity.ERROR] = "",
                -- [vim.diagnostic.severity.WARN] = "",
                -- [vim.diagnostic.severity.HINT] = "",
                -- [vim.diagnostic.severity.INFO] = "",
                [vim.diagnostic.severity.ERROR] = "",
                [vim.diagnostic.severity.WARN] = "",
                [vim.diagnostic.severity.HINT] = "",
                [vim.diagnostic.severity.INFO] = "",
            }
            local signs_numhl = {
                [vim.diagnostic.severity.ERROR] = "ErrorMsg",
                [vim.diagnostic.severity.WARN] = "WarningMsg",
                [vim.diagnostic.severity.HINT] = "HintMsg",
                [vim.diagnostic.severity.INFO] = "InfoMsg",
            }

            local diagnostics_config = {
                virtual_text = true,
                signs = {
                    text = signs_text,
                    numhl = signs_numhl,
                },
                -- annoying when in insert mode
                update_in_insert = false,
                underline = true,
                severity_sort = true,
                float = {
                    focusable = false,
                    border = "rounded",
                    source = "always",
                    header = "",
                    prefix = "",
                },
            }

            local function setup_diagnostics(diagnostics_hidden)
                local config = diagnostics_config

                if diagnostics_hidden then
                    config = vim.tbl_deep_extend("force", diagnostics_config, {
                        virtual_text = false,
                        signs = false,
                        underline = false,
                    })
                end

                vim.diagnostic.config(config)
            end

            if table.contains(servers, "cargotomllsp") then
                require("user.cargotomllsp").setup()
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

            for _, list in ipairs(servers_lists) do
                for _, server in ipairs(list) do
                    local server_opts =
                        vim.tbl_deep_extend("force", opts, custom_server_settings[server] or {})
                    lspconfig[server].setup(server_opts)
                end
            end

            setup_diagnostics(vim.g.lsp_diagnostics_hidden)

            -- keymaps
            set("n", "<leader>li", "<cmd>LspInfo<cr>", vim.g.n_opts)
            set("n", "<leader>lI", "<cmd>LspInstallInfo<cr>", vim.g.n_opts)

            set("n", "<leader>ll", codelens.run)
            set("n", "<leader>lr", buf.rename)
            set("n", "<leader>la", buf.code_action)
            set("n", "<leader>lq", diagnostic.setloclist)
            set("n", "gl", diagnostic.open_float)
            set("n", "gr", buf.references)
            set("n", "gD", func_map.declaration)
            set("n", "gd", func_map.definition)
            set("n", "gi", func_map.implementation)
            set("n", "[d", func_map.diag_goto_prev)
            set("n", "]d", func_map.diag_goto_next)

            -- toggle diagnostics
            set("n", "<leader>lv", function()
                if vim.g.lsp_diagnostics_hidden == nil then
                    vim.g.lsp_diagnostics_hidden = false
                end
                setup_diagnostics(vim.g.lsp_diagnostics_hidden)
                vim.g.lsp_diagnostics_hidden = not vim.g.lsp_diagnostics_hidden
            end)

            set("n", "<leader>lR", function()
                vim.api.nvim_command("LspRestart")
                vim.diagnostic.reset()
            end, vim.g.n_opts)
        end,
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
        version = "^5",
        lazy = false,
    },
}
