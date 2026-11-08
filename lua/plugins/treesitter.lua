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
      incremental_selection = {
        enable = false,
        keymaps = {
          init_selection    = "<CR>",
          node_incremental  = "<CR>",
          scope_incremental = "<Tab>",
          node_decremental  = "<BS>",
        },
      },
    })
  end
}

