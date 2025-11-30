return {
  "ptdewey/yankbank-nvim",
  dependencies = "kkharji/sqlite.lua",
  lazy = false,
  cmd = { "YankBank" },
  config = function()
    require('yankbank').setup({
      persist_type = "sqlite",
      num_behavior = "jump",
      keymaps = {
        paste      = "<CR>",
        paste_back = "P",  -- 粘贴在当前行的上方
      },
    })
  end,
  keys = {
    { "<leader>p",     "<cmd>YankBank<cr>",         mode = "n", desc = "open yank bank" },
    { "<leader><s-p>", "<cmd>YankBankClearDB<cr>",  mode = "n", desc = "clear yank bank data-base" },
  }
}
