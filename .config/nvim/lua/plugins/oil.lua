return {
  'stevearc/oil.nvim',
  config = function()
    local oil = require 'oil'

    vim.keymap.set('n', '<leader>e', function()
      oil.open(nil, { preview = {
        vertical = true,
      } })
    end)

    oil.setup {
      watch_for_changes = true,
      view_options = {
        show_hidden = true,
      },
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
