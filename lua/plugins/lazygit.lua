-- FILE: lua/plugins/lazygit.nvim
-- INFO: Further nvim integration of the lazygit TUI
--       lazygit 软件的 nvim 集成封装
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
    -- NOTE: this part doesn't work well for unknown reasons;
    --       it's recommended to configure lazygit itself instead
    -- 注意：这部分因未知原因工作不好，建议从 lazygit config 入手
    vim.g.lazygit_use_neovim_remote = 1;
    vim.g.lazygit_floating_window_scaling_factor = 1.05;
    vim.g.lazygit_floating_window_use_plenary    = 0;
    vim.g.lazygit_floating_window_border_chars   = { '', '', '', '', '', '', '', '', };
  end,
  ----------------------------------------------------- keys -----------------------------------------------------------
  keys = {
    {
      mode = "n",
      "gl",
      "<cmd>LazyGit<cr>",
      desc = "open LazyGit | 启动 LazyGit"
    },
  },
}

