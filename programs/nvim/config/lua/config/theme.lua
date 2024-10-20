local function custom_paragon()
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
end

return function()
    vim.opt.termguicolors = true
    custom_paragon()
    -- vim.cmd.colorscheme("moonfly")
end
