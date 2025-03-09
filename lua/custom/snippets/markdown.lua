local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node

ls.add_snippets("markdown", {
    s("cos", t("\\cos")),
    s("sin", t("\\sin")),
    s("tan", t("\\tan")),
    s("log", t("\\log")),
    s("ln", t("\\ln")),
    s("sqrt", t("\\sqrt")),
})
