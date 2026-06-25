-- Scrollbar in the gutter with search-match and git-change markers.
-- https://github.com/petertriho/nvim-scrollbar
-- nvim-hlslens is required for the search handler (scrollbar has no standalone
-- search integration); it also adds a floating match-count next to results.
-- https://github.com/kevinhwang91/nvim-hlslens
vim.pack.add {
  'https://github.com/kevinhwang91/nvim-hlslens',
  'https://github.com/petertriho/nvim-scrollbar',
}

require('scrollbar').setup {
  handlers = {
    cursor = true,
    diagnostic = true,
    gitsigns = true, -- registered by the gitsigns handler below; uses existing gitsigns
    handle = true,
    search = true,   -- registered by the search handler below; needs hlslens
  },
}

-- hlslens must be enabled (this registers its / and ? autocmds and renders
-- matches); without it the scrollbar search hook never fires. Call it BEFORE
-- the scrollbar search handler, which then overrides hlslens' build_position_cb.
require('hlslens').setup()

-- Search matches on the scrollbar (drives, and is driven by, nvim-hlslens).
require('scrollbar.handlers.search').setup()

-- Git added/changed/removed markers on the scrollbar (reuses init.lua's gitsigns).
require('scrollbar.handlers.gitsigns').setup()

-- Remap search-motion keys through hlslens so the markers (and match count)
-- refresh as you jump between results. `<Esc>` -> :nohlsearch (set in init.lua)
-- still clears everything.
local kopts = { noremap = true, silent = true }
vim.keymap.set('n', 'n', [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]], kopts)
vim.keymap.set('n', 'N', [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]], kopts)
vim.keymap.set('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
vim.keymap.set('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
vim.keymap.set('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
vim.keymap.set('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)
