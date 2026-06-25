-- AI assistant (ported from lazy.nvim spec -> vim.pack).
-- https://github.com/yetone/avante.nvim
--
-- NOTE: avante has a native build step (lazy.nvim used `build = 'make'`). We
-- reproduce that with a PackChanged autocmd that runs the build after install or
-- update. `make` (and the toolchain it needs) must be available on your PATH.
require('custom.lib.icons').ensure()

vim.api.nvim_create_autocmd('PackChanged', {
  group = vim.api.nvim_create_augroup('custom-avante-build', { clear = true }),
  callback = function(ev)
    if ev.data.spec.name ~= 'avante.nvim' then
      return
    end
    if ev.data.kind ~= 'install' and ev.data.kind ~= 'update' then
      return
    end
    local cmd = vim.fn.has 'win32' == 1 and { 'powershell', '-ExecutionPolicy', 'Bypass', '-File', 'Build.ps1', '-BuildFromSource', 'false' }
      or { 'make' }
    local result = vim.system(cmd, { cwd = ev.data.path }):wait()
    if result.code ~= 0 then
      vim.notify('avante.nvim build failed:\n' .. (result.stderr or result.stdout or ''), vim.log.levels.ERROR)
    end
  end,
})

-- avante + dependencies. plenary.nvim and telescope.nvim are already installed
-- by the upstream init.lua, so we don't re-add them here.
vim.pack.add {
  'https://github.com/MunifTanjim/nui.nvim',
  'https://github.com/HakonHarnes/img-clip.nvim',
  'https://github.com/MeanderingProgrammer/render-markdown.nvim',
  'https://github.com/yetone/avante.nvim',
}

require('img-clip').setup {
  default = {
    embed_image_as_base64 = false,
    prompt_for_file_name = false,
    drag_and_drop = {
      insert_mode = true,
    },
    use_absolute_path = true,
  },
}

require('render-markdown').setup {
  file_types = { 'markdown', 'Avante' },
}

---@diagnostic disable-next-line: missing-fields
require('avante').setup {
  instructions_file = 'avante.md',
  provider = 'claude',
  providers = {
    claude = {
      endpoint = 'https://api.anthropic.com',
      model = 'claude-sonnet-4-5-20250929',
      timeout = 30000, -- Timeout in milliseconds
      extra_request_body = {
        temperature = 0.75,
        max_tokens = 20480,
      },
    },
  },
}
