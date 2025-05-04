local set = vim.keymap.set

return {
    {
        "lewis6991/gitsigns.nvim",
        event = "VeryLazy",
        tag = "v0.8.0",
        config = function()
            local gss = require("gitsigns")
            gss.setup({
                signs = {
                    add = {
                        hl = "GitSignsAdd",
                        text = " +",
                        numhl = "GitSignsAddNr",
                        linehl = "GitSignsAddLn",
                    },
                    change = {
                        hl = "GitSignsChange",
                        text = " ±",
                        numhl = "GitSignsChangeNr",
                        linehl = "GitSignsChangeLn",
                    },
                    delete = {
                        hl = "GitSignsDelete",
                        text = " ➤",
                        numhl = "GitSignsDeleteNr",
                        linehl = "GitSignsDeleteLn",
                    },
                    topdelete = {
                        hl = "GitSignsDelete",
                        text = " ➤",
                        numhl = "GitSignsDeleteNr",
                        linehl = "GitSignsDeleteLn",
                    },
                    changedelete = {
                        hl = "GitSignsChange",
                        text = " -",
                        numhl = "GitSignsChangeNr",
                        linehl = "GitSignsChangeLn",
                    },
                },
                signcolumn = false, -- Toggle with `:Gitsigns toggle_signs`
                numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
                linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
                word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
                watch_gitdir = {
                    interval = 1000,
                    follow_files = true,
                },
                attach_to_untracked = true,
                current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
                current_line_blame_opts = {
                    virt_text = true,
                    virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
                    delay = 200,
                    ignore_whitespace = false,
                },
                current_line_blame_formatter_opts = {
                    relative_time = false,
                },
                sign_priority = 6,
                update_debounce = 100,
                status_formatter = nil, -- Use default
                max_file_length = 40000,
                preview_config = {
                    -- Options passed to nvim_open_win
                    border = "single",
                    style = "minimal",
                    relative = "cursor",
                    row = 0,
                    col = 1,
                },
                yadm = {
                    enable = false,
                },
            })

            set("n", "<leader>gq", gss.setqflist)
            set("n", "<leader>gj", gss.next_hunk)
            set("n", "<leader>gk", gss.prev_hunk)
            set("n", "<leader>gP", gss.preview_hunk_inline)
            set("n", "<leader>gp", gss.preview_hunk)
            set("n", "<leader>gr", gss.reset_buffer)
            set("n", "<leader>gl", gss.toggle_current_line_blame)
            set("n", "<leader>gs", gss.stage_hunk)
            set("n", "<leader>gu", gss.undo_stage_hunk)
        end,
    },

    {
        "TimUntersberger/neogit",
        branch = "master",
        event = "VeryLazy",
        config = function()
            local neogit = require("neogit")
            neogit.setup({
                console_timeout = 10000,
                auto_show_console = true,
                disable_line_numbers = false,
                mappings = {
                    status = {
                        ["<c-s>"] = "VSplitOpen",
                        ["<c-h>"] = "SplitOpen",
                        ["R"] = "ShowRefs",
                        ["y"] = false,
                    },
                },
            })

            -- in a new tab
            set("n", "<leader>go", neogit.open)
            -- in a split
            set("n", "<leader>gO", function()
                neogit.open({ kind = "vsplit" })
            end)
        end,
        dependencies = {
            {
                "sindrets/diffview.nvim",
                config = function()
                    local diffview = require("diffview")
                    set("n", "<leader>gd", diffview.open)
                    set("n", "<leader>gc", diffview.close)
                    set("n", "<leader>gr", ":DiffviewRefresh<cr>", vim.g.n_opts)
                end,
            },
        },
    },
}
