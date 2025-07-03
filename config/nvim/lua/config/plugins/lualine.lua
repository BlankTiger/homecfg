local function hide()
    require("lualine").hide()
    vim.opt.laststatus = 0
    vim.opt.stl = "%{repeat('─',winwidth('.'))}"
end

local function show()
    require("lualine").hide({ unhide = true })
end

local function toggle_lualine()
    if vim.g.lualine_shown then
        hide()
    else
        show()
    end
    vim.g.lualine_shown = not vim.g.lualine_shown
end

local function toggle_full_filename()
    vim.g.lualine_full_filename = not vim.g.lualine_full_filename
end

return {
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        config = function()
            local lualine = require("lualine")

            local hide_in_width = function()
                return vim.fn.winwidth(0) > 80
            end

            local diagnostics = {
                "diagnostics",
                sources = { "nvim_diagnostic" },
                sections = { "error", "warn" },
                symbols = { error = "E: ", warn = "W: " },
                -- symbols = { error = " ", warn = " " },
                colored = true,
                update_in_insert = false,
                always_visible = true,
            }

            local diff = {
                "diff",
                colored = true,
                symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
                cond = hide_in_width,
            }

            local mode = {
                "mode",
                fmt = function(mode)
                    return "--- " .. mode .. " ---"
                end,
            }

            local function filename()
                local result = ""
                if vim.g.lualine_full_filename then
                    result = vim.fn.expand("%")
                else
                    result = vim.fn.expand("%:t")
                end
                return result
            end

            local filetype_no_icon = {
                "filetype",
                icons_enabled = false,
            }

            local filetype = {
                "filetype",
                colored = true,
                icon_only = true,
            }

            local branch = {
                "branch",
                icons_enabled = true,
                icon = "",
            }

            local location = {
                "location",
                padding = 0,
            }

            local searchcount = {
                "searchcount",
                maxcount = 2000000,
            }

            local spaces = function()
                return "spaces: " .. vim.bo[0].shiftwidth
            end

            local function is_recording()
                local reg = vim.fn.reg_recording()
                if reg == "" then
                    return ""
                end -- not recording
                return "@" .. reg
            end

            local colors = { bg = vim.g.background_color, fg = "#ffffff" }
            local custom = {
                normal = {
                    a = colors,
                    b = colors,
                    c = colors,
                },
                insert = {
                    a = colors,
                    b = colors,
                    c = colors,
                },
                visual = {
                    a = colors,
                    b = colors,
                    c = colors,
                },
                replace = {
                    a = colors,
                    b = colors,
                    c = colors,
                },
                command = {
                    a = colors,
                    b = colors,
                    c = colors,
                },
                inactive = {
                    a = colors,
                    b = colors,
                    c = colors,
                },
            }

            lualine.setup({
                options = {
                    icons_enabled = true,
                    theme = custom,
                    -- theme = "tokyonight",
                    component_separators = { left = "", right = "" },
                    section_separators = { left = "", right = "" },
                    disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
                    always_divide_middle = true,
                    globalstatus = true,
                },
                sections = {
                    lualine_a = { mode, is_recording },
                    lualine_b = { branch },
                    lualine_c = {
                        "%=",
                        -- filetype,
                        filename,
                        diff,
                    },
                    lualine_x = {
                        diagnostics,
                        searchcount,
                        "selectioncount",
                        -- spaces,
                        "encoding",
                        -- filetype_no_icon,
                    },
                    lualine_y = { "progress" },
                    lualine_z = { "location" },
                },
                tabline = {},
                extensions = {},
            })

            if not vim.g.lualine_shown then
                hide()
            end

            local set = vim.keymap.set
            set("n", "<leader>lt", toggle_lualine)
            set("n", "<leader>lT", toggle_full_filename)
        end,
    },
}
