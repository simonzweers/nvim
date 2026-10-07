-- Prompt for (and override) the arguments of the selected configuration
local function get_args(config)
	local args = type(config.args) == "function" and (config.args() or {}) or config.args or {}
	local args_str = type(args) == "table" and table.concat(args, " ") or args
	config = vim.deepcopy(config)
	config.args = function()
		return require("dap.utils").splitstr(vim.fn.input("Run with args: ", args_str))
	end
	return config
end

return {
	{
		"rcarriga/nvim-dap-ui",
		event = "VeryLazy",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"mfussenegger/nvim-dap",
		},
		-- stylua: ignore
		keys = {
			{ "<leader>du", function() require("dapui").toggle({ }) end, desc = "Dap UI" },
			{ "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "v"} },
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open({})
			end
			-- Keep the UI open when the debuggee exits so its output stays visible.
			-- Close it manually with <leader>du.
			dap.adapters.gdb = {
				id = "gdb",
				type = "executable",
				command = "gdb",
				args = { "--interpreter=dap", "--quiet" },
			}
			dap.configurations.cpp = {
				{
					name = "Run executable (GDB)",
					type = "gdb",
					request = "launch",
					program = function()
						local path = vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
						return (path and path ~= "") and path or dap.ABORT
					end,
					cwd = "${workspaceFolder}",
					stopAtBeginningOfMainSubprogram = false,
				},
				{
					name = "Run executable with arguments (GDB)",
					type = "gdb",
					request = "launch",
					-- This requires special handling of 'run_last', see
					-- https://github.com/mfussenegger/nvim-dap/issues/1025#issuecomment-1695852355
					program = function()
						local path = vim.fn.input({
							prompt = "Path to executable: ",
							default = vim.fn.getcwd() .. "/",
							completion = "file",
						})

						return (path and path ~= "") and path or dap.ABORT
					end,
					args = function()
						local args_str = vim.fn.input({
							prompt = "Arguments: ",
						})
						return require("dap.utils").splitstr(args_str)
					end,
					cwd = "${workspaceFolder}",
				},
				{
					name = "Attach to process (GDB)",
					type = "gdb",
					request = "attach",
					pid = require("dap.utils").pick_process,
				},
			}
			dap.configurations.c = dap.configurations.cpp

			dapui.setup()
		end,
	},
	{
		"mfussenegger/nvim-dap",
		event = "VeryLazy",
		recommended = true,
		desc = "Debugging support. Requires language specific adapters to be configured. (see lang extras)",

		dependencies = {
			"rcarriga/nvim-dap-ui",
			-- virtual text for the debugger
			{
				"theHamsta/nvim-dap-virtual-text",
				opts = {},
			},
		},
		-- stylua: ignore
		keys = {
			{ "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
			{ "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
			{ "<leader>dc", function() require("dap").continue() end, desc = "Run/Continue" },
			{ "<leader>da", function() require("dap").continue({ before = get_args }) end, desc = "Run with Args" },
			{ "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
			{ "<leader>dg", function() require("dap").goto_() end, desc = "Go to Line (No Execute)" },
			{ "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
			{ "<leader>dj", function() require("dap").down() end, desc = "Down" },
			{ "<leader>dk", function() require("dap").up() end, desc = "Up" },
			{ "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
			{ "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
			{ "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
			{ "<leader>dP", function() require("dap").pause() end, desc = "Pause" },
			{ "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
			{ "<leader>ds", function() require("dap").session() end, desc = "Session" },
			{ "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
			{ "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
		},

		-- config = function()
		-- end,
	},
}
