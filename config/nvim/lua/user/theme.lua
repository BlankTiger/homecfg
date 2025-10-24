local set_hl = vim.api.nvim_set_hl

local function set_custom_colors()
    vim.g.accent_color = "#17d87e"
    vim.g.comment_color = "#88fce3"
    vim.g.bg_color = "#000000"
    vim.g.divider_color = "#15161e"
    vim.g.white_color = "#ffffff"

    set_hl(0, "Normal", { bg = "none" })
    set_hl(0, "Comment", { fg = vim.g.comment_color })
    set_hl(0, "NormalFloat", { bg = "none" })
    set_hl(0, "TabLine", { bg = vim.g.bg_color })
    set_hl(0, "TabLineFill", { bg = vim.g.bg_color })
    set_hl(0, "TabLineSel", { fg = vim.g.accent_color })

    set_hl(0, "PmenuSel", { fg = vim.g.accent_color })
    set_hl(0, "Pmenu", { bg = vim.g.bg_color })
    set_hl(0, "PmenuSbar", {})

    set_hl(0, "FloatBorder", { bg = vim.g.bg_color, fg = vim.g.accent_color })
    set_hl(0, "FloatTitle", { bg = vim.g.bg_color, fg = vim.g.white_color })

    set_hl(0, "StatusLineNC", { bg = vim.g.bg_color, fg = vim.g.divider_color, ctermbg = 0 })
    set_hl(0, "StatusLine", { bg = vim.g.bg_color, fg = vim.g.divider_color, ctermbg = 0 })

    set_hl(0, "SignColumn", { bg = vim.g.bg_color, fg = vim.g.white_color, ctermbg = 0 })
    set_hl(0, "LineNr", { bg = vim.g.bg_color, fg = vim.g.white_color })
    set_hl(0, "WinSeparator", { bg = vim.g.bg_color, fg = vim.g.accent_color })
    set_hl(0, "MatchParen", { fg = vim.g.comment_color })
end

local custom_paragon = function()
    vim.cmd.colorscheme("paragon")
    set_custom_colors()

    set_hl(0, "Keyword", { fg = "#ffaf00" })
    set_hl(0, "Visual", { bg = "#333333", fg = "#ffffff" })

    set_hl(0, "DiffAdd", { bg = "none", fg = "#5fd7af" })
    set_hl(0, "DiffText", { bg = "none", fg = "#d7d787" })
    set_hl(0, "DiffDelete", { ctermbg = "none", ctermfg = "none", bg = "none", fg = "#d78787" })
    set_hl(0, "DiffChange", { ctermbg = "none", bg = "none", fg = "none" })

    set_hl(0, "NeogitDiffAdd", { bg = "#1a1a1a", fg = "#5fd7af" })
    set_hl(0, "NeogitDiffAddHighlight", { bg = "#1a1a1a", fg = "#5fd7af" })
    set_hl(0, "NeogitDiffAddCursor", { bg = "#0f0f0f", fg = "#5fd7af" })
    set_hl(
        0,
        "NeogitDiffDelete",
        { ctermfg = "none", ctermbg = "none", fg = "#d78787", bg = "#1a1a1a" }
    )
    set_hl(0, "NeogitDiffDeleteHighlight", { fg = "#d78787", bg = "#1a1a1a" })
    set_hl(0, "NeogitDiffDeleteCursor", { bg = "#0f0f0f", fg = "#d78787" })
    set_hl(0, "GitConflictIncoming", { link = "DiffAdd" })
    set_hl(0, "GitConflictIncomingLabel", { link = "DiffAdd" })
    set_hl(0, "GitConflictCurrent", { link = "DiffText" })
    set_hl(0, "GitConflictCurrentLabel", { link = "DiffText" })

end

local function custom_whatever()
    vim.cmd.colorscheme("ayu-dark")
    set_custom_colors()
end

return function()
    vim.opt.termguicolors = true
    -- custom_paragon()
    _ = custom_paragon
    -- _ = custom_whatever
    custom_whatever()
    -- vim.cmd.colorscheme("catppuccin-latte")
end
