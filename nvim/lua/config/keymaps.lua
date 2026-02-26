local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Encoding mappings (from vimrc leader patterns)
keymap("n", "<Leader>ku", ":set fileencoding=utf-8<CR>", opts)
keymap("n", "<Leader>k6", ":set fileencoding=ucs-2le<CR>", opts)
keymap("n", "<Leader>ke", ":set fileencoding=euc-jp<CR>", opts)
keymap("n", "<Leader>ks", ":set fileencoding=cp932<CR>", opts)
keymap("n", "<Leader>kj", ":set fileencoding=iso-2022-jp<CR>", opts)
keymap("n", "<Leader>kn", ":set fileformat=unix<CR>", opts)
keymap("n", "<Leader>kr", ":set fileformat=mac<CR>", opts)
keymap("n", "<Leader>krn", ":set fileformat=dos<CR>", opts)

keymap("n", "<Leader>ru", ":e ++enc=utf-8<CR>", opts)
keymap("n", "<Leader>r6", ":e ++enc=ucs-2le<CR>", opts)
keymap("n", "<Leader>re", ":e ++enc=euc-jp<CR>", opts)
keymap("n", "<Leader>rs", ":e ++enc=cp932<CR>", opts)
keymap("n", "<Leader>rj", ":e ++enc=iso-2022-jp<CR>", opts)
keymap("n", "<Leader>rn", ":e ++fileformat=unix<CR>", opts)
keymap("n", "<Leader>rr", ":e ++fileformat=mac<CR>", opts)
keymap("n", "<Leader>rrn", ":e ++fileformat=dos<CR>", opts)

-- Search mappings
keymap("n", "<Space>l", ":nohlsearch<CR><C-L>", opts)
keymap("n", "n", "nzz", opts)
keymap("n", "N", "Nzz", opts)
keymap("n", "*", "*zz", opts)
keymap("n", "#", "#zz", opts)
keymap("n", "g*", "g*zz", opts)
keymap("n", "g#", "g#zz", opts)

-- Basic mappings
keymap("n", "<Space>w", ":w<CR>", opts)
keymap("n", "<Space>a", ":qa!<CR>", opts)
keymap("n", "<Space>c", ":q<CR>", opts)
keymap("n", "0", "^", opts)
keymap("n", "9", "$", opts)
keymap("n", "Y", "y$", opts)
keymap("n", "y1", "y^", opts)
keymap("n", "y0", "y$", opts)
keymap({ "n", "v" }, "j", "gj", opts)
keymap({ "n", "v" }, "k", "gk", opts)

-- Toggle options
keymap("n", "<Space>n", function()
  vim.wo.number = not vim.wo.number
end, opts)
keymap("n", "<Space>p", ":setlocal paste!<CR>", opts)
keymap("n", "<Space>i", ":IndentGuidesToggle<CR>", opts)

-- Window management
keymap("n", "ss", "<C-W>s", opts)
keymap("n", "sv", "<C-W>v", opts)
keymap("n", "sn", "<C-W>n", opts)
keymap("n", "sc", "<C-W>c", opts)
keymap("n", "sq", "<C-W>q", opts)
keymap("n", "sQ", "<C-W>q!", opts)
keymap("n", "so", "<C-W>o", opts)
keymap("n", "sT", "<C-w>T", opts)
keymap("n", "sR", "<C-w>R", opts)
keymap("n", "sh", "<C-W>h", opts)
keymap("n", "sj", "<C-W>j", opts)
keymap("n", "sk", "<C-W>k", opts)
keymap("n", "sl", "<C-W>l", opts)
keymap("n", "s<SPACE>h", "<C-W>18>", opts)
keymap("n", "s<SPACE>j", "<C-W>18+", opts)
keymap("n", "s<SPACE>k", "<C-W>18-", opts)
keymap("n", "s<SPACE>l", "<C-W>18<", opts)
keymap("n", "sH", "<C-w>H", opts)
keymap("n", "sJ", "<C-w>J", opts)
keymap("n", "sK", "<C-w>K", opts)
keymap("n", "sL", "<C-w>L", opts)
keymap("n", "s<CR>", function()
  vim.cmd("wincmd _ | wincmd |")
end, opts)
keymap("n", "s.", "<C-W>=", opts)
keymap("n", "s=", "<C-W>=", opts)

-- Tab management
keymap("n", "<S-t>", ":tab ", opts)
keymap("n", "<Leader>tc", ":tabnew<Space>", opts)
keymap("n", "<Leader>tn", ":tabnext<CR>", opts)
keymap("n", "<Leader>tp", ":tabprevious<CR>", opts)
keymap("n", "<Leader>td", ":tabclose<CR>", opts)
keymap("n", "<Leader>ts", ":tabs<CR>", opts)
keymap("n", "<Leader>te", ":tabedit<CR>", opts)
keymap("n", "<Leader>tb", ":tab ball<CR>", opts)

-- Misc
keymap("i", "<C-u>", "<C-g>u<C-u>", opts)
keymap("n", "<Space>wtf", "oputs \"#\" * 90<c-m>puts caller<c-m>puts \"#\" * 90<esc>", opts)

-- Quickfix toggle
keymap("n", ",c", ":QFix<CR>", opts)

-- Highlight current line
keymap("n", ",ha", ":HighlightCurrentLine Search<CR>", opts)
keymap("n", ",hb", ":HighlightCurrentLine DiffAdd<CR>", opts)
keymap("n", ",hc", ":HighlightCurrentLine Error<CR>", opts)
keymap("n", ",H", ":UnHighlightCurrentLine<CR>", opts)

-- Command-line escape mappings
keymap("c", "/", function()
  return vim.fn.getcmdtype() == "/" and "\\/" or "/"
end, { expr = true })
keymap("c", "?", function()
  return vim.fn.getcmdtype() == "?" and "\\?" or "?"
end, { expr = true })

-- Diagnostics
keymap("n", "[d", vim.diagnostic.goto_prev, opts)
keymap("n", "]d", vim.diagnostic.goto_next, opts)
keymap("n", "<Leader>dl", vim.diagnostic.setloclist, opts)
