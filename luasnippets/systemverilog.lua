local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
	s({ trig = "dump", dscr = "Dump waveform to VCD" }, {
		t({ "initial begin", '\t$dumpfile("waveform.vcd");', "\t$dumpvars(0, " }),
		i(1, "tb"),
		t({ ");", "end" }),
	}),
}
