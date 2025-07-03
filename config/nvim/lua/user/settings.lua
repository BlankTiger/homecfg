-- load keymapping
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.netrw_banner = 0

local opt = vim.opt
local g = vim.g

g.tagbar_position = "topleft vertical"

vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

opt.splitright = true
opt.showmode = false
opt.clipboard = "unnamedplus"
opt.mouse = "a"

opt.autoindent = true
opt.smartindent = false
opt.indentexpr = ""

opt.pumblend = 0

opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.smarttab = true
opt.ignorecase = true
opt.smartcase = true
opt.cursorline = false
opt.number = false
opt.relativenumber = false
opt.signcolumn = "number"
opt.syntax = "on"
opt.encoding = "utf-8"
g.shell = "/usr/bin/fish"
opt.shell = g.shell
opt.scrolloff = 10
opt.inccommand = "split"
opt.undofile = true
opt.splitbelow = true
opt.cmdwinheight = 15
opt.matchpairs = "(:),{:},<:>,[:]"
opt.scrollback = 100000
opt.guicursor = "n-v-i-c:block-Cursor,a:blinkwait700-blinkoff400-blinkon250-Cursor"
opt.updatetime = 50
opt.wrap = false
opt.pumheight = 10
opt.fillchars = { eob = " " }
g.searchindex_line_limit = 1000000
g.do_filetype_lua = 1

g.mk = "echo 'update g:mk cmd'"
g.rg_command = "rg --vimgrep"
g.lsp_completions_enabled = false
g.lualine_shown = true
g.lualine_full_filename = false
g.disable_autoformat = true
g.lsp_diagnostics_hidden = true

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
g.zig_fmt_parse_errors = 0
g.zig_fmt_autosave = 1

vim.cmd([[
set errorformat+=%f:%l
set errorformat+=%f:%l:
set errorformat+=%f:%l:\ %m
set errorformat+=%f:%l\ %m
]])

if not g.lualine_shown then
    opt.laststatus = 0
    opt.stl = "%{repeat('─',winwidth('.'))}"
end

-- base normal mode options for all keymaps
g.n_opts = {
    silent = true,
    noremap = true,
    nowait = true,
}

local set_theme = require("user.theme")
set_theme()
