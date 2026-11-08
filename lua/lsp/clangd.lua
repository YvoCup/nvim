-- FILE: lua/lsp/clangd.lua
-- INFO: LSP config for clangd
--       clangd 语言服务器配置

return {
  cmd = { 'clangd', "--background-index", "--completion-style=detailed"},
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "h", "hpp" },
  root_markers = {
    '.clangd',
    '.clang-tidy',
    '.clang-format',
    'compile_commands.json',
    'compile_flags.txt',
    'configure.ac', -- AutoTools
    '.git',
  },
  capabilities = {
    textDocument = {
      completion = {
        editsNearCursor = true,
      },
    },
    offsetEncoding = { 'utf-8', 'utf-16' },
  },
}
