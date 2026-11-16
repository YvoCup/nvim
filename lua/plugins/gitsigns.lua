-- FILE: lua/plugins/gitsigns.lua
-- INFO: Git status in the sign column; lazygit stays the main interface
--       左侧绘制 git 状态；lazygit 仍是主要操作入口

----------------------------------------------------- highlight --------------------------------------------------------
vim.api.nvim_set_hl(0, "GitSignsAdd",              { bg = "none", fg = "#a6d189" })
vim.api.nvim_set_hl(0, "GitSignsChange",           { bg = "none", fg = "#d9be88" })
vim.api.nvim_set_hl(0, "GitSignsDelete",           { bg = "none", fg = "#e78284" })
vim.api.nvim_set_hl(0, "GitSignsChangedelete",     { bg = "none", fg = "#eba3a4" })
vim.api.nvim_set_hl(0, "GitSignsTopdelete",        { bg = "none", fg = "#eba3a4" })

-- EOL blame | 行尾 blame
vim.api.nvim_set_hl(0, 'GitSignsCurrentLineBlame', { fg = "#6e7daf", bold = true })

-- Staged hunks: darker variants of the same palette | 已暂存部分：同色系暗色版
vim.api.nvim_set_hl(0, "GitSignsStagedAdd",            { bg = "none", fg = "#6c8a59" })
vim.api.nvim_set_hl(0, "GitSignsStagedAddNr",          { bg = "none", fg = "#80a269" })
vim.api.nvim_set_hl(0, "GitSignsStagedChange",         { bg = "none", fg = "#927f5a" })
vim.api.nvim_set_hl(0, "GitSignsStagedChangeNr",       { bg = "none", fg = "#a99369" })
vim.api.nvim_set_hl(0, "GitSignsStagedDelete",         { bg = "none", fg = "#9a2d31" })
vim.api.nvim_set_hl(0, "GitSignsStagedDeleteNr",       { bg = "none", fg = "#b3363a" })
vim.api.nvim_set_hl(0, "GitSignsStagedChangedelete",   { bg = "none", fg = "#8e292c" })
vim.api.nvim_set_hl(0, "GitSignsStagedChangedeleteNr", { bg = "none", fg = "#b3363a" })
vim.api.nvim_set_hl(0, "GitSignsStagedTopdelete",      { bg = "none", fg = "#8e292c" })
vim.api.nvim_set_hl(0, "GitSignsStagedTopdeleteNr",    { bg = "none", fg = "#b3363a" })

-- Hunk preview reuses the unstaged bright colors | 块预览复用未暂存的亮色
-- NOTE: this gitsigns version uses Add/DeletePreview (no PreviewChange); changed lines render as "added" side.
--       此版本 gitsigns 用 Add/DeletePreview（无 PreviewChange），修改的行渲染在 "added" 一侧。
vim.api.nvim_set_hl(0, "GitSignsAddPreview",    { bg = "none", fg = "#89ae71" })
vim.api.nvim_set_hl(0, "GitSignsDeletePreview", { bg = "none", fg = "#cc3f44" })

return {
  "lewis6991/gitsigns.nvim",
  lazy = false,
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

      signs_staged_enable = true,   -- Show staged hunks with dimmer signs | 已暂存内容用暗色 sign 显示

      signcolumn = true,
      numhl      = true,   -- Highlight line numbers | 行号高亮
      linehl     = false,  -- Highlight whole lines | 整行高亮
      word_diff  = false,

      -- No border by default (falls back to vim.o.winborder) | 默认无边框（回退到 vim.o.winborder），显式加圆角边框
      preview_config = { border = "rounded" },

      auto_attach = true,
      attach_to_untracked = true,
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
  end,
  ----------------------------------------------------- keys -----------------------------------------------------------
  keys = {
    {
      mode = "n",
      "gn",
      "<cmd>Gitsigns preview_hunk<cr>",
      desc = "Preview unstaged hunk | 预览未暂存改动块"
    },
    {
      mode = "n",
      "gb",
      "<cmd>Gitsigns blame_line<cr>",
      desc = "Blame current line | 查看当前行 blame"
    },
    {
      mode = { "o", "x" },
      "ih",
      "<Cmd>Gitsigns select_hunk<CR>",
      desc = "Select hunk | 选中 hunk 文本对象"
    },
  }
}

