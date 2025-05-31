return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		"fredrikaverpil/neotest-golang",
		"nvim-neotest/neotest-jest",
		"marilari88/neotest-vitest",
		"nvim-neotest/neotest-python",
		"rcasia/neotest-java",
		"Issafalcon/neotest-dotnet",
	},
	config = function()
		require("neotest").setup({
			adapters = {
				require("neotest-golang")(),
				require("neotest-python")({}),
				require("neotest-java")(),
				require("neotest-dotnet")({
					dotnet_additional_args = {
						"--verbosity detailed",
					},
				}),
				require("neotest-vitest")({
					filter_dir = function(name, rel_path, root)
						return name ~= "node_modules"
					end,
				}),
				require("neotest-jest")({
					jestCommand = "npm test --", -- Or "yarn test --"
					jestConfigFile = "jest.config.ts", -- adjust to your config file
					env = { CI = true },
					cwd = function(path)
						return vim.fn.getcwd()
					end,
				}),
			},
		})
	end,

	keys = {
		{ "<leader>t", desc = "Test" },
		{
			"<leader>ta",
			function()
				require("neotest").run.attach()
			end,
			desc = "[t]est [a]ttach",
		},
		{
			"<leader>tF",
			function()
				require("neotest").run.run(vim.fn.expand("%"))
			end,
			desc = "[t]est run [f]ile",
		},
		{
			"<leader>tA",
			function()
				require("neotest").run.run(vim.uv.cwd())
			end,
			desc = "[t]est [A]ll files",
		},
		{
			"<leader>tS",
			function()
				require("neotest").run.run({ suite = true })
			end,
			desc = "[t]est [S]uite",
		},
		{
			"<leader>ta",
			function()
				require("neotest").run.run()
			end,
			desc = "[t]est [n]earest",
		},
		{
			"<leader>tl",
			function()
				require("neotest").run.run_last()
			end,
			desc = "[t]est [l]ast",
		},
		{
			"<leader>ts",
			function()
				require("neotest").summary.toggle()
			end,
			desc = "Toggle Summary (Neotest)",
		},
		{
			"<leader>to",
			function()
				require("neotest").output.open({ enter = true, auto_close = true })
			end,
			desc = "[t]est [o]utput",
		},
		{
			"<leader>tO",
			function()
				require("neotest").output_panel.toggle()
			end,
			desc = "[t]est [O]utput panel",
		},
		{
			"<leader>tt",
			function()
				require("neotest").run.stop()
			end,
			desc = "[t]est [t]erminate",
		},
		{
			"<leader>td",
			function()
				require("neotest").run.run({ suite = false, strategy = "dap" })
			end,
			desc = "Debug nearest test",
		},
		{
			"<leader>tD",
			function()
				require("neotest").run.run({ vim.fn.expand("%"), strategy = "dap" })
			end,
			desc = "Debug current file",
		},
	},
}
