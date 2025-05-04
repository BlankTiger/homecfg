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
                }, -- one of "all" or a list of languages
                ignore_install = { "" }, -- List of parsers to ignore installing
                auto_install = true,

                highlight = {
                    enable = true, -- false will disable the whole extension
                    disable = { "json" }, -- list of language that will be disabled
                },

                autopairs = {
                    enable = true,
                },

                indent = {
                    enable = true,
                    disable = { "zig" },
                },

                -- incremental_selection = {
                -- 	enable = true,
                -- 	keymaps = {
                -- 		init_selection = "<C-space>",
                -- 		node_incremental = "<C-space>",
                -- 		scope_incremental = false,
                -- 		node_decremental = "<bs>",
                -- 	}
                -- },

                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            ["a="] = { query = "@assignment.outer" },
                            ["i="] = { query = "@assignment.inner" },
                            -- ["e="] = { query = "@assignment.lhs" },
                            ["r="] = { query = "@assignment.rhs" },

                            ["aa"] = { query = "@parameter.outer" },
                            ["ia"] = { query = "@parameter.inner" },

                            ["ai"] = { query = "@conditional.outer" },
                            ["ii"] = { query = "@conditional.inner" },

                            ["al"] = { query = "@loop.outer" },
                            ["il"] = { query = "@loop.inner" },

                            ["av"] = { query = "@call.outer" },
                            ["iv"] = { query = "@call.inner" },

                            ["af"] = { query = "@function.outer" },
                            ["if"] = { query = "@function.inner" },

                            ["ac"] = { query = "@class.outer" },
                            ["ic"] = { query = "@class.inner" },
                        },
                    },

                    move = {
                        enable = true,
                        set_jumps = true,
                        goto_next_start = {
                            ["]f"] = { query = "@function.outer" },
                            ["]a"] = { query = "@parameter.outer" },
                            ["]l"] = { query = "@loop.outer" },
                            ["]c"] = { query = "@class.outer" },
                            ["]i"] = { query = "@conditional.outer" },
                            ["]v"] = { query = "@call.outer" },
                            ["]="] = { query = "@assignment.outer" },
                        },
                        goto_next_end = {
                            ["]F"] = { query = "@function.outer" },
                            ["]A"] = { query = "@parameter.outer" },
                            ["]L"] = { query = "@loop.outer" },
                            ["]C"] = { query = "@class.outer" },
                            ["]I"] = { query = "@conditional.outer" },
                            ["]V"] = { query = "@call.outer" },
                            ["]="] = { query = "@assignment.outer" },
                        },

                        goto_previous_start = {
                            ["[f"] = { query = "@function.outer" },
                            ["[a"] = { query = "@parameter.outer" },
                            ["[l"] = { query = "@loop.outer" },
                            ["[c"] = { query = "@class.outer" },
                            ["[i"] = { query = "@conditional.outer" },
                            ["[v"] = { query = "@call.outer" },
                            ["[="] = { query = "@assignment.outer" },
                        },
                        goto_previous_end = {
                            ["[F"] = { query = "@function.outer" },
                            ["[A"] = { query = "@parameter.outer" },
                            ["[L"] = { query = "@loop.outer" },
                            ["[C"] = { query = "@class.outer" },
                            ["[I"] = { query = "@conditional.outer" },
                            ["[V"] = { query = "@call.outer" },
                            ["[="] = { query = "@assignment.outer" },
                        },
                    },

                    swap = {
                        enable = true,
                        swap_next = {
                            ["<leader>spn"] = "@parameter.inner",
                            ["<leader>sfn"] = "@function.outer",
                            ["<leader>scn"] = "@class.outer",
                        },
                        swap_previous = {
                            ["<leader>spp"] = "@parameter.inner",
                            ["<leader>sfp"] = "@function.outer",
                            ["<leader>scp"] = "@class.outer",
                        },
                    },
                },
            })

            -- vim.keymap.set({"n", "x", "o"}, ";", repeatable.repeat_last_move)
            -- vim.keymap.set({"n", "x", "o"}, "&", repeatable.repeat_last_move_opposite)
            --
            -- vim.keymap.set({"n", "x", "o"}, "f", repeatable.builtin_f)
            -- vim.keymap.set({"n", "x", "o"}, "F", repeatable.builtin_F)
            -- vim.keymap.set({"n", "x", "o"}, "t", repeatable.builtin_t)
            -- vim.keymap.set({"n", "x", "o"}, "T", repeatable.builtin_T)

            local set = vim.keymap.set

            set("n", "<leader>c", ":TSContextToggle<cr>", vim.g.n_opts)
        end,
    },
}
