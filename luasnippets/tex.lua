local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

local function in_mathzone()
	return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end

-- trigger -> { left, right }
local delimiters = {
	["lr("] = { "\\left(", "\\right)" },
	["lr["] = { "\\left[", "\\right]" },
	["lr{"] = { "\\left\\{", "\\right\\}" },
	["lr|"] = { "\\left|", "\\right|" },
	["lr<"] = { "\\left\\langle", "\\right\\rangle" },
}

local autosnippets = {}
for trig, delim in pairs(delimiters) do
	table.insert(
		autosnippets,
		s({ trig = trig, dscr = delim[1] .. " " .. delim[2], condition = in_mathzone }, {
			t(delim[1] .. " "),
			i(1),
			t(" " .. delim[2]),
		})
	)
end

table.insert(
	autosnippets,
	s({ trig = "dsp", dscr = "displaystyle macro", condition = in_mathzone }, {
		t("\\displaystyle"),
		i(1),
	})
)

local snippets = {}
table.insert(
	snippets,
	s({ trig = "circuit", "circuitikz (American)" }, {
		t({ "\\begin{circuitikz}[american, scale=1]", "\t\\draw " }),
		i(1, "cirucit-code"),
		t({ "\t;", "\\end{circuitikz}" }),
	})
)

return snippets, autosnippets
