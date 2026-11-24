-- FILE: lua/lsp/ts_ls.lua
-- INFO: LSP config for ts_ls
--       ts_ls 语言服务器配置

return {
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = {
    "typescript",
    "javascript",
    "javascriptreact",
    "typescriptreact"
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
        -- The old path did not exist; point at Mason like vtsls does.
        -- 原路径不存在；与 vtsls 一致指向 Mason 安装目录。
        location = vim.fn.expand("$HOME/.local/share/nvim/mason/packages/vue-language-server/node_modules/@vue/language-server"),
        languages = { "javascript", "typescript", "vue" },
      },
    },
  },
}

