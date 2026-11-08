-- FILE: lua/lsp/neocmake.lua
-- INFO: LSP config for neocmake
--       neocmake 语言服务器配置

return {
  cmd = { 'neocmakelsp', 'stdio' },
  filetypes = { 'cmake' },
  root_markers = { "build", "cmake", ".git" },
  init_options = {
    lint = {
      enable = false
    }
  }
}

