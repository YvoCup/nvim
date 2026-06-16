return {
  "rcarriga/nvim-dap-ui",
  dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"},
  lazy = false,
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    dapui.setup({
      -- 不创建默认侧边栏布局，完全靠浮动窗口 + 手动触发
      floating = {
        max_height = nil,
        max_width = nil,
        border = "rounded",
        mappings = {
          close = { "q", "<Esc>" },
        },
      },
    })

    -- 调试启动时不再自动打开侧边栏（因为没布局）
    -- 如需自动弹出 scopes 浮动窗口可改为 dapui.float_element("scopes")
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.float_element("scopes")
    end
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
    {
      "bs",
      function() require("dapui").float_element("scopes", { enter = true }) end,
      desc = "dapui: float scopes"
    },
    {
      "br",
      function() require("dapui").float_element("repl", { enter = true }) end,
      desc = "dapui: float repl"
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
