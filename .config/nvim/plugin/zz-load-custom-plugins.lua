-- Load everything under lua/custom/plugins/ WITHOUT modifying init.lua.
--
-- Neovim sources files in a config's `plugin/` directory automatically, right
-- after init.lua finishes. This is the equivalent of uncommenting the
-- `require 'custom.plugins'` line at the end of init.lua, but it keeps init.lua
-- pristine so upstream updates stay conflict-free.
require 'custom.plugins'
