-- FILE: lua/plugins/telescope.lua
-- INFO: telescope 是非常优秀的浮动窗口显示功能代码

-- 当前项目 Git 根目录；若不在仓库则退到 buffer 所在目录
local function git_root_or_buf_dir()
  local dir = vim.fn.expand('%:p:h')
  if dir == '' then dir = (vim.uv or vim.loop).cwd() end   -- 没打开文件时退到 cwd

  local git_root = vim.fn.systemlist('git -C ' .. vim.fn.shellescape(dir) .. ' rev-parse --show-toplevel')[1]
  if vim.v.shell_error == 0 and git_root ~= '' then
    return git_root
  else
    return dir
  end
end

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
            ["<S-j>"] = function(prompt_bufnr)
              local action = require "telescope.actions"
              for _ = 1, 5 do
                action.move_selection_next(prompt_bufnr)
              end
            end,
            ["<S-k>"] = function(prompt_bufnr)
              local action = require "telescope.actions"
              for _ = 1, 5 do
                action.move_selection_previous(prompt_bufnr)
              end
            end,
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
  keys = {
    {
      mode = "n",
      "tt",
      function()
        require("telescope.builtin").find_files({ cwd = git_root_or_buf_dir() })
      end,
      desc = "telescope find files at pwd"
    },
    {
      mode = "n",
      "tg",
      require('telescope.builtin').live_grep,
      desc = "telescope find files at git root"
    },
    { "t<s-b>", "<cmd>Telescope buffers<cr>",    mode = "n", desc = "telescope buffers" },
    { "tn",     "<cmd>Telescope help_tags<cr>",  mode = "n", desc = "telescope help tags" },
  }
}

