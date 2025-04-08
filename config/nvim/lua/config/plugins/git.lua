return {
    {
        "sindrets/diffview.nvim",
        event = "VeryLazy",
    },

    {
        "akinsho/git-conflict.nvim",
        event = "VeryLazy",
        version = "*",
        config = true,
    },

    {
        "lewis6991/gitsigns.nvim",
        event = "VeryLazy",
        tag = "v0.8.0",
        config = function()
            require("gitsigns").setup({
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
                current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
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
        end,
    },

    {
        "ThePrimeagen/git-worktree.nvim",
        event = "VeryLazy",
    },

    {
        "TimUntersberger/neogit",
        branch = "master",
        event = "VeryLazy",
        config = function()
            require("neogit").setup({
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
        end,
        dependencies = {
            "sindrets/diffview.nvim",
        },
    },

    -- { "tpope/vim-fugitive", event = "VeryLazy" },
}
