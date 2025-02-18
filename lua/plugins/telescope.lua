return {
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.6',
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = function()
			local builtin = require('telescope.builtin')
			
			local wk = require("which-key")
			wk.add({
				{'<leader>ff', builtin.find_files, desc = "Find Files", mode = 'n'},
				{'<leader>fr', builtin.live_grep, desc = "Live Grep", mode = 'n'},
				{'<leader>fg', builtin.git_files, desc = "Find Git Files", mode = 'n'},
				{'<leader>fh', builtin.help_tags, desc = "Help Tags", mode = 'n'},
			})
		end
	}
}
