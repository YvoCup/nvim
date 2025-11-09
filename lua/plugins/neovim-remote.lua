-- FILE: lua/plugins/neovim-remote.nvim
-- INFO: 这个看着像是一个封装好了 notify 的高级能力，我主要是看上了其 cmd plattem 能力

----------------------------------------------------- highlight --------------------------------------------------------
return {
  "amitds1997/remote-nvim.nvim",
  version = "*", -- Pin to GitHub releases
  lazy = true,
  dependencies = {
    "nvim-lua/plenary.nvim", -- For standard functions
    "MunifTanjim/nui.nvim", -- To build the plugin UI
    "nvim-telescope/telescope.nvim", -- For picking b/w different remote methods
  },
  config = true,
}
