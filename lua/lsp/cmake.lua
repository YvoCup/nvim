-- FILE: lua/lsp/cmake.lua
-- INFO: LSP config for cmake
--       cmake 语言服务器配置

return {
  cmd = { 'cmake-language-server' },
  filetypes = { 'cmake' },
  root_markers = { 'CMakePresets.json', 'CTestConfig.cmake', '.git', 'build', 'cmake' },
  init_options = {
    buildDirectory = 'build',
  },
}

