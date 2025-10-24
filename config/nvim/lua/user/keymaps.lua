vim.g.mapleader = ","
vim.g.maplocalleader = ","

local set = vim.keymap.set

-- normal mode opts
local n_opts = vim.g.n_opts

-- indent/dedent
set("n", ">", ">>", n_opts)
set("n", "<", "<<", n_opts)

-- reload file from disk
set("n", "<leader>r", "<cmd>e!<cr>", n_opts)

-- remove buffer completely from memory
set("n", "<space>w", "<cmd>bw!<cr>", n_opts)

-- zz -> zm
set("n", "zm", "zz", n_opts)

-- scrolling with arrow keys
set("n", "<left>", "zh", n_opts)
set("n", "<right>", "zl", n_opts)
set("n", "<up>", "<c-y>", n_opts)
set("n", "<down>", "<c-e>", n_opts)

-- splits
set("n", "gs", "<cmd>vs<cr>", n_opts)
set("n", "gh", "<cmd>sp<cr>", n_opts)

-- ???
set("n", "gi", "`^zzi", n_opts)

-- resizing splits
set("n", "<C-A-J>", "<cmd>resize -2<cr>", n_opts)
set("n", "<C-A-K>", "<cmd>resize +2<cr>", n_opts)
set("n", "<C-A-H>", "<cmd>vertical resize -2<cr>", n_opts)
set("n", "<C-A-L>", "<cmd>vertical resize +2<cr>", n_opts)

-- moving between loaded buffers like with C-o, C-i
set("n", "<C-A-i>", "<cmd>bnext<cr>", n_opts)
set("n", "<C-A-o>", "<cmd>bprev<cr>", n_opts)

-- saving and quitting
set("n", "<leader>w", "<cmd>w!<cr>", n_opts)
set("n", "<leader>W", "<cmd>wq!<cr>", n_opts)
set("n", "<leader>q", "<cmd>q<cr>", n_opts)
set("n", "<C-q>", "<cmd>q<cr>", n_opts)
set("n", "<A-q>", "<cmd>q!<cr>", n_opts)
set("n", "<A-q>", "<cmd>q!<cr>", n_opts)
set("n", "<leader>C", "<cmd>quitall!<cr>", n_opts)

local paste_and_indent = function()
    vim.cmd('normal! "+p')
    vim.cmd("normal! '[V']")
    vim.cmd("normal! =")
end

set("n", "<leader>V", paste_and_indent, n_opts)

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
set("n", "<leader>tn", "<cmd>tab split<cr>", n_opts)

-- quickfix navigation
set("n", "<M-,>", function()
    local ok, _ = pcall(vim.api.nvim_command, "cprev")
    if ok then
        vim.api.nvim_command("norm zz")
    else
        ok, _ = pcall(vim.api.nvim_command, "clast")
        if ok then
            vim.api.nvim_command("norm zz")
        end
    end
end, n_opts)
set("n", "<M-.>", function()
    local ok, _ = pcall(vim.api.nvim_command, "cnext")
    if ok then
        vim.api.nvim_command("norm zz")
    else
        ok, _ = pcall(vim.api.nvim_command, "cfirst")
        if ok then
            vim.api.nvim_command("norm zz")
        end
    end
end, n_opts)
set("n", "<M-;>", "<cmd>cpfile<cr>", n_opts)
set("n", "<M-'>", "<cmd>cnfile<cr>", n_opts)

-- concat lines in visual mode, because I have J remapped to moving blocks
set("v", "<S-m>", "J", n_opts)
set("v", "<S-j>", "<cmd>m '>+1<cr>gv=gv", n_opts)
set("v", "<S-k>", "<cmd>m '<-2<cr>gv=gv", n_opts)
set("v", "\\", "<Esc>/\\%V", { desc = "Search within visual selection " })

-- terminal

-- tab indeed do tab
set("t", "<tab>", "<tab>", n_opts)

-- fullscreen terminal in new tab
set("n", "<leader>to", "<cmd>tabnew | term<cr>", n_opts)

-- terminal in a split to the left
set("n", "<leader>th", function()
    local opt = vim.opt.splitright
    vim.opt.splitright = false
    vim.api.nvim_command("vs term://" .. vim.g.shell)
    vim.opt.splitright = opt
end, n_opts)

-- terminal in a split to the right
set("n", "<leader>tl", function()
    local opt = vim.opt.splitright
    vim.opt.splitright = true
    vim.api.nvim_command("vs term://" .. vim.g.shell)
    vim.opt.splitright = opt
end, n_opts)

-- toggle a horizontal terminal via my own command
set({ "n", "t" }, "<C-t>", "<cmd>TermToggle<cr>", n_opts)

-- close terminal window forcefully by default
set("t", "<C-q>", "<cmd>q!<cr>", n_opts)
-- make esc work
set("t", "<esc>", "<C-\\><C-n>", n_opts)
-- navigating through jumplist without doing <esc>
set("t", "<C-o>", "<C-\\><C-n><C-o>", n_opts)
set("t", "<C-i>", "<C-\\><C-n><C-i>", n_opts)

-- remove full line like dd
set("n", "<A-d>", "dd", n_opts)

-- search and replace visual selection
set("v", "//", [["hy:%s/<C-r>h//gc<left><left><left>]], { noremap = true })

-- navigating through splits and tmux panes without any hassle
set("n", "<c-h>", "<cmd>TmuxNavigateLeft<cr>", n_opts)
set("n", "<c-j>", "<cmd>TmuxNavigateDown<cr>", n_opts)
set("n", "<c-k>", "<cmd>TmuxNavigateUp<cr>", n_opts)
set("n", "<c-l>", "<cmd>TmuxNavigateRight<cr>", n_opts)

-- set("i", "<c-h>", "<esc><cmd>TmuxNavigateLeft<cr>", n_opts)
-- set("i", "<c-j>", "<esc><cmd>TmuxNavigateDown<cr>", n_opts)
-- set("i", "<c-k>", "<esc><cmd>TmuxNavigateUp<cr>", n_opts)
-- set("i", "<c-l>", "<esc><cmd>TmuxNavigateRight<cr>", n_opts)

-- set : to q: (instead of cmdline have cmdwin)
set("n", ":", "q:i", n_opts)

-- quickly duplicate line I'm on and don't change the horizontal cursor position
set("n", "<leader>vd", function()
    local win = vim.api.nvim_get_current_win()
    local cursorpos = vim.api.nvim_win_get_cursor(win)
    vim.api.nvim_command("norm yyp")
    cursorpos[1] = cursorpos[1] + 1
    vim.api.nvim_win_set_cursor(win, cursorpos)
end, n_opts)

-- goto file in existing split on the left
-- or the right, if non are open then create them
-- local gf_to_the = require("user.custom-gf").gf_to_the
-- set("n", "gfh", function()
--     gf_to_the({ left = true })
-- end)
-- set("n", "<C-S-H>", function()
--     gf_to_the({ left = true })
-- end)
--
-- set("n", "gfl", function()
--     gf_to_the({ left = false })
-- end)
-- set("n", "<C-S-L>", function()
--     gf_to_the({ left = false })
-- end)

-- repeat last macro with a single key instead of toggling case
set("n", "~", "@@", n_opts)

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
end, n_opts)

-- keep the cursor in the middle of the screen
set("n", "'", function()
    return "'" .. vim.fn.nr2char(vim.fn.getchar()) .. "zz"
end, { expr = true })

set("n", "`", function()
    return "`" .. vim.fn.nr2char(vim.fn.getchar()) .. "zz"
end, { expr = true })
set("n", "<C-d>", "<C-d>zz", n_opts)
set("n", "<C-u>", "<C-u>zz", n_opts)
set("n", "<C-f>", "<C-f>zz", n_opts)
set("n", "<C-b>", "<C-b>zz", n_opts)
set("n", "n", "nzz", n_opts)
set("n", "N", "Nzz", n_opts)
set("n", "*", "*zz", n_opts)
set("n", "#", "#zz", n_opts)
set("n", "g*", "g*zz", n_opts)
set("n", "g#", "g#zz", n_opts)
set("n", "<C-i>", "<C-i>zz", n_opts)
set("n", "<C-o>", "<C-o>zz", n_opts)
set("n", "g;", "g;zz", n_opts)
set("n", "g,", "g,zz", n_opts)

-- toggle line wrapping in all open windows
set("n", "<leader>gw", "<cmd>windo set wrap!<CR>", n_opts)

-- we goin places in insert mode guys
set("i", "<C-h>", "<C-o>b", n_opts)
set("i", "<C-j>", "<C-o>j", n_opts)
set("i", "<C-k>", "<C-o>k", n_opts)
set("i", "<C-l>", "<C-o>w", n_opts)

local function toggle_word_highlight()
    local word = vim.fn.expand("<cword>")
    if word == "" then
        return
    end

    -- Check if the word is already highlihted
    local search_reg = vim.fn.getreg("/")
    if search_reg == "\\<" .. word .. "\\>" then
        -- Clear highlight
        vim.cmd("nohlsearch")
        vim.fn.setreg("/", "")
    else
        -- Highlight the word
        vim.fn.setreg("/", "\\<" .. word .. "\\>")
        vim.cmd("set hlsearch")
    end
end

set("n", "&", toggle_word_highlight, {
    desc = "Toggle highlight word under cursor",
    noremap = true,
    silent = true,
})
