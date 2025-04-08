return {
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        config = function()
            local harpoon = require("harpoon")
            harpoon.setup({
                menu = {
                    width = 120,
                    height = 40,
                },
            })
        end,
        event = "VeryLazy",
    },
}
