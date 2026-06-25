-- Per-filetype formatters (ported from the previous config).
--
-- We merge into conform's live `formatters_by_ft` table rather than calling
-- `setup()` again, so the upstream `format_on_save` / `default_format_opts`
-- behaviour configured in init.lua is preserved.
local conform = require 'conform'

conform.formatters_by_ft = vim.tbl_extend('force', conform.formatters_by_ft or {}, {
  css = { 'prettierd', 'prettier', stop_after_first = true },
  html = { 'prettierd', 'prettier', stop_after_first = true },
  vue = { 'prettierd', 'prettier', stop_after_first = true },
  javascript = { 'prettierd', 'prettier', stop_after_first = true },
  typescript = { 'prettierd', 'prettier', stop_after_first = true },
  javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
  typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
  go = { 'goimports', 'gofmt', stop_after_first = true },
  toml = { 'taplo' },
  markdown = { 'prettier' },
  python = { 'ruff_format', 'black', stop_after_first = true },
  json = { 'biome', 'prettier', stop_after_first = true },
})
