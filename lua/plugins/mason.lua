return {
  "mason-org/mason.nvim",
  config = function()
    require("mason").setup({
      ui = {
        width = 0.618,
        height = 0.9,
        border = "rounded",
        backdrop = 100,
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })
  end
}

