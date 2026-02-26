return {
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup({
        options = {
          theme = "auto",
          icons_enabled = true,
          globalstatus = false,
        },
      })
    end,
  },
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("bufferline").setup({
        options = {
          diagnostics = "nvim_lsp",
          separator_style = "slant",
        },
      })
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<Leader>e", ":NvimTreeToggle<CR>", desc = "File tree" },
    },
    config = function()
      require("nvim-tree").setup({
        view = {
          width = 32,
        },
        renderer = {
          highlight_git = true,
          icons = { show = { git = true } },
        },
        git = {
          enable = true,
        },
        filters = {
          dotfiles = false,
        },
        respect_buf_cwd = true,
      })
    end,
  },
  {
    "rcarriga/nvim-notify",
    config = function()
      local notify = require("notify")
      notify.setup({
        timeout = 2000,
        stages = "fade",
      })
      vim.notify = notify
    end,
  },
  {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup({})
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      require("ibl").setup({
        indent = { char = "|" },
        scope = { enabled = false },
      })
    end,
  },
}
