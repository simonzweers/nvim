return {
	{
		"lervag/vimtex",
		-- lazy = false, -- we don't want to lazy load VimTeX
		lazy = false,
		-- tag = "v2.15", -- uncomment to pin to a specific release
		init = function()
			-- VimTeX configuration goes here, e.g.
			vim.g.vimtex_view_method = "zathura"
			vim.g.vimtex_view_general_viewer = "okular"
			-- vim.g.vimtex_compiler_latexmk = "-pdf -shell-escape -file-line-error -synctex=1 -interaction=nonstopmode"
			vim.g.vimtex_quickfix_enabled = 0 -- Disable quickfix list population
			vim.g.vimtex_inline_errors = 1 -- Enable inline error display (virtual text)
			-- Compiler settings (modern latexmk flags)
			vim.g.vimtex_compiler_latexmk = {
				aux_dir = "",
				out_dir = "",
				callback = 1,
				continuous = 1,
				executable = "latexmk",
				hooks = {},
				options = {
					"-verbose",
					"-file-line-error",
					"-synctex=1",
					"-interaction=nonstopmode",
					"-shell-escape",
				},
			} --vim.g.vimtex_view_general_options = "--unique file:@pdf\#src:@line@tex"
		end,
	},
}
