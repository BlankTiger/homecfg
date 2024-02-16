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
        -- lazy = true,
        -- event = "VeryLazy",
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
        "nvim-telescope/telescope.nvim",
        -- event = "VeryLazy",
        lazy = true,
        config = function()
            require("config.telescope")
        end,
        dependencies = {
            "nvim-telescope/telescope-file-browser.nvim",
            "junegunn/fzf",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
            },
            {
                "kelly-lin/telescope-ag",
                config = function()
                    local telescope_ag = require("telescope-ag")
                    telescope_ag.setup({
                        cmd = telescope_ag.cmds.rg, -- defaults to telescope_ag.cmds.ag
                    })
                end,
            },
            {
                "paopaol/telescope-git-diffs.nvim",
                config = function()
                    require("diffview")
                end,
            },
        },
    },

    { "duane9/nvim-rg" },

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
        cmd = { "LspInfo", "LspInstall", "LspUninstall" },
        config = function()
            require("config.lsp")
        end,
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
    { "simrat39/rust-tools.nvim", lazy = true },
    { "Vimjas/vim-python-pep8-indent", lazy = true },

    {
        "hrsh7th/nvim-cmp",
        event = { "InsertEnter", "CmdlineEnter" },
        -- lazy = true,
        config = function()
            require("config.cmp")
        end,
        dependencies = {
            {
                "L3MON4D3/LuaSnip",
                version = "v2.*",
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
    { "ThePrimeagen/harpoon", event = "VeryLazy" },
    {
        "ThePrimeagen/git-worktree.nvim",
        event = "VeryLazy",
        config = function()
            require("config.git-worktree")
        end,
    },
    { "mbbill/undotree", event = "VeryLazy" },

    { "tpope/vim-fugitive", event = "VeryLazy" },
    -- { "tpope/vim-surround",             event = "VeryLazy" },
    { "tpope/vim-repeat", event = "VeryLazy" },
    { "tpope/vim-sleuth", event = "VeryLazy" },
    { "tpope/vim-obsession", event = "VeryLazy" },

    --[[ "windwp/nvim-autopairs", ]]
    --[[ { "numToStr/Comment.nvim", event = "VeryLazy" }, ]]
    --[[ "moll/vim-bbye", ]]
    { "folke/which-key.nvim", lazy = true },
    { "fedepujol/move.nvim", event = "VeryLazy" },
    --[[ "ggandor/leap.nvim", ]]
    { "preservim/tagbar", event = "VeryLazy" },
    --"TimUntersberger/neogit",
    --[[ "amadeus/vim-evokai", ]]
    --[[ "B4mbus/oxocarbon-lua.nvim", ]]
    --[[ "kyazdani42/nvim-tree.lua", ]]
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        event = "VeryLazy",
        config = function()
            require("config.neotree")
        end,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
    },

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
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        priority = 900,
        opts = {},
    },

    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
    },
    {
        "blazkowolf/gruber-darker.nvim",
        lazy = false,
        priority = 1000,
    },
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
    { "kevinhwang91/nvim-bqf", event = "VeryLazy" },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
            {
                "mfussenegger/nvim-dap-python",
                ft = "python",
                dependencies = {
                    "mfussenegger/nvim-dap",
                    "rcarriga/nvim-dap-ui",
                },
                config = function(_, _)
                    local path = "~/venv/bin/python"
                    require("dap-python").setup(path)
                end,
            },
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

    {
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = {
            highlight = {
                backdrop = true,
                matches = true,
                groups = {
                    match = "FlashMatch",
                    current = "FlashLabel",
                    backdrop = "FlashBackdrop",
                    label = "FlashCurrent",
                },
            },
        },
    },

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
            noice.setup()
        end,
        dependencies = {
            {
                "rcarriga/nvim-notify",
                config = function()
                    require("config.notify")
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
