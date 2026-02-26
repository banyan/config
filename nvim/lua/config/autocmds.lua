local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local group = augroup("banyan_autocmds", { clear = true })

-- Custom highlights (from vimrc)
vim.api.nvim_set_hl(0, "Pmenu", { ctermfg = 195, ctermbg = 236 })
vim.api.nvim_set_hl(0, "PmenuSel", { ctermfg = 233, ctermbg = 154 })
vim.api.nvim_set_hl(0, "PmenuSbar", { ctermbg = 15 })
vim.api.nvim_set_hl(0, "TabLine", { ctermfg = 162, ctermbg = 253, reverse = true })
vim.api.nvim_set_hl(0, "TabLineSel", { ctermfg = 15, ctermbg = 38, bold = true })
vim.api.nvim_set_hl(0, "TabLineFill", { ctermfg = 162, ctermbg = 162, reverse = true })
vim.api.nvim_set_hl(0, "WhitespaceEOL", { ctermfg = 3, ctermbg = 3 })

-- Remember cursor position
autocmd("BufReadPost", {
  group = group,
  pattern = "*",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Remove trailing whitespace on save
autocmd("BufWritePre", {
  group = group,
  pattern = "*",
  command = ":%s/\\s\\+$//e",
})

-- Set nopaste when leaving insert mode
autocmd("InsertLeave", {
  group = group,
  pattern = "*",
  command = "set nopaste",
})

-- Disable automatic comment insertion
autocmd("FileType", {
  group = group,
  pattern = "*",
  command = "set formatoptions-=ro",
})

-- XML/HTML/ERB complement
autocmd("FileType", {
  group = group,
  pattern = { "xml", "html", "eruby" },
  callback = function()
    vim.keymap.set("i", "</", "</<C-x><C-o>", { buffer = true })
  end,
})

-- Highlight trailing whitespace
autocmd({ "WinEnter", "BufWinEnter" }, {
  group = group,
  pattern = "*",
  callback = function()
    if vim.w._whitespace_match_id == nil then
      vim.w._whitespace_match_id = vim.fn.matchadd("WhitespaceEOL", "\\s\\+$")
    end
  end,
})

-- Highlight full-width spaces
autocmd({ "WinEnter", "BufWinEnter" }, {
  group = group,
  pattern = "*",
  callback = function()
    if vim.w._ideographic_space_match_id == nil then
      vim.w._ideographic_space_match_id = vim.fn.matchadd("IdeographicSpace", vim.fn.nr2char(0x3000))
    end
  end,
})

-- Colorscheme highlights
autocmd("ColorScheme", {
  group = group,
  pattern = "*",
  callback = function()
    vim.api.nvim_set_hl(0, "Pmenu", { ctermfg = 195, ctermbg = 236 })
    vim.api.nvim_set_hl(0, "PmenuSel", { ctermfg = 233, ctermbg = 154 })
    vim.api.nvim_set_hl(0, "PmenuSbar", { ctermbg = 15 })
    vim.api.nvim_set_hl(0, "TabLine", { ctermfg = 162, ctermbg = 253, reverse = true })
    vim.api.nvim_set_hl(0, "TabLineSel", { ctermfg = 15, ctermbg = 38, bold = true })
    vim.api.nvim_set_hl(0, "TabLineFill", { ctermfg = 162, ctermbg = 162, reverse = true })
    vim.api.nvim_set_hl(0, "WhitespaceEOL", { ctermfg = 3, ctermbg = 3 })
    vim.api.nvim_set_hl(0, "IdeographicSpace", { ctermbg = 3, underline = true })
  end,
})

-- Highlight on yank
autocmd("TextYankPost", {
  group = group,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
})

-- Screen title update (tmux/screen)
if vim.env.TERM == "screen" then
  autocmd("BufEnter", {
    group = group,
    pattern = "*",
    callback = function()
      vim.fn.system('echo -n "\027k%\027\\"')
    end,
  })
end
