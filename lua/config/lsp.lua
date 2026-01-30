-- lsp config

local function on_attach(client, bufnr)
	local wk = require("which-key")

	vim.diagnostic.config({
		virtual_text = true,
		virtual_lines = false,
	})

	local virtual_lines = false
	local function toggle_diagnostics()
		if virtual_lines then
			virtual_lines = false
			vim.diagnostic.config({
				virtual_lines = false,
				virtual_text = true,
			})
		else
			virtual_lines = true
			vim.diagnostic.config({
				virtual_lines = true,
				virtual_text = false,
			})
		end
	end

	wk.add({
		mode = "n",

		{
			"<leader>gd",
			function()
				vim.lsp.buf.definition()
			end,
			desc = "Go to Definition",
		},
		{
			"<leader>gD",
			function()
				vim.lsp.buf.declaration()
			end,
			desc = "Go to Declaration",
		},
		{ "<leader>gb", "<C-^>", desc = "Previous buffer" },
		{
			"<leader>gi",
			function()
				vim.lsp.buf.implementation()
			end,
			desc = "Go to Implementation",
		},
		{
			"<leader>gt",
			function()
				vim.lsp.buf.type_definition()
			end,
			desc = "Go to Type Definition",
		},
		{ "<leader><CR>", vim.lsp.buf.code_action, desc = "Code action" },
		{
			"<F2>",
			function()
				vim.lsp.buf.rename()
			end,
			desc = "Rename symbol",
		},
		{ "<F3>", toggle_diagnostics, desc = "Toggle diagnostics" },
		{ "<leader>chs", ":ClangdSwitchSourceHeader<CR>", desc = "Switch Source/Header" },
	})

	wk.add({
		"<C-h>",
		function()
			vim.lsp.buf.signature_help()
		end,
		mode = { "n", "i" },
		desc = "Signature Help",
	})

	-- Inlay hints toggle
	if vim.lsp.inlay_hint then
		wk.add({
			{
				"<leader>L",
				function()
					vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
				end,
				desc = "Toggle inlay hints",
			},
		})
	end

	-- Document highlight
	if client.supports_method("textDocument/documentHighlight") then
		vim.api.nvim_create_autocmd("CursorMoved", {
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.clear_references()
				vim.lsp.buf.document_highlight()
			end,
		})
	end
end

-- ========================================================================
-- Server definitions using *native* vim.lsp.config
-- ========================================================================

local cfg = vim.lsp.config

vim.lsp.config["clangd"] = {
	cmd = { "clangd", "--completion-style=detailed" },
	on_attach = on_attach,
}

vim.lsp.config["rust_analyzer"] = { on_attach = on_attach }
vim.lsp.config["pylsp"] = { on_attach = on_attach }
vim.lsp.config["zls"] = { on_attach = on_attach }
vim.lsp.config["texlab"] = { on_attach = on_attach }
vim.lsp.config["lua_ls"] = { on_attach = on_attach }
vim.lsp.config["cmake"] = { on_attach = on_attach }
vim.lsp.config["gopls"] = { on_attach = on_attach }
vim.lsp.config["bashls"] = { on_attach = on_attach }
vim.lsp.config["ts_ls"] = { on_attach = on_attach }

-- List of servers to start
local servers = {
	"clangd",
	"rust_analyzer",
	"pylsp",
	"zls",
	"texlab",
	"lua_ls",
	"cmake",
	"gopls",
	"bashls",
	"ts_ls",
}

for _, server in ipairs(servers) do
	vim.lsp.enable(server)
end
