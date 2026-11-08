-- FILE: lua/plugins/mason.lua
-- INFO: LSP/tool installer UI
--       LSP/工具安装器

return {
  "mason-org/mason.nvim",
  ---------------------------------------------------- config ----------------------------------------------------------
  config = function()
    require("mason").setup({
      ui = {
        width = 0.618,
        height = 0.9,
        border = "rounded",
        backdrop = 100,
        icons = {
          package_installed   = "✓",   -- Installed | 已安装
          package_pending     = "➜",   -- Pending | 安装中
          package_uninstalled = "✗",   -- Not installed | 未安装
        },
      },
    })
  end
}

