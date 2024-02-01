local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
	return
end

local vim = vim

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
			z = true,   -- bindings for folds, spelling and others prefixed with z
			g = true,   -- bindings for prefixed with g
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
		height = { min = 4, max = 25 },                                        -- min and max height of the columns
		width = { min = 20, max = 50 },                                        -- min and max width of the columns
		spacing = 3,                                                           -- spacing between columns
		align = "left",                                                        -- align columns left, center or right
	},
	ignore_missing = true,                                                     -- enable this to hide mappings for which you didn't specify a label
	hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
	show_help = true,                                                          -- show help message on the command line when the popup is visible
	triggers = "auto",                                                         -- automatically setup triggers
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
	mode = "n",  -- NORMAL mode
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local opts_v = {
	mode = "v",
	buffer = nil,
	silent = true,
	noremap = true,
	nowait = true,
}

local mappings = {
	-- Bufferline and buffer management
	["gb"] = { "<cmd>BufferLinePick<CR>", "Pick a buffer" },
	--[[ ["<S-l>"] = { "<cmd>BufferLineCycleNext<CR>", "Cycle to next buffer" }, ]]
	--[[ ["<S-h>"] = { "<cmd>BufferLineCyclePrev<CR>", "Cycle to previous buffer" }, ]]
	["<leader>"] = {
		name = "Some utility leader mappings",
		["<leader>"] = { "<cmd>lua require('prettier')<CR><cmd>Prettier<CR>", "Use prettier" },
	},
	-- ["<leader>c"] = { "<cmd>Bdelete!<CR>", "Close current buffer" },
	["<leader>b"] = {
		c = {
			name = "Closing buffers (options)",
			l = { "<cmd>BufferLineCloseLeft<CR>", "Buffers to the left" },
			r = { "<cmd>BufferLineCloseRight<CR>", "Buffers to the right" },
			c = { "<cmd>BufferLinePickClose<CR>", "Choose buffer" },
		},
		s = {
			"<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
			"Show buffers",
		},
	},
	-- vimtex
	["<leader>v"] = {
		v = { "<cmd>VimtexView<CR>", "View PDF" },
		c = { "<cmd>VimtexCompile<CR>", "Compile" },
		s = { "<cmd>VimtexStop<CR>", "Stop compilation" },
		t = { "<cmd>VimtexTocToggle<CR>", "Toggle TOC" },
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
	["<C-h>"] = { "<C-w>h", "Move to window on the left" },
	["<C-l>"] = { "<C-w>l", "Move to window on the right" },
	["<C-j>"] = { "<C-w>j", "Move to the bottom window" },
	["<C-k>"] = { "<C-w>k", "Move to the upper window" },

	-- Move between prev and next buffer
	["<C-A-i>"] = { "<cmd>bnext<cr>", "Jump to next buffer" },
	["<C-A-o>"] = { "<cmd>bprev<cr>", "Jump to previous buffer" },

	-- Utility
	-- [";"] = { ":", "Allow to save a keystroke" },
	-- ["<C-b>"] = { "<C-v>", "Visual block mode" },
	["<leader>w"] = { "<cmd>w!<CR>", "Save" },
	["<leader>q"] = { "<cmd>q<CR>", "Quit" },
	["<C-q>"] = { "<cmd>q<CR>", "Quit" },
	["<leader>c"] = { "<cmd>quitall<CR>", "Quit all" },
	["<leader>C"] = { "<cmd>quitall!<CR>", "Quit all. NOW!" },
	["<leader>y"] = { "<cmd>lua require('telescope').extensions.neoclip.default()<CR>", "Neoclip saved yanks" },
	["<leader>z"] = { "<cmd>lua require('zen-mode').toggle()<CR>", "Toggle zen-mode" },
	["<leader>x"] = { "<cmd>HopWord<CR>", "Hop to any word" },
	["<leader>X"] = { "<cmd>HopAnywhere<CR>", "Hop to anywhere" },
	["<F8>"] = { "<cmd>TagbarToggle<CR>", "Show ctags" },
	--[[ -- System clipboard ]]
	--[[ ["<space>yy"] = { '"+yy' }, ]]
	--[[ ["<space>yg_"] = { '"+yg_' }, ]]
	--[[ ["<space>p"] = { '"+p' }, ]]
	--[[ ["<space>P"] = { '"+P' }, ]]

	-- nvim-tree/file explorer
	["<leader>e"] = { "<cmd>Neotree toggle<CR>", "Open neotree" },
	--[[ ["<leader>e"] = { ]]
	--[[ 	name = "Explorer", ]]
	--[[ 	e = { "<cmd>NvimTreeToggle<cr>", "Toggle" }, ]]
	--[[ 	o = { "<cmd>NvimTreeOpen<cr>", "Open" }, ]]
	--[[ 	c = { "<cmd>NvimTreeClose<cr>", "Close" }, ]]
	--[[ 	r = { "<cmd>NvimTreeRefresh<cr>", "Refresh" }, ]]
	--[[ }, ]]

	-- telescope
	["<leader>a"] = {
		function()
			require("telescope")
			local input = vim.fn.input("Search pattern (ripgrep): ")
			if input == "" then
				vim.notify("You didn't enter any search pattern")
			else
				vim.cmd("Ag " .. input)
			end
		end, "Use rg to find files"
	},
	["<leader>f"] = {
		"<cmd>lua require('telescope.builtin').find_files()<cr>",
		"Find files",
	},
	["<leader>i"] = {
		"<cmd>lua require('telescope.builtin').git_files()<cr>",
		"Find files",
	},
	["<leader>F"] = { "<cmd>lua require('telescope.builtin').live_grep()<cr>", "Find Text" },
	-- ["<leader>F"] = { "<cmd>Telescope live_grep<cr>", "Find Text" },
	["<leader>P"] = { "<cmd>lua require('telescope').extensions.projects.projects()<cr>", "Projects" },
	-- UndoTree
	["<leader>U"] = { "<cmd>UndotreeToggle<cr>", "Toggle Undotree" },
	["r"] = {
		name = "SearchReplaceSingleBuffer",
		["s"] = { "<CMD>SearchReplaceSingleBufferSelections<CR>", "SearchReplaceSingleBuffer [s]elction list" },
		["o"] = { "<CMD>SearchReplaceSingleBufferOpen<CR>", "[o]pen" },
		["w"] = { "<CMD>SearchReplaceSingleBufferCWord<CR>", "[w]ord" },
		["W"] = { "<CMD>SearchReplaceSingleBufferCWORD<CR>", "[W]ORD" },
		["e"] = { "<CMD>SearchReplaceSingleBufferCExpr<CR>", "[e]xpr" },
		["f"] = { "<CMD>SearchReplaceSingleBufferCFile<CR>", "[f]ile" },
		["b"] = {
			name = "SearchReplaceMultiBuffer",
			["s"] = { "<CMD>SearchReplaceMultiBufferSelections<CR>", "SearchReplaceMultiBuffer [s]elction list" },
			["o"] = { "<CMD>SearchReplaceMultiBufferOpen<CR>", "[o]pen" },
			["w"] = { "<CMD>SearchReplaceMultiBufferCWord<CR>", "[w]ord" },
			["W"] = { "<CMD>SearchReplaceMultiBufferCWORD<CR>", "[W]ORD" },
			["e"] = { "<CMD>SearchReplaceMultiBufferCExpr<CR>", "[e]xpr" },
			["f"] = { "<CMD>SearchReplaceMultiBufferCFile<CR>", "[f]ile" },
		},
	},
	["<space>"] = {
		-- harpoon
		["H"] = { "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", "Harpoon menu" },
		["m"] = { "<cmd>lua require('harpoon.mark').add_file()<cr>", "Add file to harpoon" },
		["n"] = { "<cmd>lua require('harpoon.ui').nav_next()<cr>", "Navigate to next harpoon file" },
		["p"] = { "<cmd>lua require('harpoon.ui').nav_prev()<cr>", "Navigate to prev harpoon file" },
		["1"] = { "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", "Navigate to 1st harpoon file" },
		["a"] = { "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", "Navigate to 1st harpoon file" },
		["2"] = { "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", "Navigate to 2nd harpoon file" },
		["s"] = { "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", "Navigate to 2nd harpoon file" },
		["3"] = { "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", "Navigate to 3rd harpoon file" },
		["d"] = { "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", "Navigate to 3rd harpoon file" },
		["4"] = { "<cmd>lua require('harpoon.ui').nav_file(4)<cr>", "Navigate to 4th harpoon file" },
		["f"] = { "<cmd>lua require('harpoon.ui').nav_file(4)<cr>", "Navigate to 4th harpoon file" },
		["5"] = { "<cmd>lua require('harpoon.ui').nav_file(5)<cr>", "Navigate to 5th harpoon file" },
		["h"] = { "<cmd>lua require('harpoon.ui').nav_file(5)<cr>", "Navigate to 5th harpoon file" },
		["6"] = { "<cmd>lua require('harpoon.ui').nav_file(6)<cr>", "Navigate to 6th harpoon file" },
		["j"] = { "<cmd>lua require('harpoon.ui').nav_file(6)<cr>", "Navigate to 6th harpoon file" },
		["7"] = { "<cmd>lua require('harpoon.ui').nav_file(7)<cr>", "Navigate to 7th harpoon file" },
		["k"] = { "<cmd>lua require('harpoon.ui').nav_file(7)<cr>", "Navigate to 7th harpoon file" },
		["8"] = { "<cmd>lua require('harpoon.ui').nav_file(8)<cr>", "Navigate to 8th harpoon file" },
		["l"] = { "<cmd>lua require('harpoon.ui').nav_file(8)<cr>", "Navigate to 8th harpoon file" },
		["9"] = { "<cmd>lua require('harpoon.ui').nav_file(9)<cr>", "Navigate to 9th harpoon file" },
		["z"] = { "<cmd>lua require('harpoon.ui').nav_file(9)<cr>", "Navigate to 9th harpoon file" },
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
		h = {
			function()
				vim.cmd [[cgetexpr system("hunkqf")]]
				vim.cmd [[copen]]
			end,
			"Get all git diff hunks into a quickfix list",
		},
		g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
		q = { "<cmd>lua require('gitsigns').setqflist()<cr>", "hunks into quickfix" },
		j = {
			function()
				gitsigns = require("gitsigns")
				gitsigns.next_hunk()
			end,
			"Next Hunk"
		},
		J = {
			function()
				gitsigns = require("gitsigns")
				gitsigns.next_hunk()
				gitsigns.preview_hunk_inline()
			end,
			"Next Hunk"
		},
		k = {
			function()
				gitsigns = require("gitsigns")
				gitsigns.prev_hunk()
			end,
			"Prev Hunk"
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
			"Prev Hunk"
		},
		l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
		p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
		P = { "<cmd>lua require 'gitsigns'.preview_hunk_inline()<cr>", "Preview Hunk" },
		r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
		R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
		s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
		S = { "<cmd>lua require('gitsigns').stage_buffer()<cr>", "stage buffer" },
		u = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", "Undo Stage Hunk" },
		o = { "<cmd>lua require('telescope.builtin').git_status()<cr>", "Open changed file" },
		b = { "<cmd>lua require('telescope.builtin').git_branches()<cr>", "Checkout branch" },
		c = { "<cmd>lua require('telescope.builtin').git_commits()<cr>", "Checkout commit" },
		d = { "<cmd>Gitsigns diffthis HEAD<cr>", "Diff" },
		w = { "<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<cr>", "Change worktree" },
		C = { "<cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<cr>", "Create a work tree" },
	},

	-- LSP utilities
	["<leader>l"] = {
		name = "LSP",
		a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
		d = { "<cmd>Telescope diagnostics bufnr=0<cr>", "Document Diagnostics" },
		w = { "<cmd>Telescope diagnostics<cr>", "Workspace Diagnostics" },
		f = { "<cmd>lua vim.lsp.buf.format{async=true}<cr>", "Format" },
		i = { "<cmd>LspInfo<cr>", "Info" },
		I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
		j = { "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", "Next Diagnostic" },
		k = { "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>", "Prev Diagnostic" },
		l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
		q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
		r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
		s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
		S = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace Symbols" },
		t = { "<cmd> Telescope tags<cr>", "Show tags" },
		R = { "<cmd>LspRestart<cr>", "Restart LSP" },
	},

	-- DAP
	["<leader>d"] = {
		name = "DAP",
		-- keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
		-- keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", opts)
		-- keymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", opts)
		-- keymap("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", opts)
		-- keymap("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", opts)
		-- keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", opts)
		-- keymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", opts)
		-- keymap("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", opts)
		-- keymap("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", opts)
		b = { "<cmd>lua require'dap'.toggle_breakpoint()<CR>", "Toggle breakpoint" },
		c = { "<cmd>lua require'dap'.continue()<CR>", "Continue" },
		p = { "<cmd>lua require'dap'.pause()<CR>", "Pause" },
		i = { "<cmd>lua require'dap'.step_into()<CR>", "Step into" },
		o = { "<cmd>lua require'dap'.step_over()<CR>", "Step over" },
		O = { "<cmd>lua require'dap'.step_out()<CR>", "Step out" },
		r = { "<cmd>lua require'dap'.repl.toggle()<CR>", "Toggle REPL" },
		l = { "<cmd>lua require'dap'.run_last()<CR>", "Run last" },
		u = { "<cmd>lua require'dapui'.toggle()<CR>", "Toggle UI" },
		t = { "<cmd>lua require'dap'.terminate()<CR>", "Terminate" },
	},

	["<leader>s"] = {
		name = "Search",
		b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
		c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
		h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
		M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
		R = { "<cmd>Telescope registers<cr>", "Registers" },
		k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
		C = { "<cmd>Telescope commands<cr>", "Commands" },
		r = { "<cmd>lua require('spectre').open()<cr>", "Replace with Spectre" },
	},

	["<leader>t"] = {
		name = "Trouble",
		s = { "<cmd>TroubleToggle<cr>", "Show/Hide (Toggle)" },
		r = { "<cmd>TroubleRefresh<cr>", "Refresh" },
		t = { "<cmd>TodoTrouble<cr>", "Open todo items in trouble" },
	},

	["<C-t>"] = { "<cmd>6 split term://zsh<cr>", "Open horizontal terminal" },
	["<leader>T"] = {
		name = "Terminal",
		f = { "<cmd>terminal<cr>", "Open fullscreen terminal" },
		v = { "<cmd>vsplit term://zsh<cr>", "Open vertical split terminal" },
		h = { "<cmd>6 split term://zsh<cr>", "Open horizontal split terminal" },
	},

	["<leader>n"] = {
		name = "Notifications",
		d = { "<cmd>lua require('notify').dismiss()<cr>", "Dismiss all notifications" },
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
	["\\"] = { "<cmd>lua vim.lsp.buf.format{async=true}<cr>", "Format" },

	["<leader>o"] = { "<cmd>lua require('oil').open_float()<cr>", "Open oil.nvim in a floating window" },
	-- ["<leader>e"] = { "<cmd>lua require('oil').open()<cr>", "Open oil.nvim" },

	["zm"] = { "zz", "Center screen vertically" },

	["<M-,>"] = {
		function()
			local a = vim.fn.getqflist({ winid = 1 }).winid
			if a ~= 0 then
				vim.api.nvim_command("cprev")
			else
				require("trouble").previous({ skip_groups = true, jump = true })
			end
		end,
		"Prev entry in qflist or trouble"
	},
	["<M-.>"] = {
		function()
			local a = vim.fn.getqflist({ winid = 1 }).winid
			if a ~= 0 then
				vim.api.nvim_command("cnext")
			else
				require("trouble").next({ skip_groups = true, jump = true })
			end
		end,
		"Prev entry in qflist or trouble"
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

-- visual selection replacement
vim.api.nvim_set_keymap("v", "<C-r>", "<CMD>SearchReplaceSingleBufferVisualSelection<CR>", {})
vim.api.nvim_set_keymap("v", "<C-s>", "<CMD>SearchReplaceWithinVisualSelection<CR>", {})
vim.api.nvim_set_keymap("v", "<C-b>", "<CMD>SearchReplaceWithinVisualSelectionCWord<CR>", {})

vim.api.nvim_set_keymap("t", "<C-q>", "<CMD>q!<CR>", {})
vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", {})

vim.api.nvim_set_keymap("n", "<C-d>", "<C-d>zz", {})
vim.api.nvim_set_keymap("n", "<C-u>", "<C-u>zz", {})
vim.api.nvim_set_keymap("n", "<C-f>", "<C-f>zz", {})
vim.api.nvim_set_keymap("n", "<C-b>", "<C-b>zz", {})

-- vim.api.nvim_set_keymap("n", "<M-,>", get_prev_entry, {})
-- vim.api.nvim_set_keymap("n", "<M-.>", get_next_entry, {})
vim.api.nvim_set_keymap("n", "<M-;>", "<cmd>cpfile<cr>", {})
vim.api.nvim_set_keymap("n", "<M-'>", "<cmd>cnfile<cr>", {})
vim.api.nvim_set_keymap("n", "<C-i>", "<C-i>zz", {})
vim.api.nvim_set_keymap("n", "<C-o>", "<C-o>zz", {})

-- vim.keymap.set("n", "J", "mzJ`z")

which_key.setup(setup)
which_key.register(mappings, opts)
which_key.register(mappings_n, opts)
which_key.register(mappings_v, opts_v)
