-- FILE: lua/plugins/neovim-remote.lua
-- INFO: Remote development over SSH (remote-nvim)
--       SSH 远程开发（remote-nvim）

----------------------------------------------------- highlight --------------------------------------------------------

return {
  "amitds1997/remote-nvim.nvim",
  version = "*",  -- Pin to GitHub releases | 锁定 GitHub 发布版
  lazy = true,
  dependencies = {
    "nvim-lua/plenary.nvim",          -- Standard functions | 基础函数库
    "MunifTanjim/nui.nvim",           -- Plugin UI | 插件界面
    "nvim-telescope/telescope.nvim",  -- Pick remote method | 选择远程方式
  },
  ---------------------------------------------------- config ----------------------------------------------------------
  config = true,
}

