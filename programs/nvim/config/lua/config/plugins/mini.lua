return {
    {
        "echasnovski/mini.ai",
        version = false,
        event = "VeryLazy",
        config = function()
            require("mini.ai").setup()
        end,
    },
    -- {
    --     "echasnovski/mini.indentscope",
    --     version = false,
    --     event = "VeryLazy",
    --     config = function()
    --         local mini_indentscope = require("mini.indentscope")
    --         mini_indentscope.setup({
    --             options = {
    --                 try_as_border = true,
    --             },
    --             symbol = "│",
    --             draw = {
    --                 delay = 0,
    --                 animation = mini_indentscope.gen_animation.none(),
    --             },
    --         })
    --     end,
    -- },
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
        "echasnovski/mini.comment",
        version = false,
        event = "VeryLazy",
        config = function()
            require("mini.comment").setup()
        end,
    },
    {
        "echasnovski/mini.jump",
        version = false,
        event = "VeryLazy",
        config = function()
            require("mini.jump").setup()
        end,
    },

    -- {
    --     "echasnovski/mini.pairs",
    --     version = false,
    --     event = "VeryLazy",
    --     config = function()
    --         require("mini.pairs").setup()
    --     end,
    -- },
}
