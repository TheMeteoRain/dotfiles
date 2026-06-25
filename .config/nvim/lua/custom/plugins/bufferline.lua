-- Buffer tabs (ported from lazy.nvim spec -> vim.pack).
-- https://github.com/akinsho/bufferline.nvim
require('custom.lib.icons').ensure()

vim.pack.add { 'https://github.com/akinsho/bufferline.nvim' }

vim.o.showtabline = 2
require('bufferline').setup {
  options = {
    numbers = 'ordinal',
    color_icons = true,
    close_command = function(bufnr)
      vim.api.nvim_buf_delete(bufnr, { force = false })
    end,
    right_mouse_command = function(bufnr)
      vim.api.nvim_buf_delete(bufnr, { force = false })
    end,
    diagnostics = 'nvim_lsp',
    always_show_bufferline = true,
  },
}

local map = vim.keymap.set
-- navigation
map('n', '<Tab>', '<cmd>BufferLineCycleNext<cr>', { desc = 'Next Buffer' })
map('n', '<S-Tab>', '<cmd>BufferLineCyclePrev<cr>', { desc = 'Prev Buffer' })
map('n', ']b', '<cmd>BufferLineCycleNext<cr>', { desc = 'Next Buffer' })
map('n', '[b', '<cmd>BufferLineCyclePrev<cr>', { desc = 'Prev Buffer' })
-- move buffers
map('n', ']B', '<cmd>BufferLineMoveNext<cr>', { desc = 'Move Buffer Next' })
map('n', '[B', '<cmd>BufferLineMovePrev<cr>', { desc = 'Move Buffer Prev' })
-- close buffers
map('n', '<leader>x', function()
  -- Delete the buffer but keep the window: mini.bufremove switches the window
  -- to the previous/alternate buffer first (or a scratch buffer if none), so
  -- the window is never left empty or closed.
  require('mini.bufremove').delete(0, false)
end, { desc = 'Close Buffer (keep window)' })
map('n', '<leader>br', '<cmd>BufferLineCloseRight<cr>', { desc = 'Close Right Buffers' })
map('n', '<leader>bl', '<cmd>BufferLineCloseLeft<cr>', { desc = 'Close Left Buffers' })
map('n', '<leader>bo', '<cmd>BufferLineCloseOthers<cr>', { desc = 'Close Other Buffers' })
-- buffer picking
map('n', '<leader>bp', '<cmd>BufferLinePick<cr>', { desc = 'Pick Buffer' })
map('n', '<leader>bc', '<cmd>BufferLinePickClose<cr>', { desc = 'Pick & Close Buffer' })
-- pinning
map('n', '<leader>bP', '<cmd>BufferLineTogglePin<cr>', { desc = 'Toggle Pin Buffer' })
