local set = vim.keymap.set

set("n", "<F10>", "<cmd>TagbarToggle<cr>", vim.g.n_opts)
set({ "t", "n" }, "<F1>", "<cmd>AsyncStop<cr>", vim.g.n_opts)
set({ "t", "n" }, "<F2>", function()
    vim.cmd("AsyncStop")
    vim.cmd("copen | AsyncRun " .. vim.g.mk)
    vim.cmd("wincmd p")
end, vim.g.n_opts)
-- F26 = C-F2
set({ "t", "n" }, "<F26>", function()
    vim.cmd("AsyncStop")
    vim.cmd("vert copen | wincmd = | AsyncRun " .. vim.g.mk)
    vim.cmd("wincmd p")
end, vim.g.n_opts)

local excluded_filetypes = {
    "gitcommit",
    "NvimTree",
    "Outline",
    "TelescopePrompt",
    "alpha",
    "dashboard",
    "lazygit",
    "neo-tree",
    "oil",
    "prompt",
    "toggleterm",
    "harpoon",
    "neogit",
}

local excluded_filenames = {
    "do-not-autosave-me.lua",
}

local function save_condition(buf)
    if
        vim.tbl_contains(excluded_filetypes, vim.fn.getbufvar(buf, "&filetype"))
        or vim.tbl_contains(excluded_filenames, vim.fn.expand("%:t"))
    then
        return false
    end
    return true
end

return {
    "nvim-lua/plenary.nvim",

    { "tpope/vim-repeat", event = "VeryLazy" },

    { "tpope/vim-sleuth", event = "VeryLazy" },

    {
        "preservim/tagbar",
        cmd = { "TagbarToggle" },
    },

    {
        "skywind3000/asyncrun.vim",
        cmd = { "AsyncRun", "AsyncStop" },
    },

    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup({
                map_c_h = true,
            })
        end,
    },

    {
        "okuuva/auto-save.nvim",
        version = "^1.0.0",
        cmd = "ASToggle",
        event = { "InsertLeave", "TextChanged" },
        opts = {
            condition = save_condition,
            trigger_events = {
                immediate_save = {
                    "BufLeave",
                    "FocusLost",
                    "QuitPre",
                    "VimSuspend",
                    "InsertLeave",
                    "TextChanged",
                },
                cancel_deferred_save = { "InsertEnter" },
            },
        },
    },
}
