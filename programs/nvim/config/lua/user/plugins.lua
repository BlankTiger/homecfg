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
        "nvim-telescope/telescope.nvim",
        -- event = "VeryLazy",
        lazy = true,
        config = function()
            require("config.telescope")
            local telescope = require("telescope")
            telescope.load_extension("ripgrep")
            telescope.load_extension("aqf")
            telescope.load_extension("fzf")
            telescope.load_extension("notify")
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
                windowed = false,
                debug = true,
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
        version = "^4", -- Recommended
        lazy = false, -- This plugin is already lazy
    },
    { "Vimjas/vim-python-pep8-indent", lazy = true },

    {
        "hrsh7th/nvim-cmp",
        event = { "InsertEnter", "CmdlineEnter" },
        config = function()
            require("config.cmp")
        end,
        dependencies = {
            {
                "L3MON4D3/LuaSnip",
                config = function()
                    require("config.snippets")
                end,
                build = "make install_jsregexp",
            },
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            "saadparwaiz1/cmp_luasnip",
            {
                "zbirenbaum/copilot.lua",
                cmd = "Copilot",
                config = function()
                    require("config.copilot")
                end,
            },
            {
                "zbirenbaum/copilot-cmp",
                config = function()
                    require("copilot_cmp").setup()
                end,
            },
        },
    },

    {
        "lewis6991/gitsigns.nvim",
        event = "VeryLazy",
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
    { "ThePrimeagen/harpoon", event = "VeryLazy" },
    {
        "ThePrimeagen/refactoring.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("refactoring").setup()
        end,
    },

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
        branch = "nightly",
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
    { "tpope/vim-repeat", event = "VeryLazy" },
    { "tpope/vim-sleuth", event = "VeryLazy" },
    { "tpope/vim-obsession", event = "VeryLazy" },

    --[[ "windwp/nvim-autopairs", ]]
    --[[ { "numToStr/Comment.nvim", event = "VeryLazy" }, ]]
    --[[ "moll/vim-bbye", ]]
    {
        "folke/which-key.nvim",
        config = function()
            require("config.whichkey")
        end,
    },
    { "fedepujol/move.nvim", event = "VeryLazy" },
    --[[ "ggandor/leap.nvim", ]]
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
    { "bluz71/vim-moonfly-colors", name = "moonfly", lazy = false, priority = 1000 },

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

    {
        "folke/todo-comments.nvim",
        event = "VeryLazy",
        config = function()
            require("config.todo-comments")
        end,
        dependencies = { "nvim-lua/plenary.nvim" },
    },

    {
        "folke/trouble.nvim",
        event = "VeryLazy",
        config = function()
            require("config.trouble")
        end,
    },

    -- {
    --     "folke/flash.nvim",
    --     event = "VeryLazy",
    --     opts = {
    --         highlight = {
    --             backdrop = false,
    --             matches = true,
    --             groups = {
    --                 match = "FlashMatch",
    --                 current = "FlashLabel",
    --                 backdrop = "FlashBackdrop",
    --                 label = "FlashCurrent",
    --             },
    --         },
    --     },
    -- },

    {
        "RRethy/vim-illuminate",
        lazy = true,
        -- event = "VeryLazy",
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        event = "InsertEnter",
        main = "ibl",
        config = function()
            require("config.indentline")
        end,
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
                },
            })
        end,
        dependencies = {
            {
                "rcarriga/nvim-notify",
                config = function()
                    require("config.notify")
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
}
