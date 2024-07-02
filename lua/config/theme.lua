
vim.o.background = "dark" -- or "light" for light mode

local themes = {
	"gruvbox",
	"kanagawa-wave",
	"kanagawa-dragon",
	"kanagawa-lotus",
	"catppuccin",
}

function set_theme() 
	index = math.random(#themes)
	vim.cmd(string.format('colorscheme %s', themes[index]))
end

set_theme()

