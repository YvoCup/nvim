-- FILE: lua/plugins/noice.lua
-- INFO: A polished wrapper over notify; I mainly want its cmd palette
--       封装 notify 的高级能力，主要看上了其 cmd palette

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
      lsp = {
        signature = { enabled = false, },
        hover     = { enabled = false, },
        progress  = { enabled = false },
        message   = { view = "notify", },
      },
      routes = {  -- Message display rules | 消息栏的显示规则
        -- Hide search count like [1/15] | 不显示搜索计数
        {
          filter = {
            event = "msg_show",
            kind = "search_count",
          },
          opts = { skip = true },
        },
        -- Hide "written" on save | 不显示保存信息
        {
          filter = {
            event = "msg_show",
            kind = "",
            find = "written",
          },
          opts = { skip = true },
        },
        -- Skip empty messages | 避免空消息弹出
        {
          filter = {
            event = "msg_show",
            kind = "",
          },
          opts = { skip = true },
        },
      },
      -- Views: cmdline & popup menu | 视图：命令行与补全弹窗
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
      -- :Noice <cmd> configs; set filter etc. here
      -- 针对 :Noice 子命令的配置，可设 filter 逻辑
      commands = {
        history = {
          view = "popup",
        },
        all = {
          view = "popup",
        },
      },
    })
  end,
  ----------------------------------------------------- keys -----------------------------------------------------------
  keys = {
    {
      mode = "n",
      "<leader>nt",
      "<cmd>NoiceTelescope<cr>",
      desc = "noice history telescope | 历史消息搜索"
    },
    {
      mode = "n",
      "<leader>nl",
      "<cmd>Noice history<cr>",
      desc = "noice history | 历史消息"
    },
    {
      mode = "n",
      "<leader>nL",
      "<cmd>Noice all<cr>",
      desc = "noice all messages | 全部消息"
    },
  }
}

