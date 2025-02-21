
vim.o.background = "dark" -- or "light" for light mode

local themes = {
	--"gruvbox",
	"kanagawa-wave",
	"kanagawa-dragon",
	"kanagawa-lotus",
	"catppuccin",
	"tokyonight-night",
	"tokyonight-day",
	"tokyonight-moon",
	"onedark",
	"vscode",
}

local theme_index = 1

function set_theme(index) 
	if index > #themes then
		print(string.format("No theme at index %d", #themes))
	end
	theme_index = index
	vim.cmd(string.format('colorscheme %s', themes[index]))
end

function random_theme()
	theme_index = math.random(#themes)
	set_theme(theme_index)
end

function what_theme()
	print(string.format("Selected theme: %s (#%d)", themes[theme_index], theme_index))
end

vim.keymap.set('n', '<leader>hihi', random_theme, {})

vim.keymap.set('n', '<leader>th1', function() set_theme(1) end, {})
vim.keymap.set('n', '<leader>th2', function() set_theme(2) end, {})
vim.keymap.set('n', '<leader>th3', function() set_theme(3) end, {})
vim.keymap.set('n', '<leader>th4', function() set_theme(4) end, {})
vim.keymap.set('n', '<leader>th5', function() set_theme(5) end, {})
vim.keymap.set('n', '<leader>th6', function() set_theme(6) end, {})
vim.keymap.set('n', '<leader>th7', function() set_theme(7) end, {})
vim.keymap.set('n', '<leader>th8', function() set_theme(8) end, {})
vim.keymap.set('n', '<leader>th9', function() set_theme(9) end, {})
vim.keymap.set('n', '<leader>th?', function() what_theme() end, {})

set_theme(2)

