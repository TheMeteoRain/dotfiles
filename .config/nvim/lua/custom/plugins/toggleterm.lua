-- Terminal management (ported from lazy.nvim spec -> vim.pack).
-- https://github.com/akinsho/toggleterm.nvim
vim.pack.add { 'https://github.com/akinsho/toggleterm.nvim' }

require('toggleterm').setup {
  insert_mappings = true,
  terminal_mappings = true,
  size = function(term)
    if term.direction == 'horizontal' then
      return 15
    elseif term.direction == 'vertical' then
      return math.floor(vim.o.columns * 0.4)
    end
  end,
}

-- Cached terminal instances (built once, reused so the session persists).
local Terminal = require('toggleterm.terminal').Terminal
local lazygit_term, claude_term

local function lazygit_toggle()
  if not lazygit_term then
    lazygit_term = Terminal:new {
      cmd = 'lazygit',
      hidden = true,
      direction = 'float',
      close_on_exit = true,
      autochdir = true,
      float_opts = { border = 'rounded' },
    }
  end
  lazygit_term:toggle()
end

local function claude_toggle()
  if not claude_term then
    claude_term = Terminal:new {
      cmd = 'claude --continue 2>/dev/null || claude',
      hidden = true,
      direction = 'float',
      close_on_exit = false,
      autochdir = true,
      float_opts = { border = 'rounded' },
    }
  end
  claude_term:toggle()
end

local map = vim.keymap.set
-- main toggle
map('n', '<leader>tt', '<cmd>ToggleTerm direction=float<CR>', { desc = 'Toggle Terminal' })
-- specific layouts
-- NOTE: <leader>th is also the LSP "Toggle Inlay Hints" mapping, but that one is
-- buffer-local and only active in buffers with an attached LSP, so this global
-- mapping wins everywhere else.
map('n', '<leader>th', '<cmd>ToggleTerm direction=horizontal<CR>', { desc = 'Horizontal Terminal' })
map('n', '<leader>tv', '<cmd>ToggleTerm direction=vertical<CR>', { desc = 'Vertical Terminal' })
-- numbered terminals
map('n', '<leader>t1', '<cmd>1ToggleTerm<CR>', { desc = 'Terminal 1' })
map('n', '<leader>t2', '<cmd>2ToggleTerm<CR>', { desc = 'Terminal 2' })
map('n', '<leader>t3', '<cmd>3ToggleTerm<CR>', { desc = 'Terminal 3' })
-- close all open floats (keeps their sessions alive)
map('n', '<leader>tq', function()
  for _, term in ipairs(require('toggleterm.terminal').get_all(true)) do
    if term.direction == 'float' then
      term:close()
    end
  end
end, { desc = 'Close all float terminals' })
-- persistent named floats
map('n', '<leader>tg', lazygit_toggle, { desc = 'LazyGit' })
map('n', '<leader>tc', claude_toggle, { desc = 'Claude terminal' })
