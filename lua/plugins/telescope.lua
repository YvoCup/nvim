-- FILE: lua/plugins/telescope.lua
-- INFO: telescope 是非常优秀的浮动窗口显示功能代码

return {
  "nvim-telescope/telescope.nvim",
  lazy = true,
  ---------------------------------------------------- config ----------------------------------------------------------
  config = function()
    require("telescope").setup({
      defaults = {
        -- 在 telescope 运行时刻出现的案件控制
        mappings = {
          -- 一般模式
          -- 插入模式
          i = {
            ["<C-j>"] = require("telescope.actions").move_selection_next,
            ["<C-k>"] = require("telescope.actions").move_selection_previous,
            ["<C-q>"] = require("telescope.actions").close,
          },
          n = {
            ["q"] = require("telescope.actions").close, 
          },
        },
        -- 主题，这个主题是输入框在左上角，预览在右侧的那种
        theme = "center",
        -- 排序顺序
        sorting_strategy = "ascending",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.4,
          },
        },
        -- 默认 normal 模式
        initial_mode = "normal",
      },
      extensions = {
        -- file_browser 这个插件的额外配置
        file_browser = {
          grouped = true,  -- 分组显示文件夹和文件之间的区别
          git_status = false,
          hidden = { file_browser = true, folder_browser = true },
        },
      },
    })
    require("telescope").load_extension("file_browser")
  end,
  ----------------------------------------------------- keys -----------------------------------------------------------
  keys = {
    { "<leader>ts", "<cmd>Telescope find_files<cr>", mode = "n", desc = "telescope find files" },
    { "<leader>tg", "<cmd>Telescope live_grep<cr>",  mode = "n", desc = "telescope live grep" },
    { "<leader>tb", "<cmd>Telescope buffers<cr>",    mode = "n", desc = "telescope buffers" },
    { "<leader>tn", "<cmd>Telescope help_tags<cr>",  mode = "n", desc = "telescope help tags" },
  }
}

