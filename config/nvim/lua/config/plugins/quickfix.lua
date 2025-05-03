return {
    {
        "blanktiger/aqf.nvim",
        dev = true,
        lazy = true,
        config = function()
            require("aqf").setup({
                show_instructions = false,
                windowed = false,
                debug = false,
            })
        end,
    },
}
