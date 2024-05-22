local helpers = require("null-ls.helpers")
local null_ls = require("null-ls")

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
    debug = false,
    sources = {
        --[[ null_ls.builtins.diagnostics.eslint_d.with({ ]]
        --[[ 	diagnostics_format = '[eslint] #{m}\n(#{c})' ]]
        --[[ }), ]]
        -- formatting.stylua,
        -- formatting.prettier.with({ extra_args = {} }),
        -- formatting.latexindent.with({
        --     extra_args = { "-l=" .. vim.fn.expand("$HOME/.config/indentconfig.yaml") },
        -- }),
        -- formatting.isort.with({ extra_args = { "--profile", "black", "-l", "100" } }),
        -- formatting.black.with({ extra_args = { "--fast", "--line-length", "100" } }),
        -- formatting.ruff_format.with({ extra_args = { "--line-length", "100" } }),
        diagnostics.mypy.with({
            extra_args = {
                "--ignore-missing-imports",
                -- "--install-types",
                "--disallow-untyped-defs",
                "--warn-redundant-casts",
                "--warn-unused-ignores",
            },
        }),
        diagnostics.cppcheck,
        --[[ formatting.stylua, ]]
        -- diagnostics.flake8
    },
})

-- local ruff_isort = {
--     name = "ruff_isort",
--     method = null_ls.methods.FORMATTING,
--     filetypes = { "python" },
--     generator = null_ls.formatter({
--         command = "ruff",
--         args = {
--             "check",
--             "--fix",
--             "--select",
--             "I",
--             "--line-length",
--             "100",
--             "--stdin-filename",
--             "$FILENAME",
--             "-",
--         },
--         to_stdin = true,
--     }),
--     factory = helpers.formatter_factory,
-- }
--
-- null_ls.register(ruff_isort)
