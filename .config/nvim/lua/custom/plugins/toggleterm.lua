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

local Terminal = require('toggleterm.terminal').Terminal

-- Project root for the current buffer. Walks up from the file looking for common
-- project markers; falls back to the file's directory, then the cwd.
local root_markers = {
  '.git',
  '.hg',
  '.svn',
  'package.json',
  'Cargo.toml',
  'go.mod',
  'pyproject.toml',
  'Makefile',
  'nvim-pack-lock.json',
}
local function get_project_root()
  local file = vim.api.nvim_buf_get_name(0)
  -- Try project root, then the file's own dir, then cwd. Some buffers carry
  -- scheme-style names (term://, oil://, ...) or live in not-yet-created dirs,
  -- so each candidate must be confirmed to be a real directory before use --
  -- termopen rejects anything that isn't, which is what blew up before.
  local candidates = {
    vim.fs.root(0, root_markers),
    file ~= '' and vim.fs.dirname(file) or nil,
    vim.uv.cwd(),
  }
  for _, dir in ipairs(candidates) do
    if dir and dir ~= '' then
      dir = vim.fn.fnamemodify(dir, ':p')
      if vim.fn.isdirectory(dir) == 1 then return dir end
    end
  end
  return vim.uv.cwd()
end

-- Per-project terminal cache: terminals[root][key] = Terminal instance.
-- Each project keeps its own set, so jumping between projects preserves each
-- project's sessions instead of dragging one shared terminal everywhere.
local terminals = {}
local next_count = 0

-- Fetch (or lazily build) the terminal identified by `key` for the current
-- project root. `opts` overrides the per-terminal defaults at creation time.
local function get_terminal(key, opts)
  local root = get_project_root() or '.'
  terminals[root] = terminals[root] or {}
  local term = terminals[root][key]
  if not term then
    next_count = next_count + 1
    term = Terminal:new(vim.tbl_extend('force', {
      count = next_count, -- globally unique so toggleterm never collides
      dir = root,
      hidden = true,
      close_on_exit = true,
      float_opts = { border = 'rounded' },
    }, opts or {}))
    terminals[root][key] = term
  end
  return term
end

-- Returns a function that toggles the project's `key` terminal in `direction`.
local function toggler(key, direction, opts)
  return function()
    -- If we're already focused inside a toggleterm terminal, just toggle THAT
    -- one closed. Resolving a project root from a term:// buffer would key a
    -- different (bogus) terminal and try to spawn it -- the toggle-off crash.
    local num = vim.b.toggle_number
    if num then
      local current = require('toggleterm.terminal').get(num, true)
      if current then
        current:toggle()
        return
      end
    end
    get_terminal(key, vim.tbl_extend('force', { direction = direction }, opts or {})):toggle()
  end
end

local map = vim.keymap.set
-- main toggle
map('n', '<leader>tt', toggler('float', 'float'), { desc = 'Toggle Terminal (project)' })
-- specific layouts
-- NOTE: <leader>th is also the LSP "Toggle Inlay Hints" mapping, but that one is
-- buffer-local and only active in buffers with an attached LSP, so this global
-- mapping wins everywhere else.
map('n', '<leader>th', toggler('horizontal', 'horizontal'), { desc = 'Horizontal Terminal (project)' })
map('n', '<leader>tv', toggler('vertical', 'vertical'), { desc = 'Vertical Terminal (project)' })
-- numbered terminals (per project)
map('n', '<leader>t1', toggler('1', 'horizontal'), { desc = 'Terminal 1 (project)' })
map('n', '<leader>t2', toggler('2', 'horizontal'), { desc = 'Terminal 2 (project)' })
map('n', '<leader>t3', toggler('3', 'horizontal'), { desc = 'Terminal 3 (project)' })
-- close all open floats (keeps their sessions alive)
map('n', '<leader>tq', function()
  for _, term in ipairs(require('toggleterm.terminal').get_all(true)) do
    if term.direction == 'float' then term:close() end
  end
end, { desc = 'Close all float terminals' })
-- persistent named floats (per project)
map('n', '<leader>tg', toggler('lazygit', 'float', { cmd = 'lazygit' }), { desc = 'LazyGit (project)' })
map(
  'n',
  '<leader>tc',
  toggler('claude', 'float', { cmd = 'claude --continue 2>/dev/null || claude', close_on_exit = false }),
  { desc = 'Claude terminal (project)' }
)
