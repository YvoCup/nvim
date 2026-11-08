-- FILE: lua/plugins/gitsigns.lua
-- INFO: A nice git plugin: draws git status in the sign column
--       好看的 git 插件，左侧绘制 git 状态
--       Basic keymaps provided, but lazygit is the main interface
--       提供基础键位，不过我主要用 lazygit 控制

----------------------------------------------------- highlight --------------------------------------------------------
vim.api.nvim_set_hl(0, "GitSignsAdd",              { bg = "none", fg = "#a6d189" })
vim.api.nvim_set_hl(0, "GitSignsChange",           { bg = "none", fg = "#d9be88" })
vim.api.nvim_set_hl(0, "GitSignsDelete",           { bg = "none", fg = "#e78284" })
vim.api.nvim_set_hl(0, "GitSignsChangedelete",     { bg = "none", fg = "#eba3a4" })
vim.api.nvim_set_hl(0, "GitSignsTopdelete",        { bg = "none", fg = "#eba3a4" })
vim.api.nvim_set_hl(0, 'GitSignsCurrentLineBlame', { fg = "#8f9ac2", bold = true })  -- EOL blame | 行尾 blame

return {
  "lewis6991/gitsigns.nvim",
  ---------------------------------------------------- config ----------------------------------------------------------
  config = function ()
    require("gitsigns").setup({
      -- The original signs are the best | 原始的才是最香的
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
      numhl      = true,   -- Highlight line numbers | 行号高亮
      linehl     = false,  -- Highlight whole lines | 整行高亮
      word_diff  = false,

      watch_gitdir = {
        follow_files = false
      },

      auto_attach = true,
      attach_to_untracked = false,
      -- Current line blame; toggle with :Gitsigns toggle_current_line_blame
      -- 当前行 blame，可用命令切换
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",  -- "eol" | "overlay" | "right_align" | 行尾
        delay = 100,
        ignore_whitespace = false,
        virt_text_priority = 100,
      },
    })
  end
}

