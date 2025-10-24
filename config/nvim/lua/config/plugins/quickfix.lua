return {
    {
        "blanktiger/aqf.nvim",
        dev = true,
        lazy = true,
        config = function()
            local aqf = require("aqf")
            aqf.setup({
                show_instructions = true,
                windowed = false,
                debug = false,
            })

            local set = vim.keymap.set
            set("n", "<space>E", aqf.edit_curr_qf, { desc = "Edit current quickfix list" })
            set("n", "<space>H", aqf.show_saved_qf_lists, { desc = "Show saved quickfix lists" })
            set("n", "<space>S", aqf.save_qf, { desc = "Save current quickfix to history" })
        end,
    },
}
