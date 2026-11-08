-- FILE: lua/plugins/yanky.lua
-- INFO: Enhanced yank/put with history cycling
--       增强版复制粘贴，支持历史循环

vim.api.nvim_set_hl(0, "YankyPut",    { bg = "#6c8a59", bold = true })
vim.api.nvim_set_hl(0, "YankyYanked", { bg = "#6c8a59", bold = true })

return {
  "gbprod/yanky.nvim",
  ---------------------------------------------------- config ----------------------------------------------------------
  config = function ()
    require("yanky").setup({

    })
  end,
  ----------------------------------------------------- keys -----------------------------------------------------------
  keys = {
    { "p", "<Plug>(YankyPutAfter)",          mode = { "n", "x" } },  -- Put after | 粘贴到后面
    { "P", "<Plug>(YankyPutBefore)",         mode = { "n", "x" } },  -- Put before | 粘贴到前面
    { "gp", "<Plug>(YankyGPutAfter)",        mode = { "n", "x" } },  -- Put & leave cursor after | 粘贴后光标在后
    { "gP", "<Plug>(YankyGPutBefore)",       mode = { "n", "x" } },  -- Put & leave cursor before | 粘贴后光标在前
    { "<c-p>", "<Plug>(YankyPreviousEntry)", mode = "n" },           -- Older yank | 上一条历史
    { "<c-n>", "<Plug>(YankyNextEntry)",     mode = "n" },           -- Newer yank | 下一条历史
  }
}

