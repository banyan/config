local plugins = {}

local function extend(list)
  for _, item in ipairs(list) do
    table.insert(plugins, item)
  end
end

extend(require("plugins.colors"))
extend(require("plugins.lsp"))
extend(require("plugins.cmp"))
extend(require("plugins.formatting"))
extend(require("plugins.telescope"))
extend(require("plugins.treesitter"))
extend(require("plugins.ui"))
extend(require("plugins.git"))
extend(require("plugins.editor"))

return plugins
