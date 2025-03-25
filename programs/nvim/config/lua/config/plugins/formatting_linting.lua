return {
    {
        "nvimtools/none-ls.nvim",
        lazy = true,
    },

    {
        "stevearc/conform.nvim",
        lazy = true,
        config = function()
            vim.g.disable_autoformat = false

            require("conform").setup({
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
                    -- Use a sub-list to run only the first available formatter
                    javascript = { { "prettierd", "prettier" } },
                    zig = { "zigfmt" },
                    go = { "gofmt" },
                },
                format_on_save = function(bufnr)
                    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                        return
                    end
                    return { timeout_ms = 500, lsp_format = "fallback" }
                end,
            })
        end,
    },

    {
        "MunifTanjim/prettier.nvim",
        -- ft = { "html", "css", "js", "ts", "jsx", "tsx" },
        lazy = true,
        config = function()
            require("prettier").setup({
                bin = "prettier",
                filetypes = {
                    "css",
                    "javascript",
                    "javascriptreact",
                    "typescript",
                    "typescriptreact",
                    "json",
                    "scss",
                    "less",
                },
            })
        end,
    },
}
