-- Personal keymaps (ported from the previous lazy.nvim config).

-- Save with Ctrl+S (normal, visual and insert mode).
vim.keymap.set({ 'n', 'v' }, '<C-s>', '<cmd>w<CR>', { desc = 'Save file' })
vim.keymap.set('i', '<C-s>', '<Esc><cmd>w<CR>', { desc = 'Save file and leave insert mode' })

-- Ctrl+Q exits to normal mode (from insert and terminal mode, incl. toggleterm).
vim.keymap.set({ 'i', 't' }, '<C-q>', '<C-\\><C-n>', { desc = 'Exit to normal mode' })

-- "jk" leaves insert mode (equivalent to `inoremap jk <Esc>`).
vim.keymap.set({ 'i', 't' }, 'jk', '<C-\\><C-n>', { desc = 'Exit insert mode' })

-- Bigger steps for the built-in <C-w> resize chords (defaults move by 1 per
-- press). Tweak these two numbers to taste; <C-w>= still equalizes.
local height_step = 3
local width_step = 6
vim.keymap.set('n', '<C-w>+', height_step .. '<C-w>+', { desc = 'Increase window height' })
vim.keymap.set('n', '<C-w>-', height_step .. '<C-w>-', { desc = 'Decrease window height' })
vim.keymap.set('n', '<C-w>>', width_step .. '<C-w>>', { desc = 'Increase window width' })
vim.keymap.set('n', '<C-w><', width_step .. '<C-w><', { desc = 'Decrease window width' })
