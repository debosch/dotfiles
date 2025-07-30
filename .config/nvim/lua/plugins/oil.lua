return {
  {
    'stevearc/oil.nvim',
    config = function()
      local oil = require 'oil'

      vim.keymap.set('n', '<leader>e', function()
        oil.open(nil, { preview = {
          vertical = true,
        } })
      end)

      oil.setup {
        win_options = {
          signcolumn = 'yes:2',
        },
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
    dependencies = { { 'echasnovski/mini.icons', opts = {} } },
  },
  {
    'refractalize/oil-git-status.nvim',
    dependencies = {
      'stevearc/oil.nvim',
    },
    config = true,
  },
}
