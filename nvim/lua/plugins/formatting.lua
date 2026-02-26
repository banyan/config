return {
  {
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          javascript = { "prettierd", "prettier" },
          typescript = { "prettierd", "prettier" },
          javascriptreact = { "prettierd", "prettier" },
          typescriptreact = { "prettierd", "prettier" },
          json = { "prettierd", "prettier" },
          jsonc = { "prettierd", "prettier" },
          html = { "prettierd", "prettier" },
          css = { "prettierd", "prettier" },
          scss = { "prettierd", "prettier" },
          markdown = { "prettierd", "prettier" },
        },
        format_on_save = function(bufnr)
          local ft = vim.bo[bufnr].filetype
          local allowed = {
            javascript = true,
            typescript = true,
            javascriptreact = true,
            typescriptreact = true,
            json = true,
            jsonc = true,
            html = true,
            css = true,
            scss = true,
            markdown = true,
          }
          if not allowed[ft] then
            return
          end
          return { timeout_ms = 2000, lsp_fallback = true }
        end,
      })
    end,
  },
}
