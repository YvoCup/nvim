-- FILE: lua/plugins/restart.lua
-- INFO: Restart nvim from inside
--       重启 nvim

return {
  "nazo6/restart.nvim",
  ----------------------------------------------------- keys -----------------------------------------------------------
  keys = {
    {
      mode = "n",
      "<leader>r",
      "<cmd>restart<cr>",
      desc = "restart nvim | 重启 nvim"
    }
  }
}

