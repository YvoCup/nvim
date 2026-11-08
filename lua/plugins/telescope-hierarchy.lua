-- FILE: lua/plugins/telescope-hierarchy.lua
-- INFO: LSP call hierarchy via telescope
--       telescope 的 LSP 调用层级

return {
  "jmacadie/telescope-hierarchy.nvim",
  ----------------------------------------------------- keys -----------------------------------------------------------
  keys = {
    {
      mode = "n",
      "gu",
      "<cmd>Telescope hierarchy incoming_calls<cr>",
      desc = "incoming calls | 入向调用"
    },
    {
      mode = "n",
      "gU",
      "<cmd>Telescope hierarchy outgoing_calls<cr>",
      desc = "outgoing calls | 出向调用"
    },
  },
}

