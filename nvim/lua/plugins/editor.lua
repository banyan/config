return {
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup({
        mappings = {
          basic = false,
          extra = false,
        },
      })
      vim.keymap.set("n", ",x", "<Plug>(comment_toggle_linewise_current)")
      vim.keymap.set("v", ",x", "<Plug>(comment_toggle_linewise_visual)")
      vim.keymap.set("n", ",s", "<Plug>(comment_toggle_linewise_current)")
      vim.keymap.set("v", ",s", "<Plug>(comment_toggle_linewise_visual)")
      vim.keymap.set("n", ",m", "<Plug>(comment_toggle_blockwise_current)")
      vim.keymap.set("v", ",m", "<Plug>(comment_toggle_blockwise_visual)")
      vim.keymap.set("n", ",ad", "<Plug>(comment_toggle_linewise_current)")
      vim.keymap.set("v", ",ad", "<Plug>(comment_toggle_linewise_visual)")
      vim.keymap.set("n", ",al", "<Plug>(comment_toggle_linewise_current)")
      vim.keymap.set("v", ",al", "<Plug>(comment_toggle_linewise_visual)")
      vim.keymap.set("n", ",ab", "<Plug>(comment_toggle_linewise_current)")
      vim.keymap.set("v", ",ab", "<Plug>(comment_toggle_linewise_visual)")
    end,
  },
  {
    "junegunn/vim-easy-align",
    config = function()
      vim.keymap.set("v", "<Leader>h=", "<Plug>(EasyAlign)=")
      vim.keymap.set("v", "<Leader>h,", "<Plug>(EasyAlign),")
      vim.keymap.set("v", "<Leader>h:", "<Plug>(EasyAlign):")
      vim.keymap.set("v", "<Leader>h\"", "<Plug>(EasyAlign)\"")
      vim.keymap.set("v", "<Leader>h'", "<Plug>(EasyAlign)'")
    end,
  },
  { "tpope/vim-endwise" },
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup()
    end,
  },
  {
    "kylechui/nvim-surround",
    version = "*",
    config = function()
      require("nvim-surround").setup()
    end,
  },
  {
    "gbprod/yanky.nvim",
    config = function()
      require("yanky").setup({})
      vim.keymap.set("n", "sy", "<Plug>(YankyYank)")
      vim.keymap.set("n", "sp", "<Plug>(YankyPutAfter)")
      vim.keymap.set("n", "sP", "<Plug>(YankyPutBefore)")
    end,
  },
  { "thinca/vim-visualstar" },
  {
    "yegappan/mru",
    config = function()
      vim.g.MRU_Max_Entries = 25
    end,
  },
  { "banyan/recognize_charcode.vim" },
  {
    "y3owk1n/undo-glow.nvim",
    event = { "BufReadPost" },
    config = function()
      require("undo-glow").setup()
    end,
  },
}
