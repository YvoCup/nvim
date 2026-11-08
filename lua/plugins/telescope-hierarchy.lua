-- FILE: lua/plugins/telescope-hierarchy.lua
-- INFO: LSP call hierarchy via telescope
--       telescope 的 LSP 调用层级

return {
  "jmacadie/telescope-hierarchy.nvim",
  ------------------------------------------------------ config --------------------------------------------------------
  config = function ()
    require("telescope").setup({
      extensions = {
        hierarchy = {
          -- no auto multi-expand on open: first screen stays light
          -- 打开时不自动多层展开：首屏更清爽
          initial_multi_expand = false,
          -- layers expanded per multi-expand press (E / <c-m>)
          -- 按一次多层展开（E / <c-m>）展开的层数
          multi_depth = 3,
          -- typing in prompt filters the tree live (matches keep parent chain)
          -- 输入框打字即过滤树（命中项保留父链）
          filter_mode = true,
          -- do not enter insert mode when filter starts
          -- 过滤启动时不自动进入插入模式
          filter_start_insert = false,
          -- filtered matches also keep their children visible
          -- 过滤命中项的子节点也一并保留显示
          filter_include_children = true,
          -- simulate call hierarchy via references+treesitter for LSPs without
          -- it (e.g. lua_ls); incoming only, no direction switch
          -- 对不支持 call hierarchy 的 LSP（如 lua_ls）用
          -- references+treesitter 模拟；仅入向，不可切换方向
          enable_reference_fallback = true,
        }
      }
    })
  end,
  ------------------------------------------------------- keys ---------------------------------------------------------
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

