-- File explorer (ported from lazy.nvim spec -> vim.pack).
-- https://github.com/nvim-tree/nvim-tree.lua
require('custom.lib.icons').ensure()

vim.pack.add { 'https://github.com/nvim-tree/nvim-tree.lua' }

require('nvim-tree').setup {
  filters = { dotfiles = false },
  disable_netrw = true,
  hijack_cursor = true,
  sync_root_with_cwd = true,
  update_focused_file = {
    enable = true,
    update_root = false,
  },
  view = {
    width = 30,
    preserve_window_proportions = true,
  },
  renderer = {
    root_folder_label = false,
    highlight_git = true,
    indent_markers = { enable = true },
  },
}

vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<CR>', { desc = 'Open file [E]xplorer' })
