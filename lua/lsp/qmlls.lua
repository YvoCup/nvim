-- FILE: lua/lsp/qmlls.lua
-- INFO: LSP config for qmlls
--       qmlls 语言服务器配置

return {
  cmd = { 'qmlls6' },
  filetypes = { 'qml', 'qmljs' },
  root_markers = { '.git' },
}
