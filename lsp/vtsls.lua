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
