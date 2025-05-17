return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"nvim-neotest/nvim-nio",
			"leoluz/nvim-dap-go",
		},
		config = function()
			local dap = require("dap")
			local dap_ui = require("dapui")
			local dap_go = require("dap-go")

			dap_ui.setup()
			dap_go.setup({
				dap_configurations = {
					{
						type = "go",
						name = "Attach remote",
						mode = "remote",
						request = "attach",
					},
				},
				tests = {
					-- enables verbosity when running the test.
					verbose = false,
				},
				delve = {
					path = "dlv",
					port = "38697",
				},
			})

			require("nvim-dap-virtual-text").setup({
				-- Mitigate the chance of leaking tokens here. Probably won't stop it from happening...
				display_callback = function(variable)
					local name = string.lower(variable.name)
					local value = string.lower(variable.value)
					if name:match("secret") or name:match("api") or value:match("secret") or value:match("api") then
						return "*****"
					end

					if #variable.value > 15 then
						return " " .. string.sub(variable.value, 1, 15) .. "... "
					end

					return " " .. variable.value
				end,
			})

			-- .NET Core Debugger Start
			local netcoredbg_path = vim.fn.stdpath("data") .. "/mason/packages/netcoredbg/netcoredbg"

			dap.adapters.coreclr = {
				type = "executable",
				command = netcoredbg_path,
				args = { "--interpreter=vscode" },
			}

			dap.configurations.cs = {
				{
					type = "coreclr",
					name = "Launch - .NET Core",
					request = "launch",
					program = function()
						-- This prompts for the DLL path after building the .NET project
						return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/bin/Debug/net8.0/", "file")
					end,
				},
			}

			-- Customize breakpoint signs
			vim.api.nvim_set_hl(0, "DapStoppedHl", { fg = "#98BB6C", bg = "#2A2A2A", bold = true })
			vim.api.nvim_set_hl(0, "DapStoppedLineHl", { bg = "#204028", bold = true })
			vim.fn.sign_define(
				"DapStopped",
				{ text = "", texthl = "DapStoppedHl", linehl = "DapStoppedLineHl", numhl = "" }
			)
			vim.fn.sign_define(
				"DapBreakpoint",
				{ text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" }
			)
			vim.fn.sign_define(
				"DapBreakpointCondition",
				{ text = "", texthl = "DiagnosticSignWarn", linehl = "", numhl = "" }
			)
			vim.fn.sign_define(
				"DapBreakpointRejected",
				{ text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" }
			)
			vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DiagnosticSignInfo", linehl = "", numhl = "" })

			-- DAP UI Functionality
			dap.listeners.before.attach.dapui_config = function()
				dap_ui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dap_ui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dap_ui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dap_ui.close()
			end
		end,
	},
}
