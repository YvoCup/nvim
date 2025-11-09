return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",  -- 安装或者更新配置之后执行
  branch = "master",    -- 其主要的分支使用
  lazy = false,         -- 非 lazy 加载
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

      -- 代码块快速选择，这个也是我很喜欢的功能了
      incremental_selection = {
        enable = true,
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
