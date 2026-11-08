-- FILE: lua/plugins/bufferline.lua
-- INFO: Top tabline: enables multi-buffer control
--       顶部栏，方便多文件控制

return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  ---------------------------------------------------- config ----------------------------------------------------------
  config = function()
    require("bufferline").setup({
      highlights = {
        -- Base color of non-selected buffers | 未选中 buffer 的基础配色
        background = { bg = "none", fg = "#8f9ac2" },
        -- buffer = inactive; visible = in another window; selected = current
        -- buffer 未激活；visible 在别的窗口可见；selected 当前选中
        buffer_visible  = { fg = "#8f9ac2", },
        buffer_selected = { fg = "#c8d4f6", },
        numbers          = { fg = "#8f9ac2" },  -- Number | 行号
        numbers_visible  = { fg = "#8f9ac2" },
        numbers_selected = { fg = "#c8d4f6" },
        modified          = { fg = "#e78284" },  -- Modified icon | 修改图标
        modified_visible  = { fg = "#e78284" },
        modified_selected = { fg = "#e78284" },
        -- LSP diagnostics: 4 severity levels | 四类诊断颜色
        error_selected   = { fg = "#e78284", bold = true, italic = true, },
        error_visible    = { fg = "#e78284", },
        error            = { fg = "#e78284", },
        warning_selected = { fg = "#e5c890", bold = true, italic = true, },
        warning_visible  = { fg = "#e5c890", },
        warning          = { fg = "#e5c890", },
        info_selected    = { fg = "#79bdb3", bold = true, italic = true, },
        info_visible     = { fg = "#79bdb3", },
        info             = { fg = "#79bdb3", },
        hint_selected    = { fg = "#9cc480", bold = true, italic = true, },
        hint_visible     = { fg = "#9cc480", },
        hint             = { fg = "#9cc480", },
      },
      options = {
        custom_filter = function(buf_number)  -- Filter out buffers | 过滤 buffer
          -- Unnamed buffer not on disk | 未关联文件的未命名 buffer
          if vim.api.nvim_buf_get_name(buf_number) == "" then
            return false
          end

          local file_type = vim.bo[buf_number].filetype
          local file_name = vim.fn.bufname(buf_number)
          -- Blocklist: add filetypes you dislike here | 名单，往后加即可
          local type_filter_map = {
            ['qf']              = false,   -- quickfix list | 列表
            ['help']            = false,   -- help docs | 帮助
            ['dashboard']       = false,   -- startup dashboard | 启动面板
            ['alpha']           = false,   -- startup dashboard | 启动面板
            ['toggleterm']      = false,   -- terminal | 终端
            ['TelescopePrompt'] = false,   -- telescope finder | 搜索框
            ["checkhealth"]     = false,   -- checkhealth | 健康检查
          }
          local name_filter_map = {
            ['NvimTree']        = false,   -- file tree | 文件树
            ['neo%-tree']       = false,   -- file tree | 文件树
          }

          -- Match by filetype | 按 filetype 匹配
          if type_filter_map[file_type] == false then return false end

          -- Match by name/path | 按名字/路径匹配
          for pat, show in pairs(name_filter_map) do
            if file_name:match(pat) and show == false then
              return false
            end
          end

          return true
        end,
        -- Number shown in front; NOT the buffer id | 前面的数字，非 buffer id
        numbers = function(opts)
          return string.format('%s', opts.ordinal)
        end,

        max_name_length   = 18,  -- max label length | 文本长度
        max_prefix_length = 15,  -- max duplicate prefix | 重复前缀长度
        tab_size          = 12,
        truncate_names    = true,
        diagnostics = "nvim_lsp",      -- LSP source | 诊断来源
        separator_style = { '', '' }, -- no separators | 无分隔符
        indicator       = { icon = "", style = "none", },

        show_close_icon         = false,  -- Hide all close buttons | 关闭按钮
        show_buffer_close_icons = false,
        show_tab_close          = false,

        modified_icon      = "󰳼 ",  -- Unsaved changes | 修改标识
        left_trunc_marker  = "..",  -- Overflow markers | 溢出标记
        right_trunc_marker = "..",
      },
    })
  end,
  ----------------------------------------------------- keys -----------------------------------------------------------
  keys = {
    -- Move left/right and swap | 左右移动与交换
    {
      mode = { "n" },
      "th",
      "<cmd>BufferLineCyclePrev<cr>",
      desc = "goto left buffer | 向左切换"
    },
    {
      mode = { "n" },
      "tl",
      "<cmd>BufferLineCycleNext<cr>",
      desc = "goto right buffer | 向右切换"
    },
    {
      mode = { "n" },
      "t<s-h>",
      "<cmd>BufferLineMovePrev<cr>",
      desc = "move buffer left | 左移缓冲区"
    },
    {
      mode = { "n" },
      "t<s-l>",
      "<cmd>BufferLineMoveNext<cr>",
      desc = "move buffer right | 右移缓冲区"
    },
    -- Quick pick & close | 快速选择与关闭
    {
      mode = { "n" },
      "tp",
      "<cmd>BufferLinePick<cr>",
      desc = "pick buffer | 选择跳转"
    },
    {
      mode = { "n" },
      "t<s-p>",
      "<cmd>BufferLinePickClose<cr>",
      desc = "pick buffer to close | 选择关闭"
    },
    {
      mode = { "n" },
      "t<s-q>",
      "<cmd>BufferLineCloseOthers<cr>",
      desc = "close other buffers | 关闭其他"
    },
    {
      mode = { "n" },
      "tq",
      "<cmd>bdelete<cr>",
      desc = "close current buffer | 关闭当前"
    },
  }
}

