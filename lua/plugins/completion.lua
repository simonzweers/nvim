return {
	{
		'L3MON4D3/LuaSnip',
		event = 'VeryLazy',
		dependencies = {
			"rafamadriz/friendly-snippets",
			"saadparwaiz1/cmp_luasnip"
		},
	},
	{
		'hrsh7th/nvim-cmp',
		event = 'VeryLazy',
		config = function()
			local cmp = require('cmp')
			local cmp_select = {behavior = cmp.SelectBehavior.Select}
			require('luasnip.loaders.from_vscode').lazy_load()
			local luasnip = require("luasnip")

			vim.keymap.set({"i"}, "<C-L>", function() luasnip.expand() end, {silent = true})
			vim.keymap.set({"i", "s"}, "<C-K>", function() luasnip.jump( 1) end, {silent = true})
			vim.keymap.set({"i", "s"}, "<C-J>", function() luasnip.jump(-1) end, {silent = true})

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					-- documentation = cmp.config.window.bordered(),
				},
				sources = cmp.config.sources({
					{name = 'nvim_lsp', priority = 50},
					{name = 'luasnip', priority = 100},
					{name = 'buffer', keyword_length = 3},
					{name = 'path'},
					{name = 'nvim_lsp_signature_help' },
					{name = 'nvim_lua'},
				}),
				mapping = cmp.mapping.preset.insert({
					['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
					['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
					['<C-k>'] = cmp.mapping.select_prev_item(cmp_select),
					['<C-j>'] = cmp.mapping.select_next_item(cmp_select),

					['<C-i>'] = cmp.mapping.scroll_docs(-4),
					['<C-u>'] = cmp.mapping.scroll_docs(4),

					['<CR>'] = cmp.mapping.confirm({select = true}),
					['<Tab>'] = cmp.mapping(function(fallback)

						if luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { 'i', 's' }), -- Tab to expand or jump
					['<S-Tab>'] = cmp.mapping(function(fallback)
						if luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { 'i', 's' }), -- Shift-Tab to jump backward
				}),
			})
		end
	},
	{'hrsh7th/cmp-nvim-lsp'},
}
