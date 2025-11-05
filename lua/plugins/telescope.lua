return {
  "nvim-telescope/telescope.nvim",
  lazy = false,
  config = function()
    require("telescope").setup({
      defaults = {
        -- 在 telescope 运行时刻出现的案件控制
        mappings = {
          -- 一般模式
          -- 插入模式
          i = {
            ['<C-j>'] = require('telescope.actions').move_selection_next,
            ['<C-k>'] = require('telescope.actions').move_selection_previous,
            ['<C-q>'] = require('telescope.actions').close,
          }
        },
      },
    })
  end,
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>", mode = "n", desc = "telescope find files" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>",  mode = "n", desc = "telescope live grep" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>",    mode = "n", desc = "telescope buffers" },
    { "<leader>fn", "<cmd>Telescope help_tags<cr>",  mode = "n", desc = "telescope help tags" },
  }
}

