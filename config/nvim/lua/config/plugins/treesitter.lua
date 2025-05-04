return {
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPre" },
        lazy = true,
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
            {
                "nvim-treesitter/nvim-treesitter-context",
                config = function()
                    -- disable context by default
                    vim.cmd("TSContextToggle")
                end,
            },
            "JoosepAlviste/nvim-ts-context-commentstring",
        },
        config = function()
            local configs = require("nvim-treesitter.configs")
            local compiler = require("nvim-treesitter.install")
            local repeatable = require("nvim-treesitter.textobjects.repeatable_move")

            compiler.compilers = { "clang++" }
            compiler.compilers = { "clang" }

            configs.setup({
                ensure_installed = {
                    "c",
                    "lua",
                    "vim",
                    "vimdoc",
                    "query",
                    "rust",
                    "python",
                    "yaml",
                    "toml",
                    "zig",
                },
                ignore_install = { "" },
                auto_install = true,

                highlight = {
                    enable = true,
                    disable = { "json" },
                },

                indent = {
                    enable = true,
                    disable = { "zig" },
                },

                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            -- to use those do e.g.: vfo to select the whole function
                            ["ao"] = { query = "@assignment.outer" },
                            ["ai"] = { query = "@assignment.inner" },
                            ["a<"] = { query = "@assignment.lhs" },
                            ["a>"] = { query = "@assignment.rhs" },

                            ["po"] = { query = "@parameter.outer" },
                            ["pi"] = { query = "@parameter.inner" },

                            ["io"] = { query = "@conditional.outer" },
                            ["ii"] = { query = "@conditional.inner" },

                            ["l("] = { query = "@loop.outer" },
                            ["l)"] = { query = "@loop.inner" },

                            ["co"] = { query = "@call.outer" },
                            ["ci"] = { query = "@call.inner" },

                            ["fo"] = { query = "@function.outer" },
                            ["fi"] = { query = "@function.inner" },

                            ["Co"] = { query = "@class.outer" },
                            ["Ci"] = { query = "@class.inner" },
                        },
                    },

                    swap = {
                        enable = true,
                        swap_next = {
                            ["<leader>snpi"] = "@parameter.inner",
                            ["<leader>snpo"] = "@parameter.outer",
                            ["<leader>snfo"] = "@function.outer",
                            ["<leader>snfi"] = "@function.inner",
                            ["<leader>snco"] = "@class.outer",
                            ["<leader>snci"] = "@class.inner",
                        },
                        swap_previous = {
                            ["<leader>sppi"] = "@parameter.inner",
                            ["<leader>sppo"] = "@parameter.outer",
                            ["<leader>spfo"] = "@function.outer",
                            ["<leader>spfi"] = "@function.inner",
                            ["<leader>spcp"] = "@class.outer",
                            ["<leader>spci"] = "@class.inner",
                        },
                    },
                },
            })

            vim.keymap.set("n", "<leader>c", ":TSContextToggle<cr>", vim.g.n_opts)
        end,
    },
}
