local custom_paragon = function()
    vim.cmd.colorscheme("paragon")
    -- highlight Keyword guifg=#ffdd33
    -- highlight Keyword guifg=#ffaf00
    vim.cmd([[
        highlight DiffAdd guibg=NONE guifg=#5fd7af
        highlight DiffText guibg=NONE guifg=#d7d787
        highlight DiffDelete ctermfg=NONE ctermbg=NONE guifg=#d78787 guibg=NONE
        highlight DiffChange ctermbg=NONE guifg=NONE guibg=NONE
        highlight Visual guibg=#333333 guifg=#ffffff
        highlight Keyword guifg=#ffaf00

        highlight NeogitDiffAdd guibg=#1a1a1a guifg=#5fd7af
        highlight NeogitDiffAddHighlight guibg=#1a1a1a guifg=#5fd7af
        highlight NeogitDiffAddCursor guibg=#0f0f0f guifg=#5fd7af
        highlight NeogitDiffDelete ctermfg=NONE ctermbg=NONE guifg=#d78787 guibg=#1a1a1a
        highlight NeogitDiffDeleteHighlight guifg=#d78787 guibg=#1a1a1a
        highlight NeogitDiffDeleteCursor guibg=#0f0f0f guifg=#d78787
        highlight! link GitConflictIncoming DiffAdd
        highlight! link GitConflictIncomingLabel DiffAdd
        highlight! link GitConflictCurrent DiffText
        highlight! link GitConflictCurrentLabel DiffText
    ]])

    vim.cmd([[hi Comment guifg=#7FFFD4]])
end

local black = "#000000"

local function custom_tokyonight()
    vim.cmd.colorscheme("tokyonight-night")

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "TabLine", { bg = black })
    vim.api.nvim_set_hl(0, "TabLineFill", { bg = black })
    vim.api.nvim_set_hl(0, "TabLineSel", { fg = vim.g.accent_color })

    vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#000000", fg = vim.g.accent_color })
    vim.api.nvim_set_hl(0, "FloatTitle", { bg = "#000000", fg = "#ffffff" })

    vim.api.nvim_set_hl(
        0,
        "StatusLineNC",
        { bg = vim.g.bg_color, fg = vim.g.divider_color, ctermbg = 0 }
    )
    vim.api.nvim_set_hl(
        0,
        "StatusLine",
        { bg = vim.g.bg_color, fg = vim.g.divider_color, ctermbg = 0 }
    )
end

return function()
    vim.opt.termguicolors = true
    -- custom_paragon()
    _ = custom_paragon
    custom_tokyonight()
end
