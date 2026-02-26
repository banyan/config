-- banyan's init.lua
-- Migrated from ~/.vimrc with modern Neovim best practices

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Core config
require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.commands")
require("config.filetypes")

-- Plugins
require("lazy").setup("plugins", {
  checker = { enabled = true },
  change_detection = { notify = false },
})

-- Load local overrides if present
local local_config = vim.fn.expand("~/.config/nvim/local.lua")
if vim.fn.filereadable(local_config) == 1 then
  dofile(local_config)
end
