local opt = vim.opt

-- Encoding
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

-- Searching
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = true

-- Formatting
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true
opt.backspace = "indent,eol,start"
opt.showmatch = true
opt.ambiwidth = "double"
opt.virtualedit:append("block")
opt.formatoptions:append("tcroqnlM1")

-- Completion
opt.wildmenu = true
opt.wildmode = "longest,list"
opt.completeopt = { "menu", "menuone", "noselect" }
opt.clipboard:append("unnamedplus")

-- Files
opt.hidden = true
opt.autoread = true
opt.backup = false
opt.swapfile = false
opt.writebackup = false
opt.directory:prepend(vim.fn.expand("~/.tmp//"))

-- UI
opt.number = true
opt.ruler = true
opt.list = false
opt.wrap = false
opt.cmdheight = 1
opt.showcmd = true
opt.scrolljump = 5
opt.scrolloff = 3
opt.laststatus = 2
opt.showtabline = 2
opt.termguicolors = true
opt.visualbell = true
opt.title = true
opt.titlestring = "Vim: %f %h%r%m"
opt.signcolumn = "yes"

-- Splits
opt.splitright = true
opt.splitbelow = true

-- Timing
opt.updatetime = 250
opt.timeoutlen = 400

-- Folding
opt.foldmethod = "marker"

-- Conceal
if vim.fn.has("conceal") == 1 then
  opt.conceallevel = 1
  opt.concealcursor = ""
end

-- Persistent undo
if vim.fn.has("persistent_undo") == 1 then
  local undodirs = {
    vim.fn.expand("~/.vim/.undo"),
    vim.fn.expand("~/tmp-vim"),
    "/tmp-vim",
  }
  for _, dir in ipairs(undodirs) do
    if vim.fn.isdirectory(dir) == 0 then
      pcall(vim.fn.mkdir, dir, "p")
    end
  end
  opt.undofile = true
  opt.undodir = undodirs
end

-- Wildignore (from vimrc)
opt.wildignore:append({ "*/tmp/*", "*.so", "*.swp", "*.zip", "*.jpg", "*.png" })

-- Fast terminals
opt.ttyfast = true
