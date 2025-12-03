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

