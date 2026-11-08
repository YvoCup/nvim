-- FILE: lua/plugins/indent-blankline.lua
-- INFO: Indent guide plugin (formerly rainbow, now single color)
--       缩进线插件，曾是彩虹线，现在单色也很好看

----------------------------------------------------- highlight --------------------------------------------------------
vim.api.nvim_set_hl(0, "BlankLine",       { bg = none, fg = "#656c87" })
vim.api.nvim_set_hl(0, "BlankLineActive", { bg = none, fg = "#61AFEF" })

return {
  "lukas-reineke/indent-blankline.nvim",
  enent = "VeryLazy",      -- NOTE: typo kept as-is; should be `event`
                           -- 注意：原文件拼写如此，应为 event
  ---------------------------------------------------- config ----------------------------------------------------------
  main = "ibl",            -- Alias for require | require 别名
  branch = "master",       -- Use the main branch | 使用主分支
  lazy = false,            -- Not lazy-loaded | 非 lazy 加载
  config = function ()     -- Plugin config | 插件配置
    require("ibl").setup({
      indent = {
        smart_indent_cap = true,
        highlight = { "BlankLine" },
      },
      scope  = {
        show_start = true,
        show_end   = true,
        highlight = { "BlankLineActive" },
      }
    })
  end,
}

