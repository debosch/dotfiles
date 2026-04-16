local vscode = require 'vscode'

vim.opt.clipboard = 'unnamedplus'
vim.opt.ignorecase = true
vim.opt.scrolloff = 10
vim.opt.smartcase = true
vim.notify = vscode.notify
vim.g.clipboard = vim.g.vscode_clipboard

vim.cmd 'nmap j gj'
vim.cmd 'nmap k gk'

local function stay_centered()
  local curline = vim.fn.line '.'
  vscode.call('revealLine', { args = { lineNumber = curline, at = 'center' } })
end

vim.keymap.set('n', '<C-d>', function()
  vim.cmd ':silent! norm! <C-d>'
  stay_centered()
end, { noremap = true, silent = true })

vim.keymap.set('n', '<C-u>', function()
  vim.cmd ':silent! norm! <C-u>'
  stay_centered()
end, { noremap = true, silent = true })

vim.keymap.set('n', 'n', function()
  vim.cmd ':silent! norm! n'
  stay_centered()
end, { noremap = true, silent = true })

vim.keymap.set('n', 'N', function()
  vim.cmd ':silent! norm! N'
  stay_centered()
end, { noremap = true, silent = true })
