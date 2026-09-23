return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local ollama_adapter = require("codecompanion.adapters.http.ollama")

		-- Add status notifications for inline processing
		vim.api.nvim_create_autocmd("User", {
			pattern = "CodeCompanionRequestStarted",
			callback = function(ev)
				local model = ev.data and ev.data.model or "LLM"
				vim.notify("Processing with " .. model .. "...", vim.log.levels.INFO, { title = "CodeCompanion" })
			end,
		})

		vim.api.nvim_create_autocmd("User", {
			pattern = "CodeCompanionRequestFinished",
			callback = function()
				vim.notify("Completed!", vim.log.levels.INFO, { title = "CodeCompanion" })
			end,
		})

		require("codecompanion").setup({
			extensions = {
				-- mcphub = {
				-- 	callback = "mcphub.extensions.codecompanion",
				-- 	opts = {
				-- 		-- MCP Tools
				-- 		make_tools = true, -- Make individual tools (@server__tool) and server groups (@server) from MCP servers
				-- 		show_server_tools_in_chat = true, -- Show individual tools in chat completion (when make_tools=true)
				-- 		add_mcp_prefix_to_tool_names = false, -- Add mcp__ prefix (e.g `@mcp__github`, `@mcp__neovim__list_issues`)
				-- 		show_result_in_chat = true, -- Show tool results directly in chat buffer
				-- 		-- MCP Resources
				-- 		make_vars = true, -- Convert MCP resources to #variables for prompts
				-- 		-- MCP Prompts
				-- 		make_slash_commands = true, -- Add MCP prompts as /slash commands
				-- 	},
				-- },
			},
			opts = {
				log_level = "DEBUG", -- TRACE|DEBUG|INFO|WARN|ERROR
			},
			strategies = {
				chat = {
					adapter = "ollama",
					roles = {
						llm = function(adapter)
							local model = adapter.schema.model.default
							if type(model) == "function" then
								model = model(adapter)
							end
							local choices = adapter.schema.model.choices
							if type(choices) == "table" and choices[model] and choices[model].formatted_name then
								return choices[model].formatted_name
							end
							return "CodeCompanion (" .. adapter.formatted_name .. " - " .. model .. ")"
						end,
						user = "Dani",
					},
				},
				inline = {
					adapter = "ollama",
				},
			},
			adapters = {
				http = {
					ollama = vim.tbl_deep_extend("force", ollama_adapter, {
						schema = {
							model = {
								default = "qwen3-coder:latest",
								choices = {
									["qwen3:30b"] = {
										formatted_name = "Qwen3 30B - General Purpose",
									},
									["qwen3-coder:latest"] = {
										formatted_name = "Qwen3 Coder - Coding Specialist",
									},
								},
							},
							think = {
								default = false,
							},
							keep_alive = {
								default = "30m", -- Keep model loaded for 30 minutes
							},
							temperature = {
								default = 0.3, -- Lower temperature for more consistent output
							},
						},
					}),
				},
			},
		})
	end,
}
