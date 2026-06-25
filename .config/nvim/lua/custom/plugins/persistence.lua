-- Session persistence (ported from init.lua -> vim.pack).
-- https://github.com/folke/persistence.nvim
vim.pack.add { 'https://github.com/folke/persistence.nvim' }

require('persistence').setup {
  dir = vim.fn.stdpath 'state' .. '/sessions/',
}

vim.keymap.set('n', '<leader>qs', function()
  require('persistence').load()
end, { desc = 'Restore session' })

vim.keymap.set('n', '<leader>qS', function()
  require('persistence').select()
end, { desc = 'Select session' })

vim.keymap.set('n', '<leader>ql', function()
  require('persistence').load { last = true }
end, { desc = 'Load last session' })

vim.keymap.set('n', '<leader>qd', function()
  require('persistence').stop()
end, { desc = 'Stop session saving' })
