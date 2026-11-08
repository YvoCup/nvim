-- FILE: ./lua/plugins/restart.lua
-- INFO: restart nvim.
--       重启 nvim 的功能。
return {
  "nazo6/restart.nvim",
  ------------------------------------------------------ keymaps -------------------------------------------------------
  keys = {
    {
      mode = "n",
      "<leader>r",
      "<cmd>restart<cr>",
      desc = "restart nvim configs. 重启 nvim 配置"
    }
  }
}

