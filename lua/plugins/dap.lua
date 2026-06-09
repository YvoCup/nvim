return {
  "rcarriga/nvim-dap-ui",
  dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"},
  lazy = false,
  config = function()
    require("dapui").setup()
  end,
  ----------------------------------------------------- keys -----------------------------------------------------------
  keys = {
    -- 打开 dap ui
    {
      mode = { "n" },
      "bu",
      function ()
        require("dapui").toggle()
      end,
      desc = "dapui toggle."
    },
    -- 设置断点
    {
      mode = { "n" },
      "bb",
      function ()
        require("dap")["toggle_breakpoint"]()
      end,
      desc = "toggle a breakpoint."
    },
  }
}
