-- Custom user commands from vimrc

local function toggle_quickfix()
  for _, win in ipairs(vim.fn.getwininfo()) do
    if win.quickfix == 1 then
      vim.cmd("cclose")
      return
    end
  end
  vim.cmd("copen")
end

vim.api.nvim_create_user_command("QFix", toggle_quickfix, {})

vim.api.nvim_create_user_command("Rename", function(opts)
  local old_name = vim.fn.expand("%:p")
  local new_name = vim.fn.expand(opts.args)
  if old_name == "" or new_name == "" then
    return
  end
  vim.cmd("saveas " .. new_name)
  vim.fn.delete(old_name)
end, { nargs = 1, complete = "file" })

vim.api.nvim_create_user_command("New", function(opts)
  local file = opts.args
  local dir = vim.fn.fnamemodify(file, ":h")
  if vim.fn.isdirectory(dir) == 0 then
    vim.fn.mkdir(dir, "p")
  end
  vim.cmd("edit " .. file)
end, { nargs = 1, complete = "file" })

vim.api.nvim_create_user_command("Code", function()
  vim.fn.system("code '" .. vim.fn.expand("%:p") .. "'")
  vim.cmd("redraw!")
end, {})

vim.api.nvim_create_user_command("EV", "edit $MYVIMRC", {})
vim.api.nvim_create_user_command("RV", "source $MYVIMRC", {})

vim.api.nvim_create_user_command("GitBrowseRemote", function(opts)
  local range = ""
  if opts.range > 0 then
    range = string.format("-L%d,%d", opts.line1, opts.line2)
  end
  local args = opts.args or ""
  local cmd = string.format("git browse-remote --rev %s %s -- %%", range, args)
  vim.fn.system(cmd)
end, { nargs = "*", range = true })

vim.api.nvim_create_user_command("HighlightCurrentLine", function(opts)
  local line = vim.fn.line(".")
  vim.cmd(string.format("match %s /\\%%%dl/", opts.args, line))
end, { nargs = 1 })

vim.api.nvim_create_user_command("UnHighlightCurrentLine", function()
  vim.cmd("match")
end, {})

vim.api.nvim_create_user_command("IndentGuidesToggle", function()
  if vim.fn.exists(":IblToggle") == 2 then
    vim.cmd("IblToggle")
    return
  end
  if vim.fn.exists(":IndentBlanklineToggle") == 2 then
    vim.cmd("IndentBlanklineToggle")
    return
  end
  local ok, ibl = pcall(require, "ibl")
  if ok and ibl.toggle then
    ibl.toggle()
  end
end, {})

-- command-line abbreviations
vim.cmd("cmap w!! w !sudo tee % >/dev/null")
vim.cmd("cabbrev code Code")
