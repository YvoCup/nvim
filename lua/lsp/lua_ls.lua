-- FILE: lua/lsp/lua_ls.lua
-- INFO: Lua LSP; runs with zh-cn locale
--       Lua 语言服务器；使用中文 locale 启动

return {
  cmd = { "lua-language-server", "--locale=zh-cn" },
  filetypes = { "lua" },
  settings = {
    Lua = {
      hover = {
        enumsLimit = 100,
        previewFields = 100,
        border = "rounded"
      },
      codeLens    = { enable = true },
      hint        = { enable = true, semicolon = 'Disable' },
      telemetry   = { enable = false },
      diagnostics = {
        globals = { "vim" },   -- 忽略全局 vim 未定义
      },
    },
  },
  root_markers = {
    ".luarc.json",
    ".luarc.jsonc",
    ".luacheckrc",
    ".stylua.toml",
    "stylua.toml",
    "selene.toml",
    "selene.yml",
    ".git",
  },
}

