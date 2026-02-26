return {
  {
    "marko-cerovac/material.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.material_style = "oceanic"
      local ok = pcall(vim.cmd.colorscheme, "material")
      if not ok then
        vim.cmd.colorscheme("habamax")
      end
    end,
  },
}
