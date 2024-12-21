return {
    "nvim-lua/plenary.nvim",

    {
        "chaoren/vim-wordmotion",
        -- lazy = true,
    },

    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        config = function()
            require("config.lualine")
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPre" },
        lazy = true,
        config = function()
            require("config.treesitter")
        end,
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
            "nvim-treesitter/nvim-treesitter-context",
            "JoosepAlviste/nvim-ts-context-commentstring",
        },
    },

    {
        "kevinhwang91/nvim-ufo",
        dependencies = "kevinhwang91/promise-async",
        config = function()
            require("config.ufo")
        end,
    },

    {
        "kr40/nvim-macros",
        cmd = { "MacroSave", "MacroYank", "MacroSelect", "MacroDelete" },
        opts = {

            json_file_path = vim.fs.normalize(vim.fn.stdpath("config") .. "/macros.json"),
            default_macro_register = "q",
            json_formatter = "jq",
        },
    },

    {
        "nvim-telescope/telescope.nvim",
        -- event = "VeryLazy",
        lazy = true,
        config = function()
            require("config.telescope")
            local telescope = require("telescope")
            telescope.load_extension("ripgrep")
            telescope.load_extension("aqf")
            telescope.load_extension("fzf")
            -- telescope.load_extension("notify")
            telescope.load_extension("git_worktree")
            telescope.load_extension("git_diffs")
            telescope.load_extension("harpoon")
        end,
        dependencies = {
            "nvim-telescope/telescope-file-browser.nvim",
            "junegunn/fzf",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
            },
            {
                "paopaol/telescope-git-diffs.nvim",
                config = function()
                    require("diffview")
                end,
            },
            {
                "blanktiger/telescope-rg.nvim",
                dev = true,
            },
        },
    },

    {
        "blanktiger/aqf.nvim",
        dev = true,
        lazy = true,
        config = function()
            require("aqf").setup({
                show_instructions = false,
                windowed = false,
                -- debug = true,
            })
        end,
    },

    {
        "folke/neodev.nvim",
        ft = "lua",
        config = function()
            require("neodev").setup({})
        end,
        opts = {},
    },
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        cmd = { "Mason", "LspInfo", "LspInstall", "LspUninstall" },
        config = function()
            require("config.lsp")
        end,
        dependencies = {
            {
                "stevearc/conform.nvim",
                config = function()
                    require("config.conform")
                end,
            },
            { "saghen/blink.cmp" },
        },
    },
    {
        "williamboman/mason.nvim",
        lazy = true,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        lazy = true,
    },
    {
        "sindrets/diffview.nvim",
        lazy = true,
    },

    {
        "nvimtools/none-ls.nvim",
        lazy = true,
    },

    {
        "MunifTanjim/prettier.nvim",
        -- ft = { "html", "css", "js", "ts", "jsx", "tsx" },
        lazy = true,
        config = function()
            require("config.prettier")
        end,
    },
    { "lervag/vimtex", ft = "tex", lazy = true },
    { "barreiroleo/ltex-extra.nvim", lazy = true },
    -- { "simrat39/rust-tools.nvim", lazy = true },
    {
        "mrcjkb/rustaceanvim",
        version = "^5", -- Recommended
        lazy = false, -- This plugin is already lazy
    },
    { "Vimjas/vim-python-pep8-indent", lazy = true },

    {
        "saghen/blink.cmp",
        dependencies = {
            {
                "L3MON4D3/LuaSnip",
                config = function()
                    require("config.snippets")
                end,
                build = "make install_jsregexp",
            },
        },
        version = "*",

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            snippets = {
                expand = function(snippet)
                    require("luasnip").lsp_expand(snippet)
                end,
                active = function(filter)
                    if filter and filter.direction then
                        return require("luasnip").jumpable(filter.direction)
                    end
                    return require("luasnip").in_snippet()
                end,
                jump = function(direction)
                    require("luasnip").jump(direction)
                end,
            },

            keymap = { preset = "default" },
            appearance = {
                -- use_nvim_cmp_as_default = true,
                nerd_font_variant = "mono",
            },
            sources = {
                default = {
                    -- "lsp",
                    "path",
                    "luasnip",
                    "snippets",
                    "buffer",
                },
                providers = {
                    buffer = {
                        opts = {
                            get_bufnrs = function()
                                -- use all buffers, even hidden ones
                                return vim.api.nvim_list_bufs()
                            end,
                        },
                    },
                },
            },
            signature = {
                enabled = true,
                window = {
                    border = "rounded",
                    scrollbar = false,
                    winblend = 0,
                    winhighlight = "Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None",
                },
            },
            completion = {
                menu = {
                    border = "rounded",
                    scrollbar = false,
                    winblend = 0,
                    scrolloff = 2,
                    winhighlight = "Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None",
                    draw = {
                        gap = 2,
                        columns = {
                            { "label", "label_description", gap = 1 },
                            { "kind_icon", "space" },
                        },
                        components = {
                            space = {
                                ellipsis = false,
                                text = function()
                                    return " "
                                end,
                            },
                        },
                    },
                },
            },
        },
        opts_extend = { "sources.default" },
    },

    -- {
    --     "hrsh7th/nvim-cmp",
    --     event = { "InsertEnter", "CmdlineEnter" },
    --     config = function()
    --         require("config.cmp")
    --     end,
    --     dependencies = {
    --         {
    --             "L3MON4D3/LuaSnip",
    --             config = function()
    --                 require("config.snippets")
    --             end,
    --             build = "make install_jsregexp",
    --         },
    --         "hrsh7th/cmp-path",
    --         "hrsh7th/cmp-buffer",
    --         "hrsh7th/cmp-cmdline",
    --         "hrsh7th/cmp-nvim-lsp",
    --         "hrsh7th/cmp-nvim-lua",
    --         "saadparwaiz1/cmp_luasnip",
    --         -- {
    --         --     "zbirenbaum/copilot.lua",
    --         --     cmd = "Copilot",
    --         --     config = function()
    --         --         require("config.copilot")
    --         --     end,
    --         -- },
    --         -- {
    --         --     "zbirenbaum/copilot-cmp",
    --         --     config = function()
    --         --         require("copilot_cmp").setup()
    --         --     end,
    --         -- },
    --     },
    -- },

    {
        "lewis6991/gitsigns.nvim",
        event = "VeryLazy",
        tag = "v0.8.0",
        config = function()
            require("config.gitsigns")
        end,
    },
    { "akinsho/git-conflict.nvim", version = "*", config = true },
    --[[ 'luk400/vim-jukit', ]]
    {
        "norcalli/nvim-colorizer.lua",
        event = "VeryLazy",
        config = function()
            require("config.colorizer")
        end,
    },
    --[[ "kyazdani42/nvim-web-devicons", ]]
    {
        "folke/zen-mode.nvim",
        event = "VeryLazy",
        config = function()
            require("config.zen-mode")
        end,
    },
    { "folke/twilight.nvim", event = "VeryLazy" },
    { "romainl/vim-cool", event = "VeryLazy" },

    {
        "christoomey/vim-tmux-navigator",
        event = "VeryLazy",
        cmd = {
            "TmuxNavigateLeft",
            "TmuxNavigateDown",
            "TmuxNavigateUp",
            "TmuxNavigateRight",
            "TmuxNavigatePrevious",
        },
    },
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
    -- {
    --     "ThePrimeagen/refactoring.nvim",
    --     dependencies = {
    --         "nvim-lua/plenary.nvim",
    --         "nvim-treesitter/nvim-treesitter",
    --     },
    --     config = function()
    --         require("refactoring").setup()
    --     end,
    -- },

    {
        "ThePrimeagen/git-worktree.nvim",
        event = "VeryLazy",
        config = function()
            require("config.git-worktree")
        end,
    },
    { "mbbill/undotree", event = "VeryLazy" },

    {
        "TimUntersberger/neogit",
        branch = "master",
        event = "VeryLazy",
        config = function()
            require("config.neogit")
        end,
        dependencies = {
            "sindrets/diffview.nvim",
        },
    },
    -- { "tpope/vim-fugitive", event = "VeryLazy" },
    -- { "tpope/vim-surround",             event = "VeryLazy" },
    { "tpope/vim-sleuth", event = "VeryLazy" },
    { "tpope/vim-obsession", event = "VeryLazy" },

    --[[ "windwp/nvim-autopairs", ]]
    --[[ { "numToStr/Comment.nvim", event = "VeryLazy" }, ]]
    --[[ "moll/vim-bbye", ]]
    {
        "folke/which-key.nvim",
        tag = "v2.1.0",
        config = function()
            require("config.whichkey")
        end,
    },
    { "fedepujol/move.nvim", event = "VeryLazy" },
    {
        "ggandor/leap.nvim",
        event = "VeryLazy",
        dependencies = {
            { "tpope/vim-repeat", event = "VeryLazy" },
        },
        config = function()
            local leap = require("leap")
            vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap-forward)")
            vim.keymap.set({ "n", "x", "o" }, "S", "<Plug>(leap-backward)")
            vim.keymap.set({ "n", "x", "o" }, "gS", "<Plug>(leap-from-window)")
            leap.opts.equivalence_classes = { " \t\r\n", "([{", ")]}", "'\"`" }
        end,
    },
    { "preservim/tagbar", event = "VeryLazy" },
    --[[ "amadeus/vim-evokai", ]]
    --[[ "B4mbus/oxocarbon-lua.nvim", ]]
    --[[ "kyazdani42/nvim-tree.lua", ]]
    -- {
    --     "nvim-neo-tree/neo-tree.nvim",
    --     branch = "v3.x",
    --     event = "VeryLazy",
    --     config = function()
    --         require("config.neotree")
    --     end,
    --     dependencies = {
    --         "nvim-lua/plenary.nvim",
    --         "nvim-tree/nvim-web-devicons",
    --         "MunifTanjim/nui.nvim",
    --     },
    -- },

    {
        url = "https://github.com/BlankTiger/oil.nvim",
        -- "stevearc/oil.nvim",
        config = function()
            require("config.oil")
        end,
        opts = {},
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },

    {
        "glepnir/dashboard-nvim",
        lazy = false,
        priority = 900,
        config = function()
            require("config.dashboard")
        end,
    },

    --[[ { "roobert/search-replace.nvim" }, ]]
    -- {
    --     "folke/tokyonight.nvim",
    --     lazy = false,
    --     priority = 1000,
    --     opts = {},
    -- },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        priority = 900,
        opts = {},
    },
    {
        "seandewar/paragon.vim",
        lazy = false,
        priority = 1000,
    },
    -- { "bluz71/vim-moonfly-colors", name = "moonfly", lazy = false, priority = 1000 },

    {
        "AckslD/nvim-neoclip.lua",
        event = "VeryLazy",
        config = function()
            require("config.neoclip")
        end,
    },

    --[[ { dir = "/home/blanktiger/Projects/unorphanize.nvim" }, ]]
    --[[ "vale1410/vim-minizinc", ]]
    { "NoahTheDuke/vim-just", event = "VeryLazy" },
    {
        "kevinhwang91/nvim-bqf",
        event = "VeryLazy",
        dependencies = {

            "junegunn/fzf",
        },
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
            {
                "mfussenegger/nvim-dap-python",
                ft = "python",
                config = function(_, _)
                    local path = "~/venv/bin/python"
                    require("dap-python").setup(path)
                end,
            },
            "nvim-neotest/nvim-nio",
        },
        lazy = true,
        config = function()
            local dap = require("dap")
            require("config.dap")
            local dapui = require("dapui")
            dapui.setup()
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end
        end,
        -- config = function()
        -- end
    },
    -- { "chrisgrieser/nvim-spider", lazy = true },

    {
        "echasnovski/mini.ai",
        version = false,
        event = "VeryLazy",
        config = function()
            require("config.mini-ai")
        end,
    },
    {
        "echasnovski/mini.indentscope",
        version = false,
        event = "VeryLazy",
        config = function()
            require("config.mini-indentscope")
        end,
    },
    -- {
    -- 	'echasnovski/mini.pairs',
    -- 	version = false,
    -- 	event = "VeryLazy",
    -- 	config = function()
    -- 		require("config.mini-pairs")
    -- 	end
    -- },
    {
        "echasnovski/mini.surround",
        version = false,
        event = "VeryLazy",
        config = function()
            require("config.mini-surround")
        end,
    },
    {
        "echasnovski/mini.comment",
        version = false,
        event = "VeryLazy",
        config = function()
            require("config.mini-comment")
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

    { "buztard/vim-rel-jump", event = "VeryLazy" },

    -- {
    --     "folke/todo-comments.nvim",
    --     event = "VeryLazy",
    --     config = function()
    --         require("config.todo-comments")
    --     end,
    --     dependencies = { "nvim-lua/plenary.nvim" },
    -- },

    {
        "folke/trouble.nvim",
        event = "VeryLazy",
        config = function()
            require("config.trouble")
        end,
    },

    {
        "RRethy/vim-illuminate",
        lazy = true,
        -- event = "VeryLazy",
    },

    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            -- add any options here
        },
        config = function()
            local noice = require("noice")
            noice.setup({
                lsp = {
                    progress = {
                        enabled = false,
                    },
                    signature = { auto_open = { enabled = false } },
                },
                notify = {
                    enabled = false,
                },
            })
        end,
        dependencies = {
            {
                "echasnovski/mini.notify",
                config = function()
                    require("mini.notify").setup({
                        lsp_progress = { enable = false },
                        window = {
                            config = {
                                anchor = "NE",
                                border = "none",
                            },
                            winblend = 50,
                        },
                    })
                    vim.notify = MiniNotify.make_notify()
                end,
            },
            {
                "j-hui/fidget.nvim",
                config = function()
                    require("config.fidget")
                end,
            },
            "MunifTanjim/nui.nvim",
        },
    },

    { "nvim-pack/nvim-spectre", event = "VeryLazy" },

    { "eandrju/cellular-automaton.nvim", lazy = true },

    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
    },

    {
        "chomosuke/term-edit.nvim",
        event = "TermOpen",
        version = "1.*",
        config = function()
            require("term-edit").setup({
                prompt_end = "❯",
            })
        end,
    },
}
