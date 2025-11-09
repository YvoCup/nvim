-- FILE: lua/plugins/treesitter.lua
-- INFO: 这是 treesitter 高亮显示，其中的默认部分 textobject 能力将关闭
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",  -- 安装或者更新配置之后执行
  branch = "master",    -- 其主要的分支使用
  -- NOTE: Very Lazy
  enevt = "VeryLazy",   -- 这个
  -- NOTE: OPTION
  config = function ()  -- 插件内部配置
    require("nvim-treesitter.configs").setup({
      -- 确保安装的 treesitter 头目
      ensure_installed = {
        "lua",
        "python",
        "cpp",
        "c",
        "typescript",
        "javascript",
        "json",
      },

      -- 高亮启用
      highlight = {
        enable = true,
      },
      indent = { enable = true },

      -- NOTE: 代码块快速选择，这个也是我很喜欢的功能了
      --       但是为了更好的统一 textobject 这种快速搜索查阅实现代码的功能，因此这个功能关闭了
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
