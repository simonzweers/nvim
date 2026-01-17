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

cfg.clangd = {
	cmd = { "clangd", "--completion-style=detailed" },
	on_attach = on_attach,
}

cfg.rust_analyzer = { on_attach = on_attach }
cfg.pylsp = { on_attach = on_attach }
cfg.zls = { on_attach = on_attach }
cfg.texlab = { on_attach = on_attach }
cfg.lua_ls = { on_attach = on_attach }
cfg.cmake = { on_attach = on_attach }
cfg.gopls = { on_attach = on_attach }
cfg.bashls = { on_attach = on_attach }
cfg.ts_ls = { on_attach = on_attach }

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

-- ========================================================================
-- Auto-start LSPs when entering a buffer
-- ========================================================================

vim.api.nvim_create_autocmd("FileType", {
	callback = function(event)
		local ft = event.match

		for _, server in ipairs(servers) do
			local s = cfg[server]
			if not s then
				goto continue
			end

			-- If server defines a filetype filter, enforce it
			if s.filetypes and not vim.tbl_contains(s.filetypes, ft) then
				goto continue
			end

			-- Detect root: git, project manifests, fallback to cwd
			s.root_dir = vim.fs.root(event.buf, { ".git", "package.json", "CMakeLists.txt" }) or vim.fn.getcwd()

			-- Start LSP
			vim.lsp.start(s)

			::continue::
		end
	end,
})
