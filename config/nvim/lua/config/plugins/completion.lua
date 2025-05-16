local source_priority = {
    snippets = 5,
    lsp = 4,
    path = 3,
    -- omni = 2,
    buffer = 1,
}

local sources = vim.tbl_keys(source_priority)

return {
    -- {
    --     "supermaven-inc/supermaven-nvim",
    --     dev = true,
    --     event = "VeryLazy",
    --     config = function()
    --         require("supermaven-nvim").setup({
    --             current_line_only = true,
    --         })
    --     end,
    -- },

    {
        "Saghen/blink.cmp",
        dev = false,
        event = "VeryLazy",
        dependencies = {
            {
                "L3MON4D3/LuaSnip",
                config = function()
                    require("user.snippets")
                end,
                build = "make install_jsregexp",
            },
        },
        -- version = "v0.12.4",
        version = "*",

        config = function()
            ---@module 'blink.cmp'
            ---@type blink.cmp.Config
            local opts = {
                fuzzy = {
                    sorts = {
                        function(a, b)
                            local a_priority = source_priority[a.source_id]
                            local b_priority = source_priority[b.source_id]
                            if a_priority ~= b_priority then
                                return a_priority > b_priority
                            end
                        end,
                        -- defaults
                        "score",
                        "sort_text",
                    },
                },

                snippets = { preset = "luasnip" },

                keymap = {
                    preset = "default",
                    ["<C-y>"] = { "accept" },
                    ["<Tab>"] = {},
                },

                appearance = {
                    nerd_font_variant = "mono",
                },

                sources = {
                    default = sources,
                    providers = {
                        lsp = {
                            enabled = function()
                                return vim.g.lsp_completions_enabled
                            end,
                            fallbacks = {},
                            timeout_ms = 20000,
                        },
                        path = {
                            fallbacks = {},
                            timeout_ms = 20000,
                        },
                        snippets = {
                            fallbacks = {},
                            timeout_ms = 20000,
                        },
                        omni = {
                            fallbacks = {},
                            timeout_ms = 20000,
                        },
                        buffer = {
                            -- opts = {
                            --     get_bufnrs = function()
                            --         -- use all buffers, even hidden ones
                            --         -- HACK: blink.cmp by default cuts of buffer completions
                            --         -- if buftext of all open buffers exceeds certain thresholds
                            --         -- to get around that I edited the source code
                            --         --
                            --         -- there are some smart ways to solve this, some ideas:
                            --         -- - if length is too long, include just current and alternate file
                            --         -- - maintain a list of recently visited buffers and take N previous buffers
                            --         --   until they don't fit anymore into the buftext
                            --         -- - include only files of the same filetype as the current file
                            --         -- - dont include certain filetypes
                            --         -- - think of some way to optimize providing buftext for buffer completions
                            --         --   currently blink.cmp loops over all files, appends their text to a list
                            --         --   and then does table.concat on the resulting table, see if concating str
                            --         --   could be faster without first collecting into a list, maybe nvim has a
                            --         --   better/faster way of providing buftext for completions?
                            --         -- - look into the algorithm for buffer completions in rust, maybe it could
                            --         --   be parallelized further
                            --         -- - give user more documentation on filtering out long buffers in get_bufnrs
                            --         --   function
                            --         return vim.api.nvim_list_bufs()
                            --     end,
                            -- },
                            timeout_ms = 20000,
                        },
                    },
                },
                signature = {
                    enabled = true,
                    window = {
                        border = "rounded",
                        scrollbar = false,
                        winblend = 0,
                        winhighlight = "Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None",
                    },
                },
                completion = {
                    list = {
                        selection = {
                            auto_insert = false,
                        },
                    },
                    menu = {
                        auto_show = false,
                        border = "rounded",
                        scrollbar = false,
                        winblend = 0,
                        scrolloff = 2,
                        winhighlight = "Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None",
                        draw = {
                            gap = 2,
                            columns = {
                                { "label", "label_description", gap = 1 },
                                { "kind_icon", "space" },
                            },
                            components = {
                                space = {
                                    ellipsis = false,
                                    text = function()
                                        return " "
                                    end,
                                },
                            },
                        },
                    },
                },
            }

            local blink = require("blink.cmp")
            blink.setup(opts)

            local set = vim.keymap.set
            set("n", "<leader>lc", function()
                vim.g.lsp_completions_enabled = not vim.g.lsp_completions_enabled
            end)

            local function extend_keymap(mode, key, action_before)
                local function extended_action()
                    action_before()
                    local key_code = vim.api.nvim_replace_termcodes(key, true, false, true)
                    vim.api.nvim_feedkeys(key_code, "n", false)
                end

                set(mode, key, extended_action, { noremap = true })
            end

            extend_keymap("i", "<C-x>", blink.hide)
        end,
    },
}
