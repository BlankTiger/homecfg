return {
    {
        "BlankTiger/blink.cmp",
        dev = true,
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
        version = "*",

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            snippets = {
                expand = function(snippet)
                    require("luasnip").lsp_expand(snippet)
                end,
                active = function(filter)
                    if filter and filter.direction then
                        return require("luasnip").jumpable(filter.direction)
                    end
                    return require("luasnip").in_snippet()
                end,
                jump = function(direction)
                    require("luasnip").jump(direction)
                end,
            },

            keymap = { preset = "default" },
            appearance = {
                -- use_nvim_cmp_as_default = true,
                nerd_font_variant = "mono",
            },
            sources = {
                default = {
                    "lsp",
                    "path",
                    "luasnip",
                    "snippets",
                    "buffer",
                },
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
                    luasnip = {
                        fallbacks = {},
                        timeout_ms = 20000,
                    },
                    buffer = {
                        opts = {
                            get_bufnrs = function()
                                -- use all buffers, even hidden ones
                                -- HACK: blink.cmp by default cuts of buffer completions
                                -- if buftext of all open buffers exceeds certain thresholds
                                -- to get around that I edited the source code
                                --
                                -- there are some smart ways to solve this, some ideas:
                                -- - if length is too long, include just current and alternate file
                                -- - maintain a list of recently visited buffers and take N previous buffers
                                --   until they don't fit anymore into the buftext
                                -- - include only files of the same filetype as the current file
                                -- - dont include certain filetypes
                                -- - think of some way to optimize providing buftext for buffer completions
                                --   currently blink.cmp loops over all files, appends their text to a list
                                --   and then does table.concat on the resulting table, see if concating str
                                --   could be faster without first collecting into a list, maybe nvim has a
                                --   better/faster way of providing buftext for completions?
                                -- - look into the algorithm for buffer completions in rust, maybe it could
                                --   be parallelized further
                                -- - give user more documentation on filtering out long buffers in get_bufnrs
                                --   function
                                return vim.api.nvim_list_bufs()
                            end,
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
                list = {
                    selection = "auto_insert",
                },
                menu = {
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
        },
        opts_extend = { "sources.default" },
    },

    -- {
    --     "hrsh7th/nvim-cmp",
    --     event = { "InsertEnter", "CmdlineEnter" },
    --     config = function()
    --         local vim = vim
    --         local cmp_status_ok, cmp = pcall(require, "cmp")
    --         if not cmp_status_ok then
    --             return
    --         end
    --
    --         local check_backspace = function()
    --             local col = vim.fn.col(".") - 1
    --             return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
    --         end
    --
    --         --   פּ ﯟ   some other good icons
    --         local kind_icons = {
    --             Text = "",
    --             Method = "󰆧",
    --             Function = "󰊕",
    --             Constructor = "",
    --             Field = "󰇽",
    --             Variable = "󰂡",
    --             Class = "󰠱",
    --             Interface = "",
    --             Module = "",
    --             Property = "󰜢",
    --             Unit = "",
    --             Value = "󰎠",
    --             Enum = "",
    --             Keyword = "󰌋",
    --             Snippet = "",
    --             Color = "󰏘",
    --             File = "󰈙",
    --             Reference = "",
    --             Folder = "󰉋",
    --             EnumMember = "",
    --             Constant = "󰏿",
    --             Struct = "",
    --             Event = "",
    --             Operator = "󰆕",
    --             TypeParameter = "󰅲",
    --         }
    --
    --         cmp.setup({
    --             window = {
    --                 completion = {
    --                     border = "rounded",
    --                     side_padding = 0,
    --                     scrollbar = false,
    --                     winblend = 0,
    --                     winhighlight = "Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None",
    --                 },
    --                 documentation = {
    --                     border = "rounded",
    --                     winblend = 0,
    --                     winhighlight = "Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None",
    --                 },
    --             },
    --             snippet = {
    --                 expand = function(args)
    --                     require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
    --                 end,
    --             },
    --             completion = {
    --                 copleteopt = "menu,menuone,noinsert,noselect",
    --             },
    --             mapping = cmp.mapping.preset.insert({
    --                 ["<C-p>"] = cmp.mapping.select_prev_item(),
    --                 ["<C-n>"] = cmp.mapping.select_next_item(),
    --                 ["<C-b>"] = cmp.mapping.scroll_docs(-1),
    --                 ["<C-f>"] = cmp.mapping.scroll_docs(1),
    --                 ["<C-y>"] = cmp.mapping.confirm({ select = true }),
    --                 ["<C-e>"] = cmp.mapping.close(),
    --                 ["<C-Space>"] = cmp.mapping.complete(),
    --             }),
    --
    --             -- sorting = {
    --             --     comparators = {
    --             --         cmp.config.compare.score,
    --             --         cmp.config.compare.order,
    --             --     },
    --             --     priority_weight = 10,
    --             -- },
    --             -- sources = {
    --             --     { name = "luasnip", priority = 1000 },
    --             --     { name = "copilot", priority = 800 },
    --             --     { name = "nvim_lua", priority = 500 },
    --             --     { name = "nvim_lsp", priority = 250 },
    --             --     { name = "cmdline", priority = 150 },
    --             --     { name = "path", priority = 100 },
    --             --     { name = "buffer", priority = 50 },
    --             -- },
    --             sources = {
    --                 { name = "luasnip" },
    --                 -- { name = "copilot" },
    --                 -- { name = "nvim_lua" },
    --                 -- { name = "nvim_lsp" },
    --                 -- { name = "cmdline" },
    --                 {
    --                     name = "buffer",
    --                     option = {
    --                         get_bufnrs = function()
    --                             -- local bufs = {}
    --                             -- local buf_curr = vim.api.nvim_get_current_buf()
    --                             -- local buf_alt = vim.fn.bufnr("#")
    --                             -- for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    --                             --     if
    --                             --         vim.bo[buf].buftype ~= "terminal"
    --                             --         and not string.gmatch(vim.api.nvim_buf_get_name(buf) or "", "*.json")
    --                             --     then
    --                             --         bufs[buf] = true
    --                             --     end
    --                             --     if buf == buf_curr then
    --                             --         bufs[buf] = true
    --                             --     end
    --                             -- end
    --                             -- return vim.tbl_keys(bufs)
    --                             return vim.api.nvim_list_bufs()
    --                         end,
    --                     },
    --                 },
    --                 { name = "path" },
    --             },
    --             formatting = {
    --                 fields = { "menu", "abbr", "kind" },
    --                 format = function(entry, vim_item)
    --                     -- Kind icons
    --                     vim_item.kind = string.format("  %s ", kind_icons[vim_item.kind])
    --                     return vim_item
    --                 end,
    --             },
    --         })
    --
    --         cmp.setup.cmdline("/", {
    --             mapping = cmp.mapping.preset.cmdline(),
    --             sources = {
    --                 { name = "buffer" },
    --             },
    --         })
    --
    --         cmp.setup.cmdline(":", {
    --             mapping = cmp.mapping.preset.cmdline(),
    --             sources = cmp.config.sources({
    --                 { name = "path" },
    --             }, {
    --                 {
    --                     name = "cmdline",
    --                     option = {
    --                         ignore_cmds = { "Man", "!" },
    --                     },
    --                 },
    --             }),
    --         })
    --
    --         cmp.setup.cmdline("@", {
    --             mapping = cmp.mapping.preset.cmdline(),
    --             sources = cmp.config.sources({
    --                 { name = "cmdline" },
    --             }),
    --         })
    --     end,
    --     dependencies = {
    --         {
    --             "L3MON4D3/LuaSnip",
    --             config = function()
    --                 require("user.snippets")
    --             end,
    --             build = "make install_jsregexp",
    --         },
    --         "hrsh7th/cmp-path",
    --         "hrsh7th/cmp-buffer",
    --         "hrsh7th/cmp-cmdline",
    --         "hrsh7th/cmp-nvim-lsp",
    --         "hrsh7th/cmp-nvim-lua",
    --         "saadparwaiz1/cmp_luasnip",
    --         -- {
    --         --     "zbirenbaum/copilot.lua",
    --         --     cmd = "Copilot",
    --         --     config = function()
    --         --         require("config.copilot")
    --         --     end,
    --         -- },
    --         -- {
    --         --     "zbirenbaum/copilot-cmp",
    --         --     config = function()
    --         --         require("copilot_cmp").setup()
    --         --     end,
    --         -- },
    --     },
    -- },
}
