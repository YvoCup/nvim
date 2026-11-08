-- FILE: lua/plugins/yankbank.lua
-- INFO: Yank history bank with sqlite persistence
--       剪贴板历史库，sqlite 持久化

return {
  "ptdewey/yankbank-nvim",
  dependencies = "kkharji/sqlite.lua",
  lazy = false,
  cmd = { "YankBank" },
  ---------------------------------------------------- config ----------------------------------------------------------
  config = function()
    require('yankbank').setup({
      persist_type = "sqlite",
      num_behavior = "jump",
      keymaps = {
        paste      = "<CR>",
        paste_back = "P",  -- Paste above current line | 粘贴在当前行上方
      },
    })
  end,
  ----------------------------------------------------- keys -----------------------------------------------------------
  keys = {
    { "<leader>p",     "<cmd>YankBank<cr>",         mode = "n", desc = "open yank bank | 打开历史库" },
    { "<leader><s-p>", "<cmd>YankBankClearDB<cr>",  mode = "n", desc = "clear yank bank db | 清空历史库" },
  }
}

