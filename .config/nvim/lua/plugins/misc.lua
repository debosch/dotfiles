return {
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  -- Highlight todo, notes, etc in comments

  {
    'folke/trouble.nvim',
    config = function()
      require('trouble').setup {}
    end,
  },

  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      --[[ local files = require 'mini.files'
      files.config.options.permanent_delete = false
      files.config.windows.preview = true

      local openExplorer = function()
        files.open(vim.api.nvim_buf_get_name(0))
      end

      vim.keymap.set('n', '<leader>e', openExplorer)

      files.setup() ]]

      -- https://github.com/echasnovski/mini.nvim
    end,
  },

  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end,
  },

  {
    'olexsmir/gopher.nvim',
    ft = 'go',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'mfussenegger/nvim-dap',
    },
    config = function()
      require('gopher').setup {}

      vim.keymap.set('n', '<leader>gie', '<cmd>GoIfErr<cr>', { desc = 'Add go if error statement' })
      vim.keymap.set('n', '<leader>gtaj', '<cmd>GoTagAdd json<cr>', { desc = 'Add json tags for struct' })
      vim.keymap.set('n', '<leader>gtrj', '<cmd>GoTagRm json<cr>', { desc = 'Remove json tags for struct' })
      vim.keymap.set('n', '<leader>gtay', '<cmd>GoTagAdd yaml<cr>', { desc = 'Add yaml tags for struct' })
      vim.keymap.set('n', '<leader>gtry', '<cmd>GoTagRm yaml<cr>', { desc = 'Remove yaml tags for struct' })
    end,
    build = function()
      vim.cmd.GoInstallDeps()
    end,
  },
}
