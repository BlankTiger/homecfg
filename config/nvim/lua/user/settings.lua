-- load keymapping
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.netrw_banner = 0

local opt = vim.opt
local g = vim.g

g.rg_command = "rg --vimgrep"

-- tagbar
g.tagbar_position = "topleft vertical"

-- User settings --
vim.o.guifont = "IosevkaTerm Nerd Font Mono:h14"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
opt.splitright = true
opt.showmode = false
opt.clipboard = "unnamedplus"
opt.mouse = "a"

opt.autoindent = true
opt.smartindent = false
-- vim.cmd("filetype indent off")
opt.indentexpr = ""

opt.pumblend = 0

opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.smarttab = true
opt.ignorecase = true
opt.smartcase = true
opt.cursorline = false
opt.number = true
opt.relativenumber = true
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
g.lsp_completions_enabled = false
g.searchindex_line_limit = 1000000
g.neovide_transparency = 1
g.do_filetype_lua = 1
g.oxcarbon_lua_keep_terminal = 1
g.vimtex_view_method = "zathura"
g.vimtex_quickfix_enabled = 0
g.vimtex_compiler_latexmk = {
    callback = 1,
    continuous = 1,
    executable = "latexmk",
    options = {
        "-pvc",
        "-synctex=1",
        "-interaction=nonstopmode",
        "-pdf",
    },
}
g.silicon = {
    theme = "TwoDark",
    font = "Hack",
    background = "#555555",
    ["shadow-color"] = "#333333",
    ["line-pad"] = 2,
    ["pad-horiz"] = 80,
    ["pad-vert"] = 100,
    ["shadow-blur-radius"] = 5,
    ["shadow-offset-x"] = 4,
    ["shadow-offset-y"] = 4,
    ["line-number"] = true,
    ["round-corner"] = true,
    ["window-controls"] = true,
}

g.jukit_inline_plotting = 0
g.jupytext_fmt = "py"
g.jupytext_style = "hydrogen"

g.zig_fmt_parse_errors = 0
g.zig_fmt_autosave = 1

g.lualine_shown = false

vim.cmd([[
set errorformat+=%f:%l
set errorformat+=%f:%l:
set errorformat+=%f:%l:\ %m
set errorformat+=%f:%l\ %m
]])

g.accent_color = "#17d87e"
g.bg_color = "#000000"
g.divider_color = "#15161e"
g.original_stl = vim.o.stl
if not g.lualine_shown then
    opt.laststatus = 0
    opt.stl = "%{repeat('─',winwidth('.'))}"
end

-- Set colorscheme
local set_theme = require("user.theme")
set_theme()
