return {
  'folke/noice.nvim',
  config = function()
    require('noice').setup {
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
        },
      },
      cmdline = {
        view = 'cmdline',
      },
      views = {
        hover = {
          border = {
            style = 'rounded',
            padding = { 0, 2 },
          },
          position = { row = 2, column = 0 },
        },
      },
      notify = {
        enabled = false,
      },
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
    }
  end,
  dependencies = {
    'MunifTanjim/nui.nvim',
  },
}
