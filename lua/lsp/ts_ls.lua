-- FILE: lua/lsp/ts_ls.lua
-- INFO: LSP config for ts_ls
--       ts_ls 语言服务器配置

return {
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = {
    "typescript",
    "javascript",
    "javascriptreact",
    "typescriptreact",
    "vue"
  },
  root_markers = {
    'tsconfig.json',
    'jsconfig.json',
    'package.json',
    '.git'
  },
  single_file_support = true,
  init_options = {
    hostInfo = 'neovim',
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location = "/usr/local/lib/node_modules/@vue/language-server",
        languages = { "javascript", "typescript", "vue" },
      },
    },
  },
}

