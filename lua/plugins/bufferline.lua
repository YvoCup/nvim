-- FILE: lua/plugins/bufferline.lua
-- INFO: 顶部栏，拥有了就能够对多文件进程控制啦！

return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  ---------------------------------------------------- config ----------------------------------------------------------
  config = function()
    require("bufferline").setup({
      highlights = {
        -- 背景色，就是那些完全没有被选择的 buffer 的基础配色
        background = { bg = "#323647", fg = "#8f9ac2" },
        -- buffer 是当前激活的 buffer 的配色
        -- 离开当前 buffer 的时候（buffer还可见），是 visible
        -- 选择当前的 buffer 的时候，是 selected
        buffer_visible  = { fg = "#8f9ac2", },
        buffer_selected = { fg = "#c8d4f6", },
        -- number 的高亮
        numbers = { fg = "#8f9ac2" },
        numbers_visible  = { fg = "#8f9ac2" },
        numbers_selected = { fg = "#c8d4f6" },
        -- 修改图标的高亮
        modified = { fg = "#e78284" },
        modified_visible  = { fg = "#e78284" },
        modified_selected = { fg = "#e78284" },
      },
      options = {
        -- 过滤一些 buffer
        custom_filter = function(buf_number)
          -- 未关联磁盘文件夹的未命名 buffer
          if vim.api.nvim_buf_get_name(buf_number) == "" then
            return false
          end

          -- 获取名单
          local file_type = vim.bo[buf_number].filetype
          local file_name = vim.fn.bufname(buf_number)
          -- 自定义名单，之后再往这儿写不喜欢的就好了
          local type_filter_map = {
            ['qf']          = false,   -- quickfix
            ['help']        = false,
            ['dashboard']   = false,
            ['alpha']       = false,
            ['toggleterm']  = false,
            ['TelescopePrompt'] = false,
          }
          local name_filter_map = {
            ['NvimTree']   = false,
            ['neo%-tree']  = false,
          }

          -- buffer type 匹配
          if type_filter_map[file_type] == false then return false end

          -- 路径/名字匹配
          for pat, show in pairs(name_filter_map) do
            if file_name:match(pat) and show == false then
              return false
            end
          end

          return true
        end,
        -- 前面的数字展示，并没有给出 buffer id
        numbers = function(opts)
          return string.format('%s', opts.raise(opts.ordinal))
        end,
        -- 左右都是没有任何分隔符的
        separator_style = { '', '' },
        indicator = {
          icon = "",
          style = "none"
        },
        -- 关闭关闭按钮
        show_close_icon = false,
        show_buffer_close_icons = false,
        show_tab_close = false,
        -- 一些 icon
        modified_icon = "󰳼 ",      -- 这个是文件发生修改时的标识
        left_trunc_marker = "..",  -- 这个是左右两侧，数量过多的时候的标识
        right_trunc_marker = "..",
      },
    })
  end,
  ----------------------------------------------------- keys -----------------------------------------------------------
  keys = {
    -- 左右移动以及快速交换位置
    {
      mode = { "n" },
      "th",
      "<cmd>BufferLineCyclePrev<cr>",
      desc = "goto left buffer"
    },
    {
      mode = { "n" },
      "tl",
      "<cmd>BufferLineCycleNext<cr>",
      desc = "goto right buffer"
    },
    {
      mode = { "n" },
      "t<s-h>",
      "<cmd>BufferLineMovePrev<cr>",
      desc = "goto left buffer"
    },
    {
      mode = { "n" },
      "t<s-l>",
      "<cmd>BufferLineMoveNext<cr>",
      desc = "goto left buffer"
    },
    -- 快速选择与快速关闭
    {
      mode = { "n" },
      "tp",
      "<cmd>BufferLinePick<cr>",
      desc = "pick buffer"
    },
    {
      mode = { "n" },
      "t<s-p>",
      "<cmd>BufferLinePickClose<cr>",
      desc = "pick buffer close"
    },
    {
      mode = { "n" },
      "t<s-q>",
      "<cmd>BufferLineCloseOthers<cr>",
      desc = "close others without this buffer"
    },
    {
      mode = { "n" },
      "tq",
      "<cmd>bdelete<cr>",
      desc = "just normal close"
    },
  }
}
