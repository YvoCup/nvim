-- FILE: lua/plugins/treesitter.lua
-- INFO: Treesitter highlighting; default textobject features disabled
--       treesitter 高亮，默认 textobject 能力关闭

return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",    -- Run after install/update | 安装或更新后执行
  branch = "main",        -- Use the main branch | 使用主分支
  event = "VeryLazy",     -- Lazy load | 懒加载
  ---------------------------------------------------- config ----------------------------------------------------------
  config = function ()
    require("nvim-treesitter").setup({
      ensure_installed = "all",  -- Ensure all parsers installed | 确保安装全部 parser

      highlight = {
        enable = true,           -- Enable highlighting | 启用高亮
      },
      indent = { enable = true },

      -- NOTE: incremental selection is disabled to keep
      --       textobject-style search unified; keys kept for reference
      --       为统一 textobject 检索而关闭，键位留作参考
      -- <CR> in normal: start selection on node at cursor; in visual: expand
      -- <CR> normal 模式：开始选中光标所在节点；visual 模式：扩大
      -- <BS> in visual: shrink back to previous node (what mini.ai lacks)
      -- <BS> visual 模式：缩小回上一层节点（mini.ai 缺的能力）
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection   = "<CR>",
          node_incremental = "<CR>",
          node_decremental = "<BS>",
          -- no scope_incremental: only works in languages with @scope
          -- captures (very few); <Tab> feels dead | 不设此项：依赖稀少的
          -- @scope capture，按了没反应
        },
      },
    })
  end
}

