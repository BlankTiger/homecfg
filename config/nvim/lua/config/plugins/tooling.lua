local set = vim.keymap.set

local function run_new_task_from_mk(o)
    local task = o.new_task({
        cmd = vim.g.mk
    })
    task:start()
end

set("n", "<F10>", "<cmd>TagbarToggle<cr>", vim.g.n_opts)

set({ "t", "n" }, "<F1>", function()
    local o = require("overseer")

    local all_tasks = o.list_tasks({})
    local len_tasks = #all_tasks
    if len_tasks == 0 then
        return
    end

    local last_task = all_tasks[len_tasks]
    last_task:stop()
end, vim.g.n_opts)

set({ "t", "n" }, "<F2>", function()
    local o = require("overseer")
    local s = require("overseer.constants").STATUS
    -- o.open({ enter = false })

    local all_tasks = o.list_tasks({})
    local len_tasks = #all_tasks
    if len_tasks == 0 then
        run_new_task_from_mk(o)
        return
    end

    local last_task = all_tasks[len_tasks]
    if last_task.cmd == vim.g.mk then
        if last_task.status == s.RUNNING then
            last_task:stop()
        end

        last_task:restart()
        return
    end

    run_new_task_from_mk(o)
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

    -- {
    --     "skywind3000/asyncrun.vim",
    --     cmd = { "AsyncRun", "AsyncStop" },
    -- },

    -- "tpope/vim-dispatch",

    {
        "blanktiger/overseer.nvim",
        event = "VeryLazy",
        opts = {
            task_list = {
                direction = "right",
                bindings = {
                    ["?"] = "ShowHelp",
                    ["g?"] = "ShowHelp",
                    ["<CR>"] = "RunAction",
                    ["<C-r>"] = "Restart",
                    ["<C-e>"] = "Edit",
                    ["o"] = "Open",
                    ["<C-v>"] = "OpenVsplit",
                    ["<C-s>"] = "OpenSplit",
                    ["<C-n>"] = "OpenTab",
                    ["<C-q>"] = false,
                    ["p"] = "TogglePreview",
                    ["<C-l>"] = false,
                    ["<C-h>"] = false,
                    ["<C-k>"] = false,
                    ["<C-j>"] = false,
                    ["R"] = "Restart",
                    ["K"] = "Stop",
                    ["L"] = "IncreaseDetail",
                    ["H"] = "DecreaseDetail",
                    ["["] = "DecreaseWidth",
                    ["]"] = "IncreaseWidth",
                    ["{"] = "PrevTask",
                    ["}"] = "NextTask",
                    ["q"] = "Close",
                },
            },
            component_aliases = {
                -- Most tasks are initialized with the default components
                default = {
                    { "display_duration", detail_level = 2 },
                    "on_output_summarize",
                    "on_exit_set_status",
                    { "on_output_quickfix", open = true },
                },
            },
        },
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
