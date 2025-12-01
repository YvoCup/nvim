-- lazygit.nvim
-- - 这是一个对 lazygit 软件的进一步 nvim 集成应用
return {
  ------------------------------------------------------ repo ----------------------------------------------------------
  "kdheepak/lazygit.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
  },
  ------------------------------------------------------ lazy ----------------------------------------------------------
  lazy = true,
  -- 延迟加载，且只有当输入一下命令的时候，才会加载 lazygit 这个插件
  cmd = {
    "LazyGit",
    "LazyGitConfig",
    "LazyGitCurrentFile",
    "LazyGitFilter",
    "LazyGitFilterCurrentFile",
  },
  ----------------------------------------------------- options --------------------------------------------------------
  -- 本插件没有支持 require("lazygit").setup() 的能力，因此采用 init 做全局变量控制
  init = function()
    -- INFO: 这部分因为未知原因，其实工作不好，建议直接从 lazygit config 入手
    vim.g.lazygit_use_neovim_remote = 1;
    vim.g.lazygit_floating_window_scaling_factor = 0.93;
    vim.g.lazygit_floating_window_use_plenary = 0;
  end,
  ------------------------------------------------------ keys ----------------------------------------------------------
  keys = {
    { mode = "n", "gl", "<cmd>LazyGit<cr>", desc = "LazyGit" }
  },
}
