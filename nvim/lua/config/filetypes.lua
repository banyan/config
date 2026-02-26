local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local group = augroup("banyan_filetypes", { clear = true })

local filetype_settings = {
  apache = { sw = 4, sts = 4, ts = 4, et = true },
  aspvbs = { sw = 4, sts = 4, ts = 4, et = false },
  c = { sw = 4, sts = 4, ts = 4, et = true },
  cpp = { sw = 4, sts = 4, ts = 4, et = true },
  cs = { sw = 4, sts = 4, ts = 4, et = true },
  css = { sw = 4, sts = 4, ts = 4, et = false },
  diff = { sw = 4, sts = 4, ts = 4, et = false },
  html = { sw = 2, sts = 2, ts = 2, et = true },
  java = { sw = 4, sts = 4, ts = 4, et = true },
  javascript = { sw = 2, sts = 2, ts = 2, et = true },
  typescript = { sw = 2, sts = 2, ts = 2, et = true },
  perl = { sw = 4, sts = 4, ts = 4, et = true },
  php = { sw = 4, sts = 4, ts = 4, et = true },
  python = { sw = 4, sts = 4, ts = 4, et = true },
  ruby = { sw = 2, sts = 2, ts = 2, et = true },
  haml = { sw = 2, sts = 2, ts = 2, et = true },
  jade = { sw = 2, sts = 2, ts = 2, et = true },
  scss = { sw = 2, sts = 2, ts = 2, et = true },
  slim = { sw = 2, sts = 2, ts = 2, et = true },
  handlebars = { sw = 2, sts = 2, ts = 2, et = true },
  hbs = { sw = 2, sts = 2, ts = 2, et = true },
  eruby = { sw = 2, sts = 2, ts = 2, et = true },
  sh = { sw = 4, sts = 4, ts = 4, et = true },
  sql = { sw = 4, sts = 4, ts = 4, et = true },
  vb = { sw = 4, sts = 4, ts = 4, et = false },
  vim = { sw = 2, sts = 2, ts = 2, et = true },
  wsh = { sw = 4, sts = 4, ts = 4, et = true },
  xhtml = { sw = 2, sts = 2, ts = 2, et = false },
  xml = { sw = 4, sts = 4, ts = 4, et = false },
  yaml = { sw = 2, sts = 2, ts = 2, et = true },
  zsh = { sw = 4, sts = 4, ts = 4, et = true },
  scala = { sw = 2, sts = 2, ts = 2, et = true },
  coffee = { sw = 2, sts = 2, ts = 2, et = true },
}

for ft, settings in pairs(filetype_settings) do
  autocmd("FileType", {
    group = group,
    pattern = ft,
    callback = function()
      vim.opt_local.shiftwidth = settings.sw
      vim.opt_local.softtabstop = settings.sts
      vim.opt_local.tabstop = settings.ts
      vim.opt_local.expandtab = settings.et
    end,
  })
end
