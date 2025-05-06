return {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    -- Optional dependencies
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
    config = function()
        local oil = require("oil")
        oil.setup({
            default_file_explorer = true,
        })

        -- Autocmd to run `actions.cd` when Oil is first opened
        vim.api.nvim_create_autocmd("VimEnter", {
            callback = function()
              local oil_actions = require("oil.actions")
              oil_actions.cd.callback()
            end,
        })
    end,
}