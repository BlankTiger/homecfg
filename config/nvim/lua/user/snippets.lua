local ls = require("luasnip")

local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node

ls.setup()

local set = vim.keymap.set

set({ "i" }, "<C-K>", function()
    ls.expand()
end, { silent = true })
set({ "i", "s" }, "<C-right>", function()
    ls.jump(1)
end, { silent = true })
set({ "i", "s" }, "<C-left>", function()
    ls.jump(-1)
end, { silent = true })

set({ "i", "s" }, "<C-E>", function()
    if ls.choice_active() then
        ls.change_choice(1)
    end
end, { silent = true })

ls.add_snippets("zig", {
    s("fn", {
        t("fn "),
        i(1),
        t("("),
        c(2, {
            t(""),
            sn(nil, {
                i(1, "foo: bar"),
            }),
        }),
        t(") "),
        i(3, "void"),
        t({ " {", "\t" }),
        i(4, "..."),
        t({ "", "}" }),
    }),

    s("const", {
        t("const "),
        i(1),
        t(" = "),
        i(2),
        t(";"),
    }),

    s("var", {
        t("var "),
        i(1),
        t(" = "),
        i(2),
        t(";"),
    }),

    s("st", {
        t("const "),
        i(1),
        t(" = struct {"),
        t({ "", "\tconst Self = @This();", "", "\t" }),
        i(2),
        t({ "", "};" }),
    }),

    s("dbg", {
        t('std.debug.print("'),
        i(1),
        t('", .{'),
        i(2),
        t({ "});" }),
    }),

    s("ldbg", {
        t('std.log.debug("'),
        i(1),
        t('", .{'),
        i(2),
        t({ "});" }),
    }),

    s("linfo", {
        t('std.log.info("'),
        i(1),
        t('", .{'),
        i(2),
        t({ "});" }),
    }),

    s("lerr", {
        t('std.log.err("'),
        i(1),
        t('", .{'),
        i(2),
        t({ "});" }),
    }),

    s("lwarn", {
        t('std.log.warn("'),
        i(1),
        t('", .{'),
        i(2),
        t({ "});" }),
    }),

    s("imp", {
        t("const "),
        i(1),
        t(' = @import("'),
        i(2),
        t({ '");' }),
    }),

    s("assert", {
        t("std.debug.assert("),
        i(1),
        t(");"),
    }),

    s("all", {
        t("std.mem.Allocator"),
    }),

    s("istd", {
        t('const std = @import("std");'),
    }),

    s("iall", {
        t("const Allocator = std.mem.Allocator;"),
    }),

    s("itesting", {
        t("const t = std.testing;"),
    }),

    s("italloc", {
        t("const t_alloc = std.testing.allocator;"),
    }),

    s("self", {
        t("const Self = @This();"),
    }),
})

ls.add_snippets("python", {
    -- def some_func(foo: bar) -> None: ...
    s("def", {
        t("def "),
        i(1),
        t("("),
        i(2, "foo: bar"),
        t(") -> "),
        i(3, "None"),
        t({ ":", "\t" }),
        i(4, "..."),
    }),
    -- class Class:
    --   def __init__(self, foo: bar) -> None:
    --     ...
    s("cls", {
        t("class "),
        i(1),
        t({ ":", "\tdef __init__(self" }),
        c(2, {
            t(""),
            sn(nil, {
                t(", "),
                i(1, "foo: bar"),
            }),
        }),
        t({ ") -> None:", "\t\t" }),
        i(3, "..."),
    }),
})
