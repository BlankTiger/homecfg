local helpers = require("null-ls.helpers")
local null_ls = require("null-ls")

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

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
        -- diagnostics.mypy.with({
        --     extra_args = {
        --         "--ignore-missing-imports",
        --         -- "--install-types",
        --         "--disallow-untyped-defs",
        --         "--warn-redundant-casts",
        --         "--warn-unused-ignores",
        --     },
        -- }),
        code_actions.refactoring,
        -- diagnostics.mypy.with({
        --     command = "dmypy",
        --     args = function(params)
        --         local t1 = {
        --             "run",
        --             "--timeout",
        --             "5000000",
        --             "--",
        --             "--hide-error-context",
        --             "--no-color-output",
        --             "--show-absolute-path",
        --             "--show-column-numbers",
        --             "--show-error-codes",
        --             "--no-error-summary",
        --             "--no-pretty",
        --             "--cache-fine-grained",
        --             "--sqlite-cache",
        --             "--ignore-missing-imports",
        --             "--install-types",
        --             "--disallow-untyped-defs",
        --             "--warn-redundant-casts",
        --             "--warn-unused-ignores",
        --             --'--shadow-file',
        --             --params.bufname,
        --             --params.temp_path,
        --             --params.bufname,
        --         }
        --         local t2 = vim.lsp.buf.list_workspace_folders()
        --         for _, v in ipairs(t2) do
        --             table.insert(t1, v)
        --         end
        --         return t1
        --     end,
        --     timeout = 500000000,
        --     -- Do not run in fugitive windows, or when inside of a .venv area
        --     runtime_condition = function(params)
        --         if
        --             string.find(params.bufname, "fugitive") or string.find(params.bufname, ".venv")
        --         then
        --             return false
        --         else
        --             return true
        --         end
        --     end,
        -- }),

        diagnostics.cppcheck,
        -- diagnostics.eslint_d,
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
