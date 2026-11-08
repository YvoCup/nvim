-- FILE: lua/lsp/vtsls.lua
-- INFO: LSP config for vtsls
--       vtsls 语言服务器配置

return {
  cmd = { "vtsls", "--stdio" },
  settings = {
    vtsls = {
      tsserver = {
        globalPlugins = { {
          name = "@vue/typescript-plugin",
          location = "/usr/local/lib/node_modules/@vue/language-server",
          languages = { "javascript", "typescript", "vue" },
        }
        },
      },
    },
  },
  filetypes = { "vue" },
}
