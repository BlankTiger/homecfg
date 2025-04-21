return {
    { "fedepujol/move.nvim", event = "VeryLazy" },
    { "buztard/vim-rel-jump", event = "VeryLazy" },
    {
        "ggandor/leap.nvim",
        event = "VeryLazy",
        dependencies = {
            { "tpope/vim-repeat", event = "VeryLazy" },
        },
        config = function()
            local leap = require("leap")
            vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap-forward)")
            vim.keymap.set({ "n", "x", "o" }, "S", "<Plug>(leap-backward)")
            vim.keymap.set({ "n", "x", "o" }, "gS", "<Plug>(leap-from-window)")
            leap.opts.equivalence_classes = { " \t\r\n", "([{", ")]}", "'\"`" }
        end,
    },
    {
        "christoomey/vim-tmux-navigator",
        cmd = {
            "TmuxNavigateLeft",
            "TmuxNavigateDown",
            "TmuxNavigateUp",
            "TmuxNavigateRight",
            "TmuxNavigatePrevious",
            "TmuxNavigatorProcessList",
        },
        keys = {
            { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
            { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
            { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
            { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
            { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
        },
    },

    -- {
    --     "chaoren/vim-wordmotion",
    --     -- lazy = true,
    -- },
}
