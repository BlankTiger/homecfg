local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
    return
end

local vim = vim

vim.g.mapleader = ","
vim.g.maplocalleader = ","

local setup = {
    plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        spelling = {
            enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
            suggestions = 20, -- how many suggestions should be shown in the list?
        },
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        presets = {
            operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
            motions = true, -- adds help for motions
            text_objects = true, -- help for text objects triggered after entering an operator
            windows = true, -- default bindings on <c-w>
            nav = true, -- misc bindings to work with windows
            z = true, -- bindings for folds, spelling and others prefixed with z
            g = true, -- bindings for prefixed with g
        },
    },
    -- add operators that will trigger motion and text object completion
    -- to enable all native operators, set the preset / operators plugin above
    -- operators = { gc = "Comments" },
    key_labels = {
        -- override the label used to display some keys. It doesn't effect WK in any other way.
        -- For example:
        -- ["<space>"] = "SPC",
        -- ["<cr>"] = "RET",
        -- ["<tab>"] = "TAB",
    },
    icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "➜", -- symbol used between a key and it's label
        group = "+", -- symbol prepended to a group
    },
    popup_mappings = {
        scroll_down = "<c-d>", -- binding to scroll down inside the popup
        scroll_up = "<c-u>", -- binding to scroll up inside the popup
    },
    window = {
        border = "rounded", -- none, single, double, shadow
        position = "bottom", -- bottom, top
        margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
        padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
        winblend = 0,
    },
    layout = {
        height = { min = 4, max = 25 }, -- min and max height of the columns
        width = { min = 20, max = 50 }, -- min and max width of the columns
        spacing = 3, -- spacing between columns
        align = "left", -- align columns left, center or right
    },
    ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
    show_help = true, -- show help message on the command line when the popup is visible
    triggers = "auto", -- automatically setup triggers
    -- triggers = {"<leader>"} -- or specify a list manually
    triggers_blacklist = {
        -- list of mode / prefixes that should never be hooked by WhichKey
        -- this is mostly relevant for key maps that start with a native binding
        -- most people should not need to change this
        i = { "j", "k" },
        v = { "j", "k" },
    },
}

local opts = {
    mode = "n", -- NORMAL mode
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
    -- Bufferline and buffer management
    ["gb"] = { "<cmd>BufferLinePick<CR>", "Pick a buffer" },
    --[[ ["<S-l>"] = { "<cmd>BufferLineCycleNext<CR>", "Cycle to next buffer" }, ]]
    --[[ ["<S-h>"] = { "<cmd>BufferLineCyclePrev<CR>", "Cycle to previous buffer" }, ]]
    ["gf"] = {
        function()
            vim.api.nvim_command("vertical wincmd F")
        end,
        "goto file in specified line in vertical split",
    },
    ["<leader>"] = {
        name = "Some utility leader mappings",
        ["<leader>"] = {
            function()
                require("prettier")
                vim.api.nvim_command("Prettier")
            end,
            "Use prettier",
        },
    },
    ["<leader>c"] = { "<cmd>TSContextToggle<CR>", "Toggle treesitter context" },
    ["<leader>b"] = {
        c = {
            name = "Closing buffers (options)",
            l = { "<cmd>BufferLineCloseLeft<CR>", "Buffers to the left" },
            r = { "<cmd>BufferLineCloseRight<CR>", "Buffers to the right" },
            c = { "<cmd>BufferLinePickClose<CR>", "Choose buffer" },
        },
        s = {
            function()
                require("telescope.builtin").buffers(
                    require("telescope.themes").get_dropdown({ previewer = false })
                )
            end,
            "Show buffers",
        },
    },
    -- vimtex
    ["<leader>v"] = {
        v = { "<cmd>VimtexView<CR>", "View PDF" },
        c = { "<cmd>VimtexCompile<CR>", "Compile" },
        s = { "<cmd>VimtexStop<CR>", "Stop compilation" },
        t = { "<cmd>VimtexTocToggle<CR><C-h>", "Toggle TOC" },
        o = { "<cmd>VimtexCompileOutput<CR>", "Toggle output" },
        w = { "<cmd>VimtexCountWords<CR>", "Count words" },
    },

    -- Resizing windows
    ["<C-Down>"] = { "<cmd>resize -2<CR>", "Resize window up" },
    ["<C-Up>"] = { "<cmd>resize +2<CR>", "Resize window down" },
    ["<C-Left>"] = { "<cmd>vertical resize -2<CR>", "Resize window left" },
    ["<C-Right>"] = { "<cmd>vertical resize +2<CR>", "Resize window right" },

    ["<C-A-J>"] = { "<cmd>resize -2<CR>", "Resize window up" },
    ["<C-A-K>"] = { "<cmd>resize +2<CR>", "Resize window down" },
    ["<C-A-H>"] = { "<cmd>vertical resize -2<CR>", "Resize window left" },
    ["<C-A-L>"] = { "<cmd>vertical resize +2<CR>", "Resize window right" },

    -- Moving around in windows
    ["<C-h>"] = { "<cmd>TmuxNavigateLeft<cr>", "Move to window on the left" },
    ["<C-l>"] = { "<cmd>TmuxNavigateRight<cr>", "Move to window on the right" },
    ["<C-j>"] = { "<cmd>TmuxNavigateDown<cr>", "Move to the bottom window" },
    ["<C-k>"] = { "<cmd>TmuxNavigateUp<cr>", "Move to the upper window" },
    ["<C-\\>"] = { "<cmd>TmuxNavigatePrevious<cr>", "Move to previous window" },

    -- Move between prev and next buffer
    ["<C-A-i>"] = { "<cmd>bnext<cr>", "Jump to next buffer" },
    ["<C-A-o>"] = { "<cmd>bprev<cr>", "Jump to previous buffer" },

    -- Utility
    -- [";"] = { ":", "Allow to save a keystroke" },
    -- ["<C-b>"] = { "<C-v>", "Visual block mode" },
    ["<leader>w"] = { "<cmd>w!<CR>", "Save" },
    ["<leader>W"] = { "<cmd>wq!<CR>", "Save and quit" },
    ["<leader>q"] = { "<cmd>q<CR>", "Quit" },
    ["<C-q>"] = { "<cmd>q<CR>", "Quit" },
    -- ["<leader>c"] = { "<cmd>quitall<CR>", "Quit all" },
    ["<leader>C"] = { "<cmd>quitall!<CR>", "Quit all. NOW!" },
    ["<leader>y"] = {
        function()
            require("telescope").extensions.neoclip.default()
        end,
        "Neoclip saved yanks",
    },
    ["<leader>z"] = {
        function()
            require("zen-mode").toggle()
        end,
        "Toggle zen-mode",
    },
    ["<leader>x"] = { "<cmd>HopWord<CR>", "Hop to any word" },
    ["<leader>X"] = { "<cmd>HopAnywhere<CR>", "Hop to anywhere" },
    ["<F8>"] = { "<cmd>TagbarToggle<CR>", "Show ctags" },
    --[[ -- System clipboard ]]
    --[[ ["<space>yy"] = { '"+yy' }, ]]
    --[[ ["<space>yg_"] = { '"+yg_' }, ]]
    --[[ ["<space>p"] = { '"+p' }, ]]
    --[[ ["<space>P"] = { '"+P' }, ]]

    -- nvim-tree/file explorer
    -- ["<leader>e"] = { "<cmd>Neotree toggle<CR>", "Open neotree" },
    --[[ ["<leader>e"] = { ]]
    --[[ 	name = "Explorer", ]]
    --[[ 	e = { "<cmd>NvimTreeToggle<cr>", "Toggle" }, ]]
    --[[ 	o = { "<cmd>NvimTreeOpen<cr>", "Open" }, ]]
    --[[ 	c = { "<cmd>NvimTreeClose<cr>", "Close" }, ]]
    --[[ 	r = { "<cmd>NvimTreeRefresh<cr>", "Refresh" }, ]]
    --[[ }, ]]

    -- telescope
    ["<leader>A"] = {
        function()
            require("telescope.builtin").live_grep()
        end,
        "Find Text",
    },
    ["<leader>a"] = {
        function()
            require("telescope").extensions.ripgrep.ripgrep_text({
                path_display = { "absolute" },
            })
        end,
        "Use rg to find files",
    },
    ["<leader>F"] = {
        function()
            require("telescope").extensions.ripgrep.ripgrep_files({
                path_display = { "absolute" },
                layout_strategy = "vertical",
                theme = "dropdown",
            })
        end,
        "Use rg to find files",
    },
    ["<leader>f"] = {
        function()
            require("telescope.builtin").find_files()
        end,
        "Find files",
    },
    ["<leader>i"] = {
        function()
            require("telescope.builtin").git_files()
        end,
        "Find files",
    },
    -- ["<leader>F"] = { "<cmd>Telescope live_grep<cr>", "Find Text" },
    ["<leader>P"] = {
        function()
            require("telescope").extensions.projects.projects()
        end,
        "Projects",
    },
    -- UndoTree
    ["<leader>U"] = { "<cmd>UndotreeToggle<cr>", "Toggle Undotree" },

    -- still harpoon
    ["<M-A>"] = {
        function()
            require("harpoon.ui").nav_file(1)
        end,
        "Navigate to 1st harpoon file",
    },
    ["<M-S>"] = {
        function()
            require("harpoon.ui").nav_file(2)
        end,
        "Navigate to 2st harpoon file",
    },
    ["<M-D>"] = {
        function()
            require("harpoon.ui").nav_file(3)
        end,
        "Navigate to 3st harpoon file",
    },
    ["<M-F>"] = {
        function()
            require("harpoon.ui").nav_file(4)
        end,
        "Navigate to 4st harpoon file",
    },
    ["<M-G>"] = {
        function()
            require("harpoon.ui").nav_file(5)
        end,
        "Navigate to 5st harpoon file",
    },
    ["<M-H>"] = {
        function()
            require("harpoon.ui").nav_file(6)
        end,
        "Navigate to 6st harpoon file",
    },
    ["<M-J>"] = {
        function()
            require("harpoon.ui").nav_file(7)
        end,
        "Navigate to 7st harpoon file",
    },

    ["<space>"] = {
        -- harpoon
        ["h"] = {
            function()
                require("telescope").extensions.harpoon.marks()
            end,
            "Harpoon marks in telescope",
        },
        ["H"] = {
            function()
                require("harpoon.ui").toggle_quick_menu()
            end,
            "Harpoon menu",
        },
        ["m"] = {
            function()
                require("harpoon.mark").add_file()
            end,
            "Add file to harpoon",
        },
        ["n"] = {
            function()
                require("harpoon.ui").nav_next()
            end,
            "Navigate to next harpoon file",
        },
        ["p"] = {
            function()
                require("harpoon.ui").nav_prev()
            end,
            "Navigate to prev harpoon file",
        },
        ["1"] = {
            function()
                require("harpoon.ui").nav_file(1)
            end,
            "Navigate to 1st harpoon file",
        },
        ["2"] = {
            function()
                require("harpoon.ui").nav_file(2)
            end,
            "Navigate to 2nd harpoon file",
        },
        ["3"] = {
            function()
                require("harpoon.ui").nav_file(3)
            end,
            "Navigate to 3rd harpoon file",
        },
        ["4"] = {
            function()
                require("harpoon.ui").nav_file(4)
            end,
            "Navigate to 4th harpoon file",
        },
        ["5"] = {
            function()
                require("harpoon.ui").nav_file(5)
            end,
            "Navigate to 5th harpoon file",
        },
        ["6"] = {
            function()
                require("harpoon.ui").nav_file(6)
            end,
            "Navigate to 6th harpoon file",
        },
        ["7"] = {
            function()
                require("harpoon.ui").nav_file(7)
            end,
            "Navigate to 7th harpoon file",
        },
        ["8"] = {
            function()
                require("harpoon.ui").nav_file(8)
            end,
            "Navigate to 8th harpoon file",
        },
        ["9"] = {
            function()
                require("harpoon.ui").nav_file(9)
            end,
            "Navigate to 9th harpoon file",
        },

        -- quickfix jumping
        [","] = { "<cmd>cprev<cr>", "Go to prev quickfix entry" },
        ["."] = { "<cmd>cnext<cr>", "Go to next quickfix entry" },
        ["c"] = { "<cmd>cclose<cr>", "Close quickfix" },
    },

    -- ["<leader>w"] = {
    --
    -- },
    --
    --["<leader>j"] = {
    --	name = "Jupyter",
    --	["]x"] = { "ctrih]h<CR><CR>" }
    --},
    --
    -- git utilities
    ["<leader>g"] = {
        name = "Git",
        s = {
            function()
                require("neogit").open()
            end,
            "Open neogit menu",
        },
        d = {
            function()
                require("diffview").open()
            end,
            "Open diffview",
        },
        c = {
            function()
                require("diffview").close()
            end,
            "Close diffview",
        },
        r = {
            function()
                require("diffview").refresh()
            end,
            "Refresh diffview",
        },
        h = {
            function()
                vim.cmd([[cgetexpr system("hunkqf")]])
                vim.cmd([[copen]])
            end,
            "Get all git diff hunks into a quickfix list",
        },
        g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
        q = {
            function()
                require("gitsigns").setqflist()
            end,
            "hunks into quickfix",
        },
        j = {
            function()
                gitsigns = require("gitsigns")
                gitsigns.next_hunk()
            end,
            "Next Hunk",
        },
        J = {
            function()
                gitsigns = require("gitsigns")
                gitsigns.next_hunk()
                gitsigns.preview_hunk_inline()
            end,
            "Next Hunk",
        },
        k = {
            function()
                gitsigns = require("gitsigns")
                gitsigns.prev_hunk()
            end,
            "Prev Hunk",
        },
        K = {
            function()
                gitsigns = require("gitsigns")
                gitsigns.prev_hunk()
                gitsigns.preview_hunk_inline()
                -- vim.schedule(function()
                -- 	vim.cmd [[norm zt]]
                -- end)
            end,
            "Prev Hunk",
        },
        l = {
            function()
                require("gitsigns").blame_line()
            end,
            "Blame",
        },
        p = {
            function()
                require("gitsigns").preview_hunk()
            end,
            "Preview Hunk",
        },
        P = {
            function()
                require("gitsigns").preview_hunk_inline()
            end,
            "Preview Hunk",
        },
        R = {
            function()
                require("gitsigns").reset_buffer()
            end,
            "Reset Buffer",
        },
        u = {
            function()
                require("gitsigns").undo_stage_hunk()
            end,
            "Undo Stage Hunk",
        },
        o = {
            function()
                require("telescope.builtin").git_status()
            end,
            "Open changed file",
        },
        b = {
            function()
                require("telescope.builtin").git_branches()
            end,
            "Checkout branch",
        },
        -- c = {
        --     function()
        --         require("telescope.builtin").git_commits()
        --     end,
        --     "Checkout commit",
        -- },
        w = {
            function()
                require("telescope").extensions.git_worktree.git_worktrees()
            end,
            "Change worktree",
        },
        C = {
            function()
                require("telescope").extensions.git_worktree.create_git_worktree()
            end,
            "Create a work tree",
        },
    },

    -- LSP utilities
    ["<leader>l"] = {
        name = "LSP",
        a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
        d = { "<cmd>Telescope diagnostics bufnr=0<cr>", "Document Diagnostics" },
        w = { "<cmd>Telescope diagnostics<cr>", "Workspace Diagnostics" },
        f = { "<cmd>lua require('conform').format()<cr>", "Format" },
        i = { "<cmd>LspInfo<cr>", "Info" },
        I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
        j = { "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", "Next Diagnostic" },
        k = { "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>", "Prev Diagnostic" },
        l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
        q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
        r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
        v = {
            function()
                if LSP_DIAGNOSTICS_HIDDEN == nil then
                    LSP_DIAGNOSTICS_HIDDEN = false
                end
                if LSP_DIAGNOSTICS_HIDDEN then
                    vim.diagnostic.config({ virtual_text = true, signs = true, underline = true })
                    LSP_DIAGNOSTICS_HIDDEN = false
                    return
                end
                vim.diagnostic.config({ virtual_text = false, signs = false, underline = false })
                LSP_DIAGNOSTICS_HIDDEN = true
            end,
            "Toggle virtual text and signs",
        },
        s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
        S = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace Symbols" },
        t = { "<cmd> Telescope tags<cr>", "Show tags" },
        R = {
            function()
                vim.api.nvim_command("LspRestart")
                vim.diagnostic.reset()
            end,
            "Restart LSP",
        },
    },

    -- DAP
    ["<leader>d"] = {
        name = "DAP",
        -- keymap("n", "<leader>db", function() require'dap'.toggle_breakpoint() end, opts)
        -- keymap("n", "<leader>dc", function() require'dap'.continue() end, opts)
        -- keymap("n", "<leader>di", function() require'dap'.step_into() end, opts)
        -- keymap("n", "<leader>do", function() require'dap'.step_over() end, opts)
        -- keymap("n", "<leader>dO", function() require'dap'.step_out() end, opts)
        -- keymap("n", "<leader>dr", function() require'dap'.repl.toggle() end, opts)
        -- keymap("n", "<leader>dl", function() require'dap'.run_last() end, opts)
        -- keymap("n", "<leader>du", function() require'dapui'.toggle() end, opts)
        -- keymap("n", "<leader>dt", function() require'dap'.terminate() end, opts)
        b = {
            function()
                require("dap").toggle_breakpoint()
            end,
            "Toggle breakpoint",
        },
        B = {
            function()
                local conditional = vim.fn.input("Enter conditional: ")
                require("dap").set_breakpoint(conditional)
            end,
            "Toggle breakpoint",
        },
        c = {
            function()
                require("dap").continue()
            end,
            "Continue",
        },
        p = {
            function()
                require("dap").pause()
            end,
            "Pause",
        },
        i = {
            function()
                require("dap").step_into()
            end,
            "Step into",
        },
        o = {
            function()
                require("dap").step_over()
            end,
            "Step over",
        },
        O = {
            function()
                require("dap").step_out()
            end,
            "Step out",
        },
        r = {
            function()
                require("dap").repl.toggle()
            end,
            "Toggle REPL",
        },
        l = {
            function()
                require("dap").run_last()
            end,
            "Run last",
        },
        u = {
            function()
                require("dapui").toggle()
            end,
            "Toggle UI",
        },
        t = {
            function()
                require("dap").terminate()
            end,
            "Terminate",
        },
    },

    ["<leader>s"] = {
        name = "Search",
        b = {
            function()
                require("telescope.builtin").git_branches()
            end,
            "Checkout branch",
        },
        c = {
            function()
                require("telescope.builtin").colorscheme()
            end,
            "Colorscheme",
        },
        h = {
            function()
                require("telescope.builtin").help_tags()
            end,
            "Find Help",
        },
        M = {
            function()
                require("telescope.builtin").man_pages()
            end,
            "Man Pages",
        },
        R = {
            function()
                require("telescope.builtin").registers()
            end,
            "Registers",
        },
        k = {
            function()
                require("telescope.builtin").keymaps()
            end,
            "Keymaps",
        },
        C = {
            function()
                require("telescope.builtin").commands()
            end,
            "Commands",
        },
        r = {
            function()
                require("spectre").open()
            end,
            "Replace with Spectre",
        },
    },

    ["<leader>t"] = {
        name = "Trouble",
        s = { "<cmd>TroubleToggle<cr>", "Show/Hide (Toggle)" },
        r = { "<cmd>TroubleRefresh<cr>", "Refresh" },
        t = { "<cmd>TodoTrouble<cr>", "Open todo items in trouble" },
    },

    -- ["<C-t>"] = { "<cmd>6 split term://zsh<cr>", "Open horizontal terminal" },
    ["<C-t>"] = { "<cmd>TermToggle<cr>", "Open horizontal terminal" },
    ["<leader>T"] = {
        name = "Terminal",
        f = { "<cmd>terminal<cr>", "Open fullscreen terminal" },
        v = { "<cmd>vsplit term://zsh<cr>", "Open vertical split terminal" },
        h = { "<cmd>6 split term://zsh<cr>", "Open horizontal split terminal" },
    },

    ["<leader>n"] = {
        name = "Notifications",
        d = {
            function()
                require("notify").dismiss()
            end,
            "Dismiss all notifications",
        },
        s = { "<cmd>Notifications<cr>", "Show notifications" },
    },

    -- ["<leader>t"] = {
    -- 	name = "Terminal",
    -- 	n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" },
    -- 	u = { "<cmd>lua _NCDU_TOGGLE()<cr>", "NCDU" },
    -- 	t = { "<cmd>lua _HTOP_TOGGLE()<cr>", "Htop" },
    -- 	p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
    -- 	l = { "<cmd>lua _LAZYGIT_TOGGLE()<cr>", "LazyGit" },
    -- 	f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
    -- 	h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
    -- 	v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
    -- },
    ["\\"] = { "<cmd>lua require('conform').format({ async = true })<cr>", "Format" },

    ["-"] = {
        function()
            local oil = require("oil")
            local curr_buf = vim.api.nvim_get_current_buf()
            local buf_name = vim.api.nvim_buf_get_name(curr_buf)
            -- check if oil is in buf_name
            local is_open = buf_name:find("oil://") ~= nil
            if is_open then
                oil.close()
            else
                oil.open()
            end
        end,
        "Toggle oil.nvim",
    },
    ["<leader>o"] = {
        ["s"] = {
            function()
                require("oil").open()
            end,
            "Open oil.nvim",
        },
        ["c"] = {
            function()
                require("oil").close()
            end,
            "Close oil.nvim",
        },
    },

    -- ["<leader>e"] = { function() require('oil').open() end, "Open oil.nvim" },
    -- ["<leader>e"] = { ",

    ["zm"] = { "zz", "Center screen vertically" },

    ["<M-,>"] = {
        function()
            local a = vim.fn.getqflist({ winid = 1 }).winid
            if a ~= 0 then
                pcall(vim.api.nvim_command, "cprev")
            else
                require("trouble").previous({ skip_groups = true, jump = true })
            end
            vim.api.nvim_command("norm zz")
        end,
        "Prev entry in qflist or trouble",
    },
    ["<M-.>"] = {
        function()
            local a = vim.fn.getqflist({ winid = 1 }).winid
            if a ~= 0 then
                pcall(vim.api.nvim_command, "cnext")
            else
                require("trouble").next({ skip_groups = true, jump = true })
            end
            vim.api.nvim_command("norm zz")
        end,
        "Prev entry in qflist or trouble",
    },
}

-- Bindings for moving lines up and down
local mappings_n = {
    ["<S-h>"] = { "^", "Go to line start" },
    ["<S-l>"] = { "$", "Go to line end" },
    -- ["<S-m>"] = { "J", "Concatenate next line" },
    -- ["<S-k>"] = { "<cmd>MoveLine(-1)<CR>", "Move line up" },
    -- ["<S-j>"] = { "<cmd>MoveLine(1)<CR>", "Move line down" },
    [">"] = { ">>", "Indent" },
    ["<"] = { "<<", "Dedent" },
    ["zR"] = { require("ufo").openAllFolds, "Open all folds" },
    ["zM"] = { require("ufo").closeAllFolds, "Close all folds" },
    ["zK"] = {
        function()
            local winid = require("ufo").peekFoldedLinesUnderCursor()
            if not winid then
                vim.lsp.buf.hover()
            end
        end,
        "Peek into a fold",
    },
}

-- better w, e, b, ge motions
--[[ vim.keymap.set({"n", "o", "x"}, "w", "<cmd>lua require('spider').motion('w')<CR>", { desc = "Spider-w" }) ]]
--[[ vim.keymap.set({"n", "o", "x"}, "e", "<cmd>lua require('spider').motion('e')<CR>", { desc = "Spider-e" }) ]]
--[[ vim.keymap.set({"n", "o", "x"}, "b", "<cmd>lua require('spider').motion('b')<CR>", { desc = "Spider-b" }) ]]
--[[ vim.keymap.set({"n", "o", "x"}, "ge", "<cmd>lua require('spider').motion('ge')<CR>", { desc = "Spider-ge" }) ]]
local mappings_v = {
    ["<S-m>"] = { "J", "Concatenate lines" },
    ["<S-j>"] = { ":m '>+1<cr>gv=gv", "Move lines up" },
    ["<S-k>"] = { ":m '<-2<cr>gv=gv", "Move lines down" },
    -- ["<S-k>"] = { ":'<,'>MoveBlock(-1)<CR>", "Move lines up" },
    -- ["<S-j>"] = { ":'<,'>MoveBlock(1)<CR>", "Move lines down" },
    --[[ ["<C-r>"] = { ":'<,'>SearchReplaceSingleBufferVisualSelection<CR>" }, ]]
    --[[ ["<C-s>"] = { ":'<,'>SearchReplaceWithinVisualSelection<CR>" }, ]]
    --[[ ["<C-b>"] = { ":'<,'>SearchReplaceWithinVisualSelectionCWord<CR>" }, ]]
    --[[ ["<space>y"] = { '"+y' }, ]]
    --[[ ["<space>p"] = { "+p" }, ]]
    --[[ ["<space>P"] = { "+P" }, ]]
}

local opts_v = {
    mode = "v",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = true,
}

local mappings_i = {
    ["<C-t>"] = { "<cmd>TermToggle<cr>", "Open horizontal terminal" },
    -- ["<C-h>"] = { "<cmd>exe 'norm b' | startinsert<cr>", "Move one word to the left" },
    -- ["<C-l>"] = { "<cmd>exe 'norm w' | startinsert<cr>", "Move one word to the right" },
    -- ["<C-j>"] = { "<Down>", "Move one line up" },
    -- ["<C-k>"] = { "<Up>", "Move one line down" },
    ["<M-w>"] = { "<cmd>exe 'norm dw' | startinsert<cr>", "Remove word in front" },
}

local opts_i = {
    mode = "i",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = true,
}

local mappings_x = {
    ["l"] = { "l", "move right" },
}

local opts_x = {
    mode = "x",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = true,
}

-- remove binding that prevents movement in visual mode from being instant
-- vim.keymap.del({ "x" }, "l=")

-- visual selection replacement
vim.api.nvim_set_keymap("v", "<C-r>", "<CMD>SearchReplaceSingleBufferVisualSelection<CR>", {})
vim.api.nvim_set_keymap("v", "<C-s>", "<CMD>SearchReplaceWithinVisualSelection<CR>", {})
vim.api.nvim_set_keymap("v", "<C-b>", "<CMD>SearchReplaceWithinVisualSelectionCWord<CR>", {})

vim.api.nvim_set_keymap("t", "<C-q>", "<CMD>q!<CR>", {})
vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", {})
vim.api.nvim_set_keymap("t", "<C-t>", "<CMD>TermToggle<CR>", {})
vim.api.nvim_set_keymap("t", "<C-j>", "<cmd>TmuxNavigateDown<cr>", {})
vim.api.nvim_set_keymap("t", "<C-k>", "<cmd>TmuxNavigateUp<cr>", {})
vim.api.nvim_set_keymap("t", "<C-h>", "<cmd>TmuxNavigateLeft<cr>", {})
vim.api.nvim_set_keymap("t", "<C-l>", "<cmd>TmuxNavigateRight<cr>", {})

vim.api.nvim_set_keymap("i", "<C-j>", "<esc><cmd>TmuxNavigateDown<cr>", {})
vim.api.nvim_set_keymap("i", "<C-k>", "<esc><cmd>TmuxNavigateUp<cr>", {})
vim.api.nvim_set_keymap("i", "<C-h>", "<esc><cmd>TmuxNavigateLeft<cr>", {})
vim.api.nvim_set_keymap("i", "<C-l>", "<esc><cmd>TmuxNavigateRight<cr>", {})

vim.api.nvim_set_keymap("n", "<C-d>", "<C-d>zz", {})
vim.api.nvim_set_keymap("n", "<C-u>", "<C-u>zz", {})
vim.api.nvim_set_keymap("n", "<C-f>", "<C-f>zz", {})
vim.api.nvim_set_keymap("n", "<C-b>", "<C-b>zz", {})
vim.api.nvim_set_keymap("n", "n", "nzz", {})
vim.api.nvim_set_keymap("n", "N", "Nzz", {})
vim.api.nvim_set_keymap("n", "*", "*zz", {})
vim.api.nvim_set_keymap("n", "#", "#zz", {})
vim.api.nvim_set_keymap("n", "g*", "g*zz", {})
vim.api.nvim_set_keymap("n", "g#", "g#zz", {})

-- vim.api.nvim_set_keymap("n", "<M-,>", get_prev_entry, {})
-- vim.api.nvim_set_keymap("n", "<M-.>", get_next_entry, {})
vim.api.nvim_set_keymap("n", "<M-;>", "<cmd>cpfile<cr>", {})
vim.api.nvim_set_keymap("n", "<M-'>", "<cmd>cnfile<cr>", {})
vim.api.nvim_set_keymap("n", "<C-i>", "<C-i>zz", {})
vim.api.nvim_set_keymap("n", "<C-o>", "<C-o>zz", {})
vim.api.nvim_set_keymap("n", "<F2>", "<cmd>Make<cr>", {})

vim.api.nvim_set_keymap("x", "<M-w>", "<esc><cmd>'<,'>!remove-widows<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<M-w>", "<S-v><esc><cmd>'<,'>!remove-widows<cr>", { noremap = true })
-- vim.keymap.set("n", "J", "mzJ`z")

which_key.setup(setup)
which_key.register(mappings, opts)
which_key.register(mappings_n, opts)
which_key.register(mappings_v, opts_v)
which_key.register(mappings_i, opts_i)
which_key.register(mappings_x, opts_x)
