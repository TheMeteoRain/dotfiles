-- Cursor-jump flash highlight (briefly flares the cursor after a big jump).
-- https://github.com/stonelasley/flare.nvim
vim.pack.add { 'https://github.com/stonelasley/flare.nvim' }

-- Sensible defaults out of the box; tweak here if the flash is too much / little
-- (e.g. `fade = false` for a flash instead of a fade, or raise the *_threshold
-- values so it only triggers on larger jumps).
require('flare').setup()
