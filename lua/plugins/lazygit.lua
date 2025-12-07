-- FILE: lua/plugins/lazygit.nvim
-- INFO: 这是一个对 lazygit 软件的进一步 nvim 集成应用
return {
  "kdheepak/lazygit.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
  },
  lazy = true,
  cmd = {
    "LazyGit",
    "LazyGitConfig",
    "LazyGitCurrentFile",
    "LazyGitFilter",
    "LazyGitFilterCurrentFile",
  },
  init = function()
    -- INFO: 这部分因为未知原因，其实工作不好，建议直接从 lazygit config 入手
    vim.g.lazygit_use_neovim_remote = 1;
    vim.g.lazygit_floating_window_scaling_factor = 1.05;
    vim.g.lazygit_floating_window_use_plenary    = 0;
    vim.g.lazygit_floating_window_border_chars   = { '', '', '', '', '', '', '', '', };
  end,
  keys = {
    { mode = "n", "gl", "<cmd>LazyGit<cr>", desc = "LazyGit" }
  },
}

