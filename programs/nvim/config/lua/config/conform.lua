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
    },
    format_on_save = { timeout_ms = 500, lsp_fallback = true },
})
