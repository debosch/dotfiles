return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    watch_for_changes = true,
    view_options = {
      show_hidden = true,
    },
  },
  config = function()
    local oil = require 'oil'

    vim.keymap.set('n', '<leader>e', function()
      oil.open()
    end)

    oil.setup {
      keymaps = {
        ['<C-s>'] = false,
        ['q'] = 'actions.close',
        ['<C-l>'] = 'actions.select',
        ['<C-h>'] = 'actions.parent',
        ['<C-r>'] = 'actions.refresh',
      },
    }
  end,
  dependencies = { { 'nvim-tree/nvim-web-devicons', opts = {} } },
}
