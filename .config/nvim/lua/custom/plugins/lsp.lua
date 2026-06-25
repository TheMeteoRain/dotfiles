-- Extra language servers (ported from the previous config).
--
-- The upstream init.lua already configures `lua_ls` (+ stylua) and registers
-- blink.cmp capabilities globally, so we only ADD servers here. `vim.lsp.config`
-- deep-merges across calls, so the `lua_ls` block below augments — not replaces —
-- the upstream one.

local vue_language_server_path =
  vim.fn.expand(vim.fn.stdpath 'data' .. '/mason/packages/vue-language-server/node_modules/@vue/language-server')

local vue_plugin = {
  name = '@vue/typescript-plugin',
  location = vue_language_server_path,
  languages = { 'vue' },
  configNamespace = 'typescript',
}

-- Go
vim.lsp.config('gopls', {})

-- Augment upstream lua_ls with snippet-completion replacement.
vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      completion = { callSnippet = 'Replace' },
    },
  },
})

-- CSS: don't warn about unknown at-rules (e.g. Tailwind's @apply).
vim.lsp.config('cssls', {
  settings = {
    css = {
      lint = { unknownAtRules = 'ignore' },
    },
  },
})

-- Vue + TypeScript "hybrid mode": vtsls runs the TS server with the Vue plugin,
-- and vue_ls handles .vue files. Use ONE TS server (vtsls) — not ts_ls as well.
vim.lsp.config('vtsls', {
  settings = {
    vtsls = {
      tsserver = {
        globalPlugins = { vue_plugin },
      },
    },
  },
  filetypes = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'vue' },
})

vim.lsp.config('vue_ls', {})

for _, server in ipairs { 'gopls', 'lua_ls', 'cssls', 'vtsls', 'vue_ls' } do
  vim.lsp.enable(server)
end

-- Ensure Mason installs the servers + formatters we rely on. (Re-running setup
-- is fine; we include the upstream tools so they aren't dropped.)
require('mason-tool-installer').setup {
  ensure_installed = {
    -- upstream tools
    'stylua',
    'lua-language-server',
    -- added language servers
    'gopls',
    'vtsls',
    'vue-language-server',
    'css-lsp',
    -- formatters (see formatting.lua)
    'prettierd',
    'prettier',
    'goimports',
    'taplo',
    'biome',
    'ruff',
    'black',
  },
}
