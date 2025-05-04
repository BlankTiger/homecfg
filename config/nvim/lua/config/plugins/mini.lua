return {
    {
        "echasnovski/mini.ai",
        version = false,
        event = "VeryLazy",
        config = function()
            require("mini.ai").setup()
        end,
    },

    {
        "echasnovski/mini.move",
        event = "VeryLazy",
        config = function()
            require("mini.move").setup({
                mappings = {
                    left = "",
                    right = "",
                    up = "K",
                    down = "J",

                    line_left = "",
                    line_right = "",
                    line_down = "",
                    line_up = "",
                },
            })
        end,
    },

    {
        "echasnovski/mini.surround",
        version = false,
        event = "VeryLazy",
        config = function()
            require("mini.surround").setup({
                mappings = {
                    add = "Ys",
                    delete = "ds",
                    replace = "cs",
                    find = "", -- Find surrounding (to the right)
                    find_left = "", -- Find surrounding (to the left)
                    highlight = "", -- Highlight surrounding
                    update_n_lines = "", -- Update `n_lines`
                },
            })
        end,
    },

    {
        "echasnovski/mini.align",
        version = false,
        event = "VeryLazy",
        config = function()
            require("mini.align").setup()
        end,
    },
}
