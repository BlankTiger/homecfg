local function set_hl()
    -- local accent = "#DF006B"
    local accent = "#ffffff"
    vim.api.nvim_set_hl(0, "LeapMatch", {})
    vim.api.nvim_set_hl(0, "LeapBackdrop", {})
    vim.api.nvim_set_hl(0, "LeapLabel", { fg = accent })
end

return {
    {
        "ggandor/leap.nvim",
        event = "VeryLazy",
        config = function()
            require("leap").set_default_mappings()
            require("leap.user").set_repeat_keys("<del>", "<backspace>", {
                relative_directions = true,
                modes = { "n", "x", "o" },
            })

            set_hl()
            vim.api.nvim_create_autocmd("ColorScheme", { callback = set_hl })
        end,
    },

    {
        "christoomey/vim-tmux-navigator",
        cmd = {
            "TmuxNavigateRight",
            "TmuxNavigateUp",
            "TmuxNavigateLeft",
            "TmuxNavigateDown",
        },
    },
}
