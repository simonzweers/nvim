return {
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
			"theHamsta/nvim-dap-virtual-text"
		},
		config = function ()
			local dapui = require("dapui")
			dapui.setup()
			local dap = require("dap")
			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end
		end,
	},
	{
		"mfussenegger/nvim-dap",
		config = function ()
			local dap = require("dap")
			dap.adapters.gdb = {
				type = "executable",
				command = "gdb",
				args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
			}
			dap.configurations.c = {
				{
					name = "Launch",
					type = "gdb",
					request = "launch",
					program = function()
						return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
					end,
					cwd = "${workspaceFolder}",
					stopAtBeginningOfMainSubprogram = false,
				},
				{
					name = "Select and attach to process",
					type = "gdb",
					request = "attach",
					program = function()
						return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
					end,
					pid = function()
						local name = vim.fn.input('Executable name (filter): ')
						return require("dap.utils").pick_process({ filter = name })
					end,
					cwd = '${workspaceFolder}'
				},
				{
					name = 'Attach to gdbserver :1234',
					type = 'gdb',
					request = 'attach',
					target = 'localhost:1234',
					program = function()
						return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
					end,
					cwd = '${workspaceFolder}'
				},
			}
			dap.configurations.cpp = dap.configurations.c
			-- local wk = require("which-key")
			-- wk.add({
			-- 	{
			-- 		mode = 'n',
			-- 		{ "<leader>dB", function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
			-- 		{ "<leader>db", function() dap.toggle_breakpoint() end, desc = "Toggle Breakpoint" },
			-- 		{ "<leader>dc", function() dap.continue() end, desc = "Run/Continue" },
			-- 		{ "<leader>da", function() dap.continue({ before = get_args }) end, desc = "Run with Args" },
			-- 		{ "<leader>dC", function() dap.run_to_cursor() end, desc = "Run to Cursor" },
			-- 		{ "<leader>dg", function() dap.goto_() end, desc = "Go to Line (No Execute)" },
			-- 		{ "<leader>di", function() dap.step_into() end, desc = "Step Into" },
			-- 		{ "<leader>dj", function() dap.down() end, desc = "Down" },
			-- 		{ "<leader>dk", function() dap.up() end, desc = "Up" },
			-- 		{ "<leader>dl", function() dap.run_last() end, desc = "Run Last" },
			-- 		{ "<leader>do", function() dap.step_out() end, desc = "Step Out" },
			-- 		{ "<leader>dO", function() dap.step_over() end, desc = "Step Over" },
			-- 		{ "<leader>dP", function() dap.pause() end, desc = "Pause" },
			-- 		{ "<leader>dr", function() dap.repl.toggle() end, desc = "Toggle REPL" },
			-- 		{ "<leader>ds", function() dap.session() end, desc = "Session" },
			-- 		{ "<leader>dt", function() dap.terminate() end, desc = "Terminate" },
			-- 		{ "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
			-- 	},
			-- })
		end
	}
}
