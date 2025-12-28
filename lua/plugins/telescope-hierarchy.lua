return {
  "jmacadie/telescope-hierarchy.nvim",
  keys = {
    {
      mode = "n",
      "gu",
      "<cmd>Telescope hierarchy incoming_calls<cr>",
      desc = "LSP: [S]earch [I]ncoming Calls"
    },
    {
      mode = "n",
      "gU",
      "<cmd>Telescope hierarchy outgoing_calls<cr>",
      desc = "LSP: [S]earch [O]utgoing Calls"
    },
  },
}
