local M = {}

M.exec = function(opts)
	local command = opts.command
	local client_name = opts.client
	local args = opts.args or { vim.api.nvim_buf_get_name(0) }
	local message = opts.message or ("Executed: " .. command)

	local params = {
		command = command,
		arguments = args,
		title = opts.title or "",
	}

	local clients = vim.lsp.get_clients({ name = client_name })
	if #clients == 0 then
		vim.notify("No " .. client_name .. " client found", vim.log.levels.ERROR)
		return
	end

	local client = clients[1]
	client:exec_cmd(params)
	vim.notify(message, vim.log.levels.INFO)
end

return M
