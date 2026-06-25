-- Idempotent Nerd Font icon setup for the custom plugins.
--
-- The upstream init.lua only initialises mini.icons when `vim.g.have_nerd_font`
-- is true *at the moment SECTION 4 runs*. Because our customizations live in the
-- `custom` dir (which loads after init.lua), we enable the Nerd Font and set the
-- icons up here instead. Calling `ensure()` repeatedly is safe.
local M = {}
local done = false

function M.ensure()
  if done then
    return
  end
  done = true

  vim.g.have_nerd_font = true

  local ok, mini_icons = pcall(require, 'mini.icons')
  if ok then
    mini_icons.setup()
    -- Backwards compatibility shim so plugins that `require('nvim-web-devicons')`
    -- (nvim-tree, bufferline, lualine, ...) get mini.icons instead.
    if _G.MiniIcons then
      MiniIcons.mock_nvim_web_devicons()
    end
  end
end

return M
