-- FILE: lua/lsp/vtsls.lua
-- INFO: LSP config for vtsls
--       vtsls 语言服务器配置

return {
  cmd = { "vtsls", "--stdio" },
  -- Without root_markers vtsls attaches with root_dir=nil; tsserver then has no
  -- project context and TS features inside .vue <script> silently die.
  -- 缺少 root_markers 时 vtsls 以 root_dir=nil 附着，tsserver 无工程上下文，
  -- .vue 脚本区的 TS 能力会静默失效。
  root_markers = { 'tsconfig.json', 'jsconfig.json', 'package.json', '.git' },
  settings = {
    vtsls = {
      tsserver = {
        globalPlugins = { {
          name = "@vue/typescript-plugin",
          location = vim.fn.expand("$HOME/.local/share/nvim/mason/packages/vue-language-server/node_modules/@vue/language-server"),
          languages = { "javascript", "typescript", "vue" },
          -- Required by the official vuejs docs: without these the plugin is
          -- skipped when tsserver uses the workspace TypeScript, and vue
          -- completions in <script> silently return empty.
          -- vuejs 官方文档要求的两个字段：缺失时一旦 tsserver 使用工作区
          -- TypeScript，插件会被跳过，<script> 内补全会静默返回空。
          configNamespace = "typescript",
          enableForWorkspaceTypeScriptVersions = true,
        }
        },
      },
    },
  },
  filetypes = { "vue" },
}
