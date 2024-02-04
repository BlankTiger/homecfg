local ls = require("luasnip")

local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.conditions")
local conds_expand = require("luasnip.extras.conditions.expand")

ls.setup()

ls.add_snippets("all", {
  -- def some_func(foo: bar) -> None: ...
  s("def", {
    t("def "),
    i(1),
    t("("),
    i(2, "foo: bar"),
    t(") -> "),
    i(3, "None"),
    t({ ":", "\t" }),
    i(4, "...")
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
    i(3, "...")
  }),
  s("clsdef", {
    t("def "),
    i(1),
    t("(self"),
    c(2, {
      t(""),
      sn(nil, {
        t(", "),
        i(1, "foo: bar"),
      }),
    }),
    t(") -> "),
    i(3, "None"),
    t({ ":", "\t" }),
    i(4, "...")
  }),
})
