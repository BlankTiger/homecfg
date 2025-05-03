return {
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        config = function()
            local harpoon = require("harpoon")
            harpoon.setup({})

            local set = vim.keymap.set

            set("n", "<space>H", function()
                require("telescope").extensions.harpoon.marks()
            end)
            set("n", "<space>h", function()
                harpoon.ui:toggle_quick_menu(harpoon:list(), {
                    height_in_lines = 16,
                    -- title = "  bruh  ",
                    title = "",
                    title_pos = "center",
                    border = "rounded",
                })
            end)
            set("n", "<space>m", function()
                harpoon:list():add()
            end)

            set({ "t", "n", "i" }, "<M-A>", function()
                harpoon:list():select(1)
            end, {})
            set({ "t", "n", "i" }, "<M-S>", function()
                harpoon:list():select(2)
            end, {})
            set({ "t", "n", "i" }, "<M-D>", function()
                harpoon:list():select(3)
            end, {})
            set({ "t", "n", "i" }, "<M-F>", function()
                harpoon:list():select(4)
            end, {})
            set({ "t", "n", "i" }, "<M-G>", function()
                harpoon:list():select(5)
            end, {})
            set({ "t", "n", "i" }, "<M-H>", function()
                harpoon:list():select(6)
            end, {})
            set({ "t", "n", "i" }, "<M-J>", function()
                harpoon:list():select(7)
            end, {})
            set({ "t", "n", "i" }, "<M-K>", function()
                harpoon:list():select(8)
            end, {})
            set({ "t", "n", "i" }, "<M-L>", function()
                harpoon:list():select(9)
            end, {})
        end,
        event = "VeryLazy",
    },
}
