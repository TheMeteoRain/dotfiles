-- Personal options + basic autocmds (ported from the previous lazy.nvim config).

-- Enable Nerd Font features (upstream defaults this to false).
vim.g.have_nerd_font = true

-- `number` is already enabled upstream; just use a tighter gutter.
vim.o.numberwidth = 2

-- Render tabs as plain spacing instead of the upstream '» '.
vim.opt.listchars = { tab = '  ', trail = '·', nbsp = '␣' }

-- Auto-reload files that changed on disk outside of Neovim.
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold', 'CursorHoldI' }, {
  pattern = '*',
  command = "if mode() != 'c' | checktime | endif",
})

-- No line numbers inside terminal buffers (scoped to the terminal window).
vim.api.nvim_create_autocmd('TermOpen', {
  group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
  end,
})
