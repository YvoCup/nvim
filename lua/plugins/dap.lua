-- FILE: lua/plugins/dap.lua
-- INFO: DAP UI (floating windows instead of sidebar)
--       调试界面（浮动窗口替代侧边栏）

return {
  "rcarriga/nvim-dap-ui",
  dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"},
  lazy = false,
  ---------------------------------------------------- config ----------------------------------------------------------
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    dapui.setup({
      -- No default sidebar; use floating windows + manual triggers
      -- 不创建默认侧边栏，全靠浮动窗口 + 手动触发
      floating = {
        max_height = nil,
        max_width = nil,
        border = "rounded",
        mappings = {
          close = { "q", "<Esc>" },
        },
      },
    })

    -- Don't auto-open sidebar on start (no layout).
    -- To auto-popup scopes: dapui.float_element("scopes")
    -- 启动时不再自动打开侧边栏；如需自动弹出 scopes 可改这里
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.float_element("scopes")
    end
  end,
  ----------------------------------------------------- keys -----------------------------------------------------------
  keys = {
    {
      mode = { "n" },
      "bu",
      function ()
        require("dapui").toggle()
      end,
      desc = "dapui toggle | 切换 dap-ui"
    },
    {
      "bs",
      function() require("dapui").float_element("scopes", { enter = true }) end,
      desc = "dapui: float scopes | 浮动显示作用域"
    },
    {
      "br",
      function() require("dapui").float_element("repl", { enter = true }) end,
      desc = "dapui: float repl | 浮动显示 REPL"
    },
    {
      mode = { "n" },
      "bb",
      function ()
        require("dap")["toggle_breakpoint"]()
      end,
      desc = "toggle a breakpoint | 切换断点"
    },
  }
}

