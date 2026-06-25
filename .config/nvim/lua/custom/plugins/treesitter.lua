-- Extra Treesitter parsers (ported from the previous config).
--
-- The upstream config (nvim-treesitter `main` branch) auto-installs parsers on
-- demand when you open a matching file, but we install these eagerly so web
-- files are highlighted immediately on first open.
local ok, ts = pcall(require, 'nvim-treesitter')
if ok and type(ts.install) == 'function' then
  ts.install { 'vue', 'css', 'javascript', 'typescript' }
end
