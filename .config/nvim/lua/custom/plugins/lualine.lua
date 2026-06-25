-- Statusline (ported from lazy.nvim spec -> vim.pack).
-- https://github.com/nvim-lualine/lualine.nvim
--
-- NOTE: lualine takes over the statusline from the upstream mini.statusline.
-- If you prefer mini.statusline, delete this file.
require('custom.lib.icons').ensure()

vim.pack.add { 'https://github.com/nvim-lualine/lualine.nvim' }

require('lualine').setup {
  options = {
    theme = 'tokyonight',
    icons_enabled = true,
    globalstatus = true,
  },
}
