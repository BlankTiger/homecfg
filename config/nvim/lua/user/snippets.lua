local ls = require("luasnip")

local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
-- local f = ls.function_node
-- local d = ls.dynamic_node
-- local r = ls.restore_node
-- local l = require("luasnip.extras").lambda
-- local rep = require("luasnip.extras").rep
-- local p = require("luasnip.extras").partial
-- local m = require("luasnip.extras").match
-- local n = require("luasnip.extras").nonempty
-- local dl = require("luasnip.extras").dynamic_lambda
-- local fmt = require("luasnip.extras.fmt").fmt
-- local fmta = require("luasnip.extras.fmt").fmta
-- local types = require("luasnip.util.types")
-- local conds = require("luasnip.extras.conditions")
-- local conds_expand = require("luasnip.extras.conditions.expand")

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
        t('log.debug("'),
        i(1),
        t('", .{'),
        i(2),
        t({ "});" }),
    }),

    s("linfo", {
        t('log.info("'),
        i(1),
        t('", .{'),
        i(2),
        t({ "});" }),
    }),

    s("lerr", {
        t('log.err("'),
        i(1),
        t('", .{'),
        i(2),
        t({ "});" }),
    }),

    s("lwarn", {
        t('log.warn("'),
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

    s("istd", {
        t('const std = @import("std");'),
    }),

    s("ialloc", {
        t("const Allocator = std.mem.Allocator;"),
    }),

    s("itesting", {
        t("const t = std.testing;"),
    }),

    s("italloc", {
        t("const t_alloc = std.testing.allocator;"),
    }),

    s("Self", {
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
    s("runner", {
        t({ "from blajira import Issue, IssueContainer, JiraClient", "" }),
        t({ "from itertools import chain", "" }),
        t({ "from typing import Dict, List", "", "", "" }),
        t({ "class Runner:", "" }),
        t({ "\tdef __init__(self, jira_client: JiraClient" }),
        c(1, {
            t(""),
            sn(nil, {
                t(", "),
                i(1, "foo: bar"),
            }),
        }),
        t({ ") -> None:", "\t\tself._jira_client = jira_client", "" }),
        t({ "\t\tself._issue_container = IssueContainer()", "\t\t" }),
        i(2, "..."),
        t({ "", "", "" }),
        t({ "\tdef run(self) -> None:", "" }),
        t({ "\t\tissues = self._fetch_issues()", "\t\t" }),
        i(3, "..."),
        t({ "", "", "" }),
        t({ "\tdef _fetch_issues(self) -> Dict[str, List[Issue]]:", "" }),
        t({ "\t\tjqls = JQLs()", "" }),
        t({
            "\t\tissues = {",
            '\t\t\t"some_issues": self._jira_client.get_issues(jqls.some_issues),',
            "\t\t}",
            "",
        }),
        t({ "\t\tself._issue_container.add_issues(chain.from_iterable(issues.values()))", "" }),
        t({ "\t\treturn issues" }),
    }),
    s("jqls", {
        t({ "from blajira import JQL", "" }),
        t({ "from typing import List", "", "", "" }),
        t({ "class JQLs:", "" }),
        t({ "\t@property", "" }),
        t({ "\tdef all(self) -> List[JQL]:", "" }),
        t({ "\t\treturn []" }),
    }),
    s("jql", {
        t({ "\t@property", "" }),
        t({ "\tdef " }),
        i(1, "jql_name"),
        t({ "(self) -> JQL:", "" }),
        t({ '\t\treturn JQL(CONFIG["' }),
        i(2, "jql_name"),
        t({ '"].get(str)).format(', "\t\t\t" }),
        i(3, 'project=CONFIG["project"].get(str)'),
        t({ ",", "\t\t)" }),
    }),
    s("test_jqls", {
        t({ "from blajira import JiraClient", "" }),
        t({ "from blajira.jira_test import OnlineJiraTest", "", "", "" }),
        t({ "class TestJQLs(OnlineJiraTest):", "" }),
        t({ "\tdef test_jqls(self, jira_client: JiraClient) -> None:", "" }),
        t({ "\t\tfor jql in JQLs().all:", "" }),
        t({ "\t\t\tself.verify_jql(jql, jira_client)" }),
    }),
    s("main", {
        t({ "from blajira import OnlineJiraClient", "", "", "" }),
        t({ "def run_" }),
        i(1, "something"),
        t({ "(config_filename: str) -> None:", "" }),
        t({ "\tload_module_config(CONFIG_DIR, config_filename)", "" }),
        t({ '\tjira_client = OnlineJiraClient(CONFIG["jira_address"].get(str))', "" }),
        t({ "\tRunner(jira_client).run()" }),
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
        i(4, "..."),
    }),
    s("pyc", {
        t({ "# %%", "" }),
    }),
    s("mdc", {
        t({ "# %% [markdown]", "" }),
    }),
})
