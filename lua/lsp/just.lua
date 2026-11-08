-- FILE: lua/lsp/just.lua
-- INFO: LSP config for Justfiles via just-lsp
--       Justfile 的 just-lsp 语言服务器配置

return {
  cmd = { 'just-lsp' },
  filetypes = { 'just' },
  root_markers = { '.git' },
}
