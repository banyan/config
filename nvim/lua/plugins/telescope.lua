return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
    keys = {
      {
        "<Leader>ff",
        function()
          require("telescope.builtin").find_files()
        end,
        desc = "Find files",
      },
      {
        "<Leader>fg",
        function()
          require("telescope.builtin").live_grep()
        end,
        desc = "Live grep",
      },
      {
        "<Leader>fb",
        function()
          require("telescope.builtin").buffers()
        end,
        desc = "Buffers",
      },
      {
        "<Leader>fh",
        function()
          require("telescope.builtin").help_tags()
        end,
        desc = "Help tags",
      },
      {
        "<Leader>fo",
        function()
          require("telescope.builtin").oldfiles()
        end,
        desc = "Recent files",
      },
      {
        "<C-j><C-p>",
        function()
          require("telescope.builtin").find_files()
        end,
        desc = "Find files (legacy)",
      },
      {
        "<C-j><C-i>",
        function()
          local cwd = vim.fn.expand("%:p:h")
          require("telescope.builtin").find_files({ cwd = cwd })
        end,
        desc = "Find files in buffer dir (legacy)",
      },
      {
        "<C-j><C-j>",
        function()
          require("telescope.builtin").buffers()
        end,
        desc = "Buffers (legacy)",
      },
      {
        "<C-j><C-m>",
        function()
          require("telescope.builtin").oldfiles()
        end,
        desc = "Recent files (legacy)",
      },
      {
        "<C-j><C-k>",
        function()
          require("telescope.builtin").find_files({ cwd = vim.fn.getcwd() })
        end,
        desc = "Find files in cwd (legacy)",
      },
      {
        "<C-h>",
        function()
          require("telescope.builtin").live_grep()
        end,
        desc = "Search (legacy CtrlSF)",
      },
    },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          prompt_prefix = "> ",
          selection_caret = "> ",
        },
      })
      pcall(telescope.load_extension, "fzf")
    end,
  },
}
