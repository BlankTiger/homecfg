local source_priority = {
    snippets = 5,
    lsp = 4,
    path = 3,
    buffer = 3,
    omni = 2,
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

        -- build = "cargo build --release",

        config = function()
            ---@module 'blink.cmp'
            ---@type blink.cmp.Config
            local opts = {
                fuzzy = { implementation = "rust" },
                snippets = { preset = "luasnip" },

                keymap = {
                    preset = "default",
                    ["<C-y>"] = { "accept" },
                    ["<Tab>"] = {},

                    ["<M-1>"] = {
                        function(cmp)
                            cmp.accept({ index = 1 })
                        end,
                    },
                    ["<M-2>"] = {
                        function(cmp)
                            cmp.accept({ index = 2 })
                        end,
                    },
                    ["<M-3>"] = {
                        function(cmp)
                            cmp.accept({ index = 3 })
                        end,
                    },
                    ["<M-4>"] = {
                        function(cmp)
                            cmp.accept({ index = 4 })
                        end,
                    },
                    ["<M-5>"] = {
                        function(cmp)
                            cmp.accept({ index = 5 })
                        end,
                    },
                    ["<M-6>"] = {
                        function(cmp)
                            cmp.accept({ index = 6 })
                        end,
                    },
                    ["<M-7>"] = {
                        function(cmp)
                            cmp.accept({ index = 7 })
                        end,
                    },
                    ["<M-8>"] = {
                        function(cmp)
                            cmp.accept({ index = 8 })
                        end,
                    },
                    ["<M-9>"] = {
                        function(cmp)
                            cmp.accept({ index = 9 })
                        end,
                    },
                    ["<M-0>"] = {
                        function(cmp)
                            cmp.accept({ index = 10 })
                        end,
                    },
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
                            opts = {
                                get_bufnrs = vim.api.nvim_list_bufs,
                                max_async_buffer_size = 50000000,
                                max_total_buffer_size = 90000000,
                            },
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
                    -- keyword = {
                    --     range = "full",
                    -- },
                    list = {
                        selection = {
                            auto_insert = false,
                        },
                    },
                    menu = {
                        auto_show = true,
                        border = "single",
                        scrollbar = false,
                        winblend = 0,
                        scrolloff = 2,
                        max_height = 12,
                        winhighlight = "Normal:Pmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None",
                        draw = {
                            gap = 2,
                            columns = {
                                { "label", "label_description", gap = 1 },
                                { "kind_icon", "space", "space", "item_idx" },
                            },
                            components = {
                                space = {
                                    ellipsis = false,
                                    text = function()
                                        return " "
                                    end,
                                },
                                item_idx = {
                                    text = function(ctx)
                                        return ctx.idx == 10 and "0"
                                            or ctx.idx >= 10 and " "
                                            or tostring(ctx.idx)
                                    end,
                                    highlight = "BlinkCmpItemIdx", -- optional, only if you want to change its color
                                },
                            },
                        },
                    },
                },
            }

            local original = require("blink.cmp.completion.list").show
            ---@diagnostic disable-next-line: duplicate-set-field
            require("blink.cmp.completion.list").show = function(ctx, items_by_source)
                local seen = {}
                local function filter(item)
                    if seen[item.label] then
                        return false
                    end
                    seen[item.label] = true
                    return true
                end
                for id in vim.iter(sources) do
                    items_by_source[id] = items_by_source[id]
                        and vim.iter(items_by_source[id]):filter(filter):totable()
                end
                return original(ctx, items_by_source)
            end

            local blink = require("blink.cmp")
            blink.setup(opts)

            local set = vim.keymap.set
            set("n", "<leader>lc", function()
                vim.g.lsp_completions_enabled = not vim.g.lsp_completions_enabled
            end, { desc = "Toggle LSP completions" })

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
