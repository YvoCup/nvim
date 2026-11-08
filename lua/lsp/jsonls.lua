-- FILE: lua/lsp/jsonls.lua
-- INFO: LSP config for jsonls
--       jsonls 语言服务器配置

return {
  cmd = { "vscode-json-language-server", "--stdio" },
  filetypes = { "json", "jsonc" },
  init_options = {
    provideFormatter = true,
  },
  root_markers = { ".git" },
}
