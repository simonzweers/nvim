return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = 'VeryLazy',
		build = ":TSUpdate",
		config = function()
			require'nvim-treesitter.configs'.setup({
				-- A list of parser names, or "all" (the five listed parsers should always be installed)
				ensure_installed = { 
					"c", 
					"lua",
					"vim",
					"vimdoc",
					"query",
					"haskell",
					"go",
					"java",
					"python",
				},

				-- Install parsers synchronously (only applied to `ensure_installed`)
				sync_install = false,

				-- Automatically install missing parsers when entering buffer
				-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
				auto_install = true,

				---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
				-- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

				highlight = {
					enable = true,
					disable = { "latex" },
				},
			})
			local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()

			local parsers = require('nvim-treesitter.parsers').get_parser_configs()
			parsers.cpp.used_by = { "cpp", "hpp", "tpp" }  -- Add tpp to the list
			vim.filetype.add({
				extension = {
					tpp = "cpp",  -- Treat .tpp files as C++
				},
			})
		end
	},
}
