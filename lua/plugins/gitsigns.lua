-- FILE: lua/plugins/gitsigns.lua
-- INFO: 好看的且优秀的 git 信息插件
--       能够在左侧绘制出当前行的 git 状态，并给出基本的使用快捷键使用（虽然我将主要以 lazygit 进行控制）

----------------------------------------------------- highlight --------------------------------------------------------
vim.api.nvim_set_hl(0, "GitSignsAdd",          { bg = "none", fg = "#a6d189" })
vim.api.nvim_set_hl(0, "GitSignsChange",       { bg = "none", fg = "#d9be88" })
vim.api.nvim_set_hl(0, "GitSignsDelete",       { bg = "none", fg = "#e78284" })
vim.api.nvim_set_hl(0, "GitSignsChangedelete", { bg = "none", fg = "#eba3a4" })
vim.api.nvim_set_hl(0, "GitSignsTopdelete",    { bg = "none", fg = "#eba3a4" })

-- 每一行后边的那个的谁什么时候写的的那个浮文
vim.api.nvim_set_hl(0, 'GitSignsCurrentLineBlame', { fg = "#8f9ac2", bold = true })

return {
  "lewis6991/gitsigns.nvim",
  ---------------------------------------------------- config ----------------------------------------------------------
  config = function ()
    require("gitsigns").setup({
      -- 原始的才是最香的
      -- signs = {
      --   add          = { text = " " },
      --   change       = { text = " " },
      --   delete       = { text = " " },
      --   topdelete    = { text = " " },
      --   changedelete = { text = " " },
      --   untracked    = { text = " " },
      -- },

      signs_staged_enable = false,

      signcolumn = true,
      numhl      = true,
      linehl     = false,
      word_diff  = false,

      watch_gitdir = {
        follow_files = false
      },

      auto_attach = true,
      attach_to_untracked = false,
      current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- "eol" | "overlay" | "right_align"
        delay = 100,
        ignore_whitespace = false,
        virt_text_priority = 100,
      },
    })
  end
}
