-- FILE: init.lua
-- INFO: Entry point: loads core -> lsp-init -> lazy-init
--       入口：加载 core -> lsp-init -> lazy-init

local function load_lua_modules(subdir)
  -- 拼接完整路径：~/.config/nvim/lua/<subdir>
  local path = vim.fn.stdpath('config') .. '/lua/' .. subdir

  -- 扫描目录下所有 .lua 文件
  local files = vim.fn.readdir(path, [[v:val =~ '\.lua$']])

  -- 依次 require
  for _, f in ipairs(files) do
    local name = f:gsub('%.lua$', '') -- 去掉扩展名
    require(subdir .. '.' .. name)
  end
end

load_lua_modules("core")
require("lsp-init")  -- lsp
require("lazy-init") -- 插件
