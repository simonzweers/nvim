return {
	{
		"mbbill/undotree",
		event = "VeryLazy",
		keys = {
			{ "<leader>U", vim.cmd.UndotreeToggle, desc = "Toggle Undotree" },
		},
		config = function()
			vim.g.undotree_WindowLayout = 3
		end,
	},
}
