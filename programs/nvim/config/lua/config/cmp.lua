local vim = vim
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
    return
end

local check_backspace = function()
    local col = vim.fn.col(".") - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

--   פּ ﯟ   some other good icons
local kind_icons = {
    Text = "",
    Method = "󰆧",
    Function = "󰊕",
    Constructor = "",
    Field = "󰇽",
    Variable = "󰂡",
    Class = "󰠱",
    Interface = "",
    Module = "",
    Property = "󰜢",
    Unit = "",
    Value = "󰎠",
    Enum = "",
    Keyword = "󰌋",
    Snippet = "",
    Color = "󰏘",
    File = "󰈙",
    Reference = "",
    Folder = "󰉋",
    EnumMember = "",
    Constant = "󰏿",
    Struct = "",
    Event = "",
    Operator = "󰆕",
    TypeParameter = "󰅲",
}

cmp.setup({
    window = {
        completion = {
            border = "rounded",
            side_padding = 0,
            scrollbar = false,
            winblend = 0,
            winhighlight = "Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None",
        },
        documentation = {
            border = "rounded",
            winblend = 0,
            winhighlight = "Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None",
        },
    },
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    completion = {
        copleteopt = "menu,menuone,noinsert,noselect",
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-b>"] = cmp.mapping.scroll_docs(-1),
        ["<C-f>"] = cmp.mapping.scroll_docs(1),
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),
        ["<C-e>"] = cmp.mapping.close(),
        ["<C-Space>"] = cmp.mapping.complete(),
    }),

    -- sorting = {
    --     comparators = {
    --         cmp.config.compare.score,
    --         cmp.config.compare.order,
    --     },
    --     priority_weight = 10,
    -- },
    -- sources = {
    --     { name = "luasnip", priority = 1000 },
    --     { name = "copilot", priority = 800 },
    --     { name = "nvim_lua", priority = 500 },
    --     { name = "nvim_lsp", priority = 250 },
    --     { name = "cmdline", priority = 150 },
    --     { name = "path", priority = 100 },
    --     { name = "buffer", priority = 50 },
    -- },
    sources = {
        { name = "luasnip" },
        -- { name = "copilot" },
        -- { name = "nvim_lua" },
        -- { name = "nvim_lsp" },
        -- { name = "cmdline" },
        {
            name = "buffer",
            option = {
                get_bufnrs = function()
                    -- local bufs = {}
                    -- local buf_curr = vim.api.nvim_get_current_buf()
                    -- local buf_alt = vim.fn.bufnr("#")
                    -- for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                    --     if
                    --         vim.bo[buf].buftype ~= "terminal"
                    --         and not string.gmatch(vim.api.nvim_buf_get_name(buf) or "", "*.json")
                    --     then
                    --         bufs[buf] = true
                    --     end
                    --     if buf == buf_curr then
                    --         bufs[buf] = true
                    --     end
                    -- end
                    -- return vim.tbl_keys(bufs)
                    return vim.api.nvim_list_bufs()
                end,
            },
        },
        { name = "path" },
    },
    formatting = {
        fields = { "menu", "abbr", "kind" },
        format = function(entry, vim_item)
            -- Kind icons
            vim_item.kind = string.format("  %s ", kind_icons[vim_item.kind])
            return vim_item
        end,
    },
})

cmp.setup.cmdline("/", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "buffer" },
    },
})

cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = "path" },
    }, {
        {
            name = "cmdline",
            option = {
                ignore_cmds = { "Man", "!" },
            },
        },
    }),
})

cmp.setup.cmdline("@", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = "cmdline" },
    }),
})
