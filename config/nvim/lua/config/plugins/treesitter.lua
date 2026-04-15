local function toggle_context()
    require("treesitter-context").toggle()
end

return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre" },
    lazy = true,
    branch = "main",
    build = ":TSUpdate",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
        {
            "nvim-treesitter/nvim-treesitter-context",
            config = function()
                toggle_context()
            end,
        },
    },
    config = function()
        local t = require("nvim-treesitter")

        local parsers_loaded = {}
        local parsers_pending = {}
        local parsers_failed = {}

        local namespace = vim.api.nvim_create_namespace("treesitter.async")

        local function start(buffer, language)
            local ok = pcall(vim.treesitter.start, buffer, language)
            if ok then
                vim.bo[buffer].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end

            return ok
        end

        vim.api.nvim_create_autocmd("User", {
            pattern = "LazyDone",
            once = true,
            callback = function()
                t.install({
                    "c",
                    "cpp",
                    "lua",
                    "vim",
                    "vimdoc",
                    "query",
                    "rust",
                    "python",
                    "yaml",
                    "toml",
                    "hlsl",
                    "zig",
                    "dapui_breakpoints",
                    "dap-repl",
                    "dap-repl",
                    "dapui_scopes",
                    "dapui_stacks",
                    "dapui_watches",
                    "dapui_hover",
                    "dapui_console",
                }, {
                    max_jobs = 16,
                })
            end,
        })

        vim.api.nvim_set_decoration_provider(namespace, {
            on_start = vim.schedule_wrap(function()
                if #parsers_pending == 0 then
                    return false
                end

                for _, pending_parser in ipairs(parsers_pending) do
                    if vim.api.nvim_buf_is_valid(pending_parser.buffer) then
                        if start(pending_parser.buffer, pending_parser.language) then
                            parsers_loaded[pending_parser.language] = true
                        else
                            parsers_failed[pending_parser.language] = true
                        end
                    end
                end

                parsers_pending = {}
            end),
        })

        local group = vim.api.nvim_create_augroup("Treesitter_Setup", { clear = true })

        local ignored_filetypes = {
            "checkhealth",
            "lazy",
            "mason",
            "noice",
            "fidget",
            "oil",
            "TelescopeResults",
            "TelescopePrompt",
            "NeogitStatus",
            "NeogitPopup",
            "NeogitDiffView",
            "blink-cmp-menu",
            "mininotify",
            "NeogitCommitView"
        }

        vim.api.nvim_create_autocmd("FileType", {
            group = group,
            desc = "Enable treesitter highlighting and indentation.",
            callback = function(event)
                if vim.tbl_contains(ignored_filetypes, event.match) then
                    return
                end

                local language = vim.treesitter.language.get_lang(event.match) or event.match
                local buffer = event.buf
                if parsers_failed[language] then
                    return
                end

                if parsers_loaded[language] then
                    start(buffer, language)
                else
                    table.insert(parsers_pending, { buffer = buffer, language = language })
                end

                t.install({ language })
            end,
        })

        vim.keymap.set("n", "<leader>ct", "<cmd>TSContextToggle<cr>", vim.g.n_opts)
    end,
}
