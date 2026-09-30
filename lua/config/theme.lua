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
	vim.cmd(string.format("colorscheme %s", themes[index]))
	-- For transparency:
	-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

function random_theme()
	theme_index = math.random(#themes)
	set_theme(theme_index)
end

function what_theme()
	print(string.format("Selected theme: %s (#%d)", themes[theme_index], theme_index))
end

vim.keymap.set("n", "<leader>hihi", random_theme, {})

vim.keymap.set("n", "<leader>th1", function()
	set_theme(1)
end, {})
vim.keymap.set("n", "<leader>th2", function()
	set_theme(2)
end, {})
vim.keymap.set("n", "<leader>th3", function()
	set_theme(3)
end, {})
vim.keymap.set("n", "<leader>th4", function()
	set_theme(4)
end, {})
vim.keymap.set("n", "<leader>th5", function()
	set_theme(5)
end, {})
vim.keymap.set("n", "<leader>th6", function()
	set_theme(6)
end, {})
vim.keymap.set("n", "<leader>th7", function()
	set_theme(7)
end, {})
vim.keymap.set("n", "<leader>th8", function()
	set_theme(8)
end, {})
vim.keymap.set("n", "<leader>th9", function()
	set_theme(9)
end, {})
vim.keymap.set("n", "<leader>th?", function()
	what_theme()
end, {})

-- Give the gutter (line numbers, signs, folds) a background that differs from the
-- editor, using the first theme-provided background that isn't the Normal one
local function tint_gutter()
	local normal_bg = vim.api.nvim_get_hl(0, { name = "Normal", link = false }).bg
	local gutter_bg
	for _, group in ipairs({ "SignColumn", "NormalFloat", "ColorColumn", "CursorLine", "StatusLine" }) do
		local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
		local bg = hl.reverse and hl.fg or hl.bg
		if bg and bg ~= normal_bg then
			gutter_bg = bg
			break
		end
	end
	if not gutter_bg then
		return
	end
	for _, group in ipairs({ "LineNr", "LineNrAbove", "LineNrBelow", "CursorLineNr", "SignColumn", "FoldColumn" }) do
		local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
		hl.bg = gutter_bg
		vim.api.nvim_set_hl(0, group, hl)
	end
end

vim.api.nvim_create_autocmd("ColorScheme", {
	group = vim.api.nvim_create_augroup("TintGutter", { clear = true }),
	callback = tint_gutter,
})

local hostname = vim.fn.hostname()

-- print("hostname: " .. hostname)

vim.cmd(string.format("colorscheme %s", "gruvbox"))
-- if hostname == "simon-pc-opensuse" then
-- else
-- 	set_theme(5)
-- end
