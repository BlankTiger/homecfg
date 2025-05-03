vim.g.mapleader = ","
vim.g.maplocalleader = ","

local set = vim.keymap.set

-- indent/dedent
set("n", ">", ">>")
set("n", "<", "<<")

-- reload file from disk
set("n", "<leader>r", ":e!<cr>")

-- remove buffer completely from memory
set("n", "<space>w", "<cmd>bw!<cr>", {})

-- zz -> zm
set("n", "zm", "zz")

-- scrolling with arrow keys
set("n", "<left>", "zh")
set("n", "<right>", "zl")
set("n", "<up>", "<c-y>")
set("n", "<down>", "<c-e>")

-- splits
set("n", "gs", "<cmd>vs<cr>")
set("n", "gh", "<cmd>sp<cr>")

-- ???
set("n", "gi", "`^zzi")

-- resizing splits
set("n", "<C-Down>", ":resize -2<CR>")
set("n", "<C-Up>", ":resize +2<CR>")
set("n", "<C-Left>", ":vertical resize -2<CR>")
set("n", "<C-Right>", ":vertical resize +2<CR>")

set("n", "<C-A-J>", ":resize -2<CR>")
set("n", "<C-A-K>", ":resize +2<CR>")
set("n", "<C-A-H>", ":vertical resize -2<CR>")
set("n", "<C-A-L>", ":vertical resize +2<CR>")

-- moving between loaded buffers like with C-o, C-i
set("n", "<C-A-i>", ":bnext<cr>")
set("n", "<C-A-o>", ":bprev<cr>")

-- saving and quitting
set("n", "<leader>w", ":w!<CR>")
set("n", "<leader>W", ":wq!<CR>")
set("n", "<leader>q", ":q<CR>")
set("n", "<C-q>", ":q<CR>")
set("n", "<A-q>", ":q!<CR>")
set("n", "<A-q>", ":q!<CR>")
set("n", "<leader>C", ":quitall!<CR>")

-- tabs

set({ "t", "n", "i" }, "<M-Z>", function()
    pcall(vim.api.nvim_command, "tabnext 1")
end)
set({ "t", "n", "i" }, "<M-X>", function()
    pcall(vim.api.nvim_command, "tabnext 2")
end)
set({ "t", "n", "i" }, "<M-C>", function()
    pcall(vim.api.nvim_command, "tabnext 3")
end)
set({ "t", "n", "i" }, "<M-V>", function()
    pcall(vim.api.nvim_command, "tabnext 4")
end)
set({ "t", "n", "i" }, "<M-B>", function()
    pcall(vim.api.nvim_command, "tabnext 5")
end)
set({ "t", "n", "i" }, "<M-N>", function()
    pcall(vim.api.nvim_command, "tabnext 6")
end)
set({ "t", "n", "i" }, "<M-M>", function()
    pcall(vim.api.nvim_command, "tabnext 7")
end)
set({ "t", "n", "i" }, "<M-,>", function()
    pcall(vim.api.nvim_command, "tabnext 8")
end)
set({ "t", "n", "i" }, "<M-.>", function()
    pcall(vim.api.nvim_command, "tabnext 9")
end)

-- open current split (current window) in a new tab
set("n", "<leader>tn", "<cmd>tab split<cr>")

-- quickfix navigation
set("n", "<M-,>", function()
    local ok, _ = pcall(vim.api.nvim_command, "cprev")
    if ok then
        vim.api.nvim_command("norm zz")
    end
end)
set("n", "<M-.>", function()
    local ok, _ = pcall(vim.api.nvim_command, "cnext")
    if ok then
        vim.api.nvim_command("norm zz")
    end
end)
set("n", "<M-;>", ":cpfile<cr>")
set("n", "<M-'>", ":cnfile<cr>")

-- concat lines in visual mode, because I have J remapped to moving blocks
set("v", "<S-m>", "J")
set("v", "<S-j>", ":m '>+1<cr>gv=gv")
set("v", "<S-k>", ":m '<-2<cr>gv=gv")

-- terminal

-- fullscreen terminal in new tab
set("n", "<leader>to", ":tabnew | term<cr>")

-- terminal in a split to the left
set("n", "<leader>th", function()
    local opt = vim.opt.splitright
    vim.opt.splitright = false
    vim.api.nvim_command("vs term://" .. vim.g.shell)
    vim.opt.splitright = opt
end)

-- terminal in a split to the right
set("n", "<leader>tl", function()
    local opt = vim.opt.splitright
    vim.opt.splitright = true
    vim.api.nvim_command("vs term://" .. vim.g.shell)
    vim.opt.splitright = opt
end)

-- toggle a horizontal terminal via my own command
set({ "n", "t" }, "<C-t>", ":TermToggle<cr>")

-- close terminal window forcefully by default
set("t", "<C-q>", ":q!<cr>")
-- make esc work
set("t", "<esc>", "<C-\\><C-n>")
-- navigating through jumplist without doing <esc>
set("t", "<C-o>", "<C-\\><C-n><C-o>")
set("t", "<C-i>", "<C-\\><C-n><C-i>")

-- remove full line like dd
set("n", "<A-d>", "dd")

-- search and replace visual selection
set("v", "//", [["hy:%s/<C-r>h//gc<left><left><left>]], { noremap = true })

-- navigating through splits and tmux panes without any hassle
set("t", "<c-h>", "<C-\\><C-n><cmd>TmuxNavigateLeft<cr>")
set("t", "<c-j>", "<C-\\><C-n><cmd>TmuxNavigateDown<cr>")
set("t", "<c-k>", "<C-\\><C-n><cmd>TmuxNavigateUp<cr>")
set("t", "<c-l>", "<C-\\><C-n><cmd>TmuxNavigateRight<cr>")

set("n", "<c-h>", "<cmd>TmuxNavigateLeft<cr>")
set("n", "<c-j>", "<cmd>TmuxNavigateDown<cr>")
set("n", "<c-k>", "<cmd>TmuxNavigateUp<cr>")
set("n", "<c-l>", "<cmd>TmuxNavigateRight<cr>")

set("i", "<c-h>", "<esc><cmd>TmuxNavigateLeft<cr>")
set("i", "<c-j>", "<esc><cmd>TmuxNavigateDown<cr>")
set("i", "<c-k>", "<esc><cmd>TmuxNavigateUp<cr>")
set("i", "<c-l>", "<esc><cmd>TmuxNavigateRight<cr>")

-- set : to q: (instead of cmdline have cmdwin)
vim.keymap.set("n", ":", "q:i", {})

-- quickly duplicate line I'm on and don't change the horizontal cursor position
vim.keymap.set("n", "<leader>vd", function()
    local win = vim.api.nvim_get_current_win()
    local cursorpos = vim.api.nvim_win_get_cursor(win)
    vim.api.nvim_command("norm yyp")
    cursorpos[1] = cursorpos[1] + 1
    vim.api.nvim_win_set_cursor(win, cursorpos)
end, {})

-- goto file in existing split on the left
-- or the right, if non are open then create them
local gf_to_the = require("user.custom-gf").gf_to_the
set("n", "gfh", function()
    gf_to_the({ left = true })
end)
set("n", "<C-S-H>", function()
    gf_to_the({ left = true })
end)

set("n", "gfl", function()
    gf_to_the({ left = false })
end)
set("n", "<C-S-L>", function()
    gf_to_the({ left = false })
end)

-- repeat last macro with a single key instead of toggling case
set("n", "~", "@@", {})

-- refresh keymap
set("n", "<leader>kr", function()
    vim.notify("Refreshing keymaps")
    require("user.keymaps")
end)

-- emulate the default terminal behavior of C-w
set("i", "<C-w>", function()
    -- if on last character then remove it too
    -- if not then just delete backwards
    local curpos = vim.api.nvim_win_get_cursor(0)
    if curpos[2] == vim.fn.col("$") - 1 then
        local res = vim.api.nvim_replace_termcodes("<C-o>dvb", true, false, true)
        vim.api.nvim_feedkeys(res, "i", false)
    else
        local res = vim.api.nvim_replace_termcodes("<C-o>db", true, false, true)
        vim.api.nvim_feedkeys(res, "i", false)
    end
end)

-- keep the cursor in the middle of the screen
set("n", "<C-d>", "<C-d>zz")
set("n", "<C-u>", "<C-u>zz")
set("n", "<C-f>", "<C-f>zz")
set("n", "<C-b>", "<C-b>zz")
set("n", "n", "nzz")
set("n", "N", "Nzz")
set("n", "*", "*zz")
set("n", "#", "#zz")
set("n", "g*", "g*zz")
set("n", "g#", "g#zz")
set("n", "<C-i>", "<C-i>zz")
set("n", "<C-o>", "<C-o>zz")

-- toggle line wrapping in all open windows
set("n", "<leader>gw", "<cmd>windo set wrap!<CR>")
