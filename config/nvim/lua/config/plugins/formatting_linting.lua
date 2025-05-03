return {
    -- {
    --     "nvimtools/none-ls.nvim",
    --     lazy = true,
    -- },

    {
        "stevearc/conform.nvim",
        event = "VeryLazy",
        config = function()
            local conform = require("conform")

            conform.setup({
                formatters = {
                    ruff_format = {
                        inherit = false,
                        stdin = true,
                        command = "ruff",
                        args = {
                            "format",
                            "--line-length",
                            "100",
                            "--stdin-filename",
                            "$FILENAME",
                            "-",
                        },
                    },
                    ruff_isort = {
                        inherit = false,
                        stdin = true,
                        command = "ruff",
                        args = {
                            "check",
                            "--fix",
                            "--select",
                            "I",
                            "--line-length",
                            "100",
                            "--stdin-filename",
                            "$FILENAME",
                            "-",
                        },
                    },
                },
                formatters_by_ft = {
                    lua = { "stylua" },
                    python = { "ruff_isort", "ruff_format" },
                    javascript = { { "prettierd", "prettier" } },
                    zig = { "zigfmt" },
                    go = { "gofmt" },
                    ocaml = { "ocamlformat", "ocp-indent" },
                },
                format_on_save = function(bufnr)
                    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                        return
                    end
                    return { timeout_ms = 500, lsp_format = "fallback" }
                end,
            })

            vim.keymap.set("n", "\\", function()
                conform.format({ async = true })
            end)
        end,
    },
}
