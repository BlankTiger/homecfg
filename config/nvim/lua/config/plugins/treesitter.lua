local function toggle_context()
    require("treesitter-context").toggle()
end

local ENABLE_TREESITTER_HIGHLIGHTING = true

return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre" },
    lazy = true,
    -- lazy = false,
    branch = "main",
    build = ":TSUpdate",
    dependencies = {
        {
            "nvim-treesitter/nvim-treesitter-textobjects",
            config = function()
                local ts_select = require("nvim-treesitter-textobjects.select")
                local map = function(mode, lhs, query)
                    vim.keymap.set(mode, lhs, function()
                        ts_select.select_textobject(query, "textobjects")
                    end, { desc = "TS: " .. query })
                end

                map({ "x", "o" }, "af", "@function.outer")
                map({ "x", "o" }, "if", "@function.inner")
                map({ "x", "o" }, "ac", "@class.outer")
                map({ "x", "o" }, "ic", "@class.inner")
                map({ "x", "o" }, "al", "@loop.outer")
                map({ "x", "o" }, "il", "@loop.inner")
                map({ "x", "o" }, "ai", "@conditional.outer")
                map({ "x", "o" }, "ii", "@conditional.inner")
                map({ "x", "o" }, "am", "@call.outer")
                map({ "x", "o" }, "im", "@call.inner")
                map({ "x", "o" }, "aa", "@parameter.outer")
                map({ "x", "o" }, "ia", "@parameter.inner")
                map({ "x", "o" }, "a=", "@assignment.outer")
                map({ "x", "o" }, "i=", "@assignment.inner")
                map({ "x", "o" }, "ar", "@return.outer")
                map({ "x", "o" }, "ir", "@return.inner")
            end,
        },
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
                    "zig",
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
            "NeogitCommitView",
            "harpoon",
            "qf",
            "conf",
            "jai",
        }

        vim.api.nvim_create_autocmd("FileType", {
            group = group,
            desc = "Enable treesitter highlighting and indentation.",
            callback = function(event)
                if not ENABLE_TREESITTER_HIGHLIGHTING then
                    return
                end

                if vim.tbl_contains(ignored_filetypes, event.match) then
                    return
                end

                local language = vim.treesitter.language.get_lang(event.match) or event.match

                if language == "" then
                    return
                end

                local buffer = event.buf
                if parsers_failed[language] then
                    return
                end

                start(buffer, language)
                if parsers_loaded[language] then
                else
                    table.insert(parsers_pending, { buffer = buffer, language = language })
                end

                t.install({ language })
            end,
        })

        vim.keymap.set("n", "<leader>ct", toggle_context, vim.g.n_opts)
    end,
}
