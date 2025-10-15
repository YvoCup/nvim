-- 插件
require("lazy-init")

-- 把 lua/core、lua/lsp、lua/dap 全拉进来
for _, dir in ipairs { 'core', 'lsp', 'dap' } do
  for _, f in ipairs(vim.fn.readdir(vim.fn.stdpath('config')..'/lua/'..dir, [[v:val =~ '\.lua$']])) do
    require(dir .. '.' .. f:gsub('%.lua$', ''))
  end
end
