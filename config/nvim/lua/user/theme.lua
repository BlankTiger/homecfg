local set_hl = vim.api.nvim_set_hl

vim.g.accent_color = vim.g.theme == "naysayer" and "#A6E22E" or "#17d87e"

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

    set_hl(0, "qfFileName", { link = "Normal" })
    set_hl(0, "qfLineNr", { link = "Normal" })
    set_hl(0, "qfError", { fg = "#ff4444" })
    set_hl(0, "QuickFixLine", { fg = vim.g.accent_color })
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

local function set_naysayer_telescope_colors()
    local links = {
        TelescopeNormal = "Normal",
        TelescopeBorder = "LineNr",
        TelescopePromptNormal = "TelescopeNormal",
        TelescopePromptBorder = "TelescopeBorder",
        TelescopePromptTitle = "Comment",
        TelescopePromptPrefix = "TelescopeMatching",
        TelescopeResultsNormal = "TelescopeNormal",
        TelescopeResultsBorder = "TelescopeBorder",
        TelescopeResultsTitle = "Comment",
        TelescopePreviewNormal = "TelescopeNormal",
        TelescopePreviewBorder = "TelescopeBorder",
        TelescopePreviewTitle = "Comment",
        TelescopeSelection = "Visual",
        TelescopeSelectionCaret = "Visual",
        TelescopeMultiSelection = "Visual",
        TelescopeMatching = "String",
        TelescopePreviewMatch = "TelescopeMatching",
    }

    for group, link in pairs(links) do
        set_hl(0, group, { link = link })
    end

    set_hl(0, "TelescopeNormal", { fg = "#d0b892", bg = "#092a25" })
    set_hl(0, "TelescopeBorder", { fg = "#126367", bg = "#092a25" })

    for _, group in ipairs(vim.fn.getcompletion("DevIcon", "highlight")) do
        set_hl(0, group, { link = "Comment" })
    end
end

local function set_naysayer_neogit_colors()
    local links = {
        NeogitGraphAuthor = "Comment",
        NeogitGraphRed = "Error",
        NeogitGraphWhite = "Normal",
        NeogitGraphYellow = "Number",
        NeogitGraphGreen = "String",
        NeogitGraphCyan = "Type",
        NeogitGraphBlue = "Function",
        NeogitGraphPurple = "Constant",
        NeogitGraphGray = "Comment",
        NeogitGraphOrange = "Special",
        NeogitSubtleText = "Comment",
        NeogitCursorLine = "CursorLine",
        NeogitDiffContext = "Normal",
        NeogitDiffContextHighlight = "Normal",
        NeogitDiffAdditions = "String",
        NeogitDiffAdd = "String",
        NeogitDiffAddHighlight = "String",
        NeogitDiffAddCursor = "String",
        NeogitDiffDeletions = "Error",
        NeogitDiffDelete = "Error",
        NeogitDiffDeleteHighlight = "Error",
        NeogitDiffDeleteCursor = "Error",
        NeogitHunkMergeHeader = "Comment",
        NeogitHunkMergeHeaderHighlight = "Comment",
        NeogitHunkMergeHeaderCursor = "Comment",
        NeogitHunkHeader = "Comment",
        NeogitHunkHeaderHighlight = "Comment",
        NeogitHunkHeaderCursor = "Comment",
        NeogitPopupSectionTitle = "Function",
        NeogitPopupBranchName = "String",
        NeogitPopupSwitchKey = "Constant",
        NeogitPopupOptionKey = "Constant",
        NeogitPopupConfigKey = "Constant",
        NeogitPopupActionKey = "Constant",
        NeogitFilePath = "Type",
        NeogitBranch = "Function",
        NeogitBranchHead = "Function",
        NeogitRemote = "String",
        NeogitWinSeparator = "LineNr",
    }

    for group, link in pairs(links) do
        set_hl(0, group, { link = link })
    end

    for _, group in ipairs({
        "NeogitHunkHeader",
        "NeogitHunkHeaderHighlight",
        "NeogitHunkHeaderCursor",
    }) do
        set_hl(0, group, { fg = "#A6E22E", bg = "#126367", bold = true })
    end

    for _, group in ipairs({
        "NeogitDiffContext",
        "NeogitDiffContextHighlight",
        "NeogitDiffContextCursor",
    }) do
        set_hl(0, group, { fg = "#d0b892", bg = "#0d3d36" })
    end

    for _, group in ipairs({
        "NeogitDiffAdd",
        "NeogitDiffAddHighlight",
        "NeogitDiffAddCursor",
    }) do
        set_hl(0, group, { fg = "#a6ffb1", bg = "#2c5227" })
    end

    for _, group in ipairs({
        "NeogitDiffDelete",
        "NeogitDiffDeleteHighlight",
        "NeogitDiffDeleteCursor",
    }) do
        set_hl(0, group, { fg = "#e56a9f", bg = "#3e2936" })
    end
end

local function set_naysayer_completion_colors()
    local highlights = {
        Pmenu = { fg = "#d0b892", bg = "#092a25" },
        PmenuSel = { fg = "#A6E22E", bg = "#0b3335", bold = true },
        PmenuSbar = { bg = "#0b3335" },
        PmenuThumb = { bg = "#126367" },
        CmpPmenuBorder = { fg = "#126367", bg = "#092a25" },
        BlinkCmpItemIdx = { fg = "#126367" },
        BlinkCmpLabel = { fg = "#d0b892" },
        BlinkCmpLabelMatch = { fg = "#3ad0b5" },
        BlinkCmpLabelDetail = { fg = "#a6ffb1" },
        BlinkCmpLabelDescription = { fg = "#a6ffb1" },
        BlinkCmpSource = { fg = "#126367" },
        BlinkCmpKind = { fg = "#a6ffb1" },
        BlinkCmpDoc = { fg = "#d0b892", bg = "#092a25" },
        BlinkCmpDocBorder = { fg = "#126367", bg = "#092a25" },
        BlinkCmpSignatureHelp = { fg = "#d0b892", bg = "#092a25" },
        BlinkCmpSignatureHelpBorder = { fg = "#126367", bg = "#092a25" },
    }

    for group, options in pairs(highlights) do
        set_hl(0, group, options)
    end
end

local function set_naysayer_treesitter_colors()
    local links = {
        ["@type.builtin"] = "Type",
        ["@constructor"] = "Type",
        ["@function.call"] = "Function",
        ["@function.method"] = "Function",
        ["@method"] = "Function",
        ["@method.call"] = "Function",
        ["@property"] = "Identifier",
        ["@variable.builtin"] = "Constant",
        ["@constant.builtin"] = "Constant",
        ["@keyword.return"] = "Keyword",
    }

    for group, link in pairs(links) do
        set_hl(0, group, { link = link })
    end
end

local function set_naysayer_harpoon_colors()
    local highlights = {
        HarpoonWindow = { fg = "#d0b892", bg = "#092a25" },
        HarpoonBorder = { fg = "#126367", bg = "#092a25" },
        HarpoonCurrentFile = { fg = "#A6E22E", bg = "#092a25", bold = true },
        HarpoonActive = { fg = "#A6E22E", bg = "#092a25" },
        HarpoonInactive = { fg = "#6a8f8c", bg = "#092a25" },
        HarpoonNumberActive = { fg = "#A6E22E", bg = "#092a25", bold = true },
        HarpoonNumberInactive = { fg = "#6a8f8c", bg = "#092a25" },
    }

    for group, options in pairs(highlights) do
        set_hl(0, group, options)
    end
end

local function set_naysayer_fff_colors()
    set_hl(0, "FffNormal", { fg = "#d0b892", bg = "#092a25" })
    set_hl(0, "FffBorder", { fg = "#126367", bg = "#092a25" })
end

local function custom_whatever()
    if vim.g.theme == "naysayer" then
        vim.cmd.colorscheme("naysayer")
        set_hl(0, "Normal", { bg = "#092a25" })
        set_hl(0, "NormalFloat", { fg = "#d0b892", bg = "#092a25" })
        set_hl(0, "FloatBorder", { fg = "#126367", bg = "#092a25" })
        set_hl(0, "LspFloatWinNormal", { fg = "#d0b892", bg = "#092a25" })
        set_hl(0, "LspFloatWinBorder", { fg = "#126367", bg = "#092a25" })
        set_hl(0, "TabLine", { fg = "#6a8f8c", bg = "#092a25" })
        set_hl(0, "TabLineFill", { bg = "#092a25" })
        set_hl(0, "TabLineSel", { fg = "#A6E22E", bg = "#092a25", bold = true })
        set_hl(0, "LineNr", { fg = "#6a8f8c", bg = "#092a25" })
        set_hl(0, "CursorLineNr", { fg = "#A6E22E", bg = "#092a25", bold = true })
        set_hl(0, "SignColumn", { bg = "#092a25" })
        set_hl(0, "Type", { fg = "#a6ffb1" })
        set_hl(0, "Search", { fg = "#092a25", bg = "#6a8f8c" })
        set_hl(0, "CurSearch", { fg = "#092a25", bg = "#e56a9f", bold = true })
        set_hl(0, "IncSearch", { fg = "#092a25", bg = "#e56a9f", bold = true })
        set_hl(0, "QuickFixLine", { fg = "#A6E22E", bg = "#0b3335", bold = true })
        set_naysayer_telescope_colors()
        set_naysayer_neogit_colors()
        set_naysayer_completion_colors()
        set_naysayer_treesitter_colors()
        set_naysayer_harpoon_colors()
        set_naysayer_fff_colors()
        return
    end

    vim.cmd.colorscheme("ayu-dark")
    set_custom_colors()
end

vim.opt.termguicolors = true
-- custom_paragon()
_ = custom_paragon
-- _ = custom_whatever
custom_whatever()
