return {
  "stevearc/oil.nvim",
  dependencies = {
    "nvim-mini/mini.icons",
    "nvim-tree/nvim-web-devicons",
  },
  lazy = true,
  config = function()
    require("oil").setup({
      columns = {
        "icon",
        "permissions",
        "size",
      },
      cleanup_delay_ms = false,
    })
  end
}
