-- FILE: lua/plugins/noice.nvim
-- INFO: 这个看着像是一个封装好了 notify 的高级能力，我主要是看上了其 cmd plattem 能力

----------------------------------------------------- highlight --------------------------------------------------------
vim.api.nvim_set_hl(0, "NoiceNormal", { fg = "#8caaee", bg = "none", bold = true })
vim.api.nvim_set_hl(0, "NoiceFloatBorder", { fg = "#8caaee", bg = "none"})

return {
  "folke/noice.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  event = "VeryLazy",
  ---------------------------------------------------- config ----------------------------------------------------------
  config = function()
    require("noice").setup({
      -- 消息栏的显示问题
      routes = {
        -- 不显示搜索下的 [1/15] 之类的信息
        {
          filter = {
            event = "msg_show",
            kind = "search_count",
          },
          opts = { skip = true },
        },
        -- 不显示保存文件信息
        {
          filter = {
            event = "msg_show",
            kind = "",
            find = "written",
          },
          opts = { skip = true },
        },
        -- 避免所有为空内容的消息弹出
        {
        filter = {
          event = "msg_show",
          kind = "",
        },
        opts = { skip = true },
      },
      },
      -- 视图，是命令行、命令行提示的主要部分
      views = {
        cmdline_popup = {
          position = {
            row = 2,
            col = "50%",
          },
          size = {
            width = 80,
            height = "auto",
          },
        },
        popupmenu = {
          relative = "editor",
          position = {
            row = 5,
            col = "50%",
          },
          size = {
            width = 80,
            height = 12,
          },
          border = {
            style = "rounded",
            padding = { 0, 1 },
          },
          win_options = {
            winhighlight = { Normal = "NoiceNormal", FloatBorder = "NoiceFloatBorder" },
          },
        },
      },
    })
  end,
  keys = {
  }
}

