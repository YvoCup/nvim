-- FILE: lua/plugins/telescope.lua
-- INFO: telescope: excellent floating picker framework
--       优秀的浮动窗口搜索框架

-- Git root of current project; fallback to buffer dir | 当前项目 Git 根，不在仓库退到 buffer 目录
local function git_root_or_buf_dir()
  local dir = vim.fn.expand('%:p:h')
  if dir == '' then dir = (vim.uv or vim.loop).cwd() end   -- No file: fallback to cwd | 没文件时退到 cwd

  local git_root = vim.fn.systemlist('git -C ' .. vim.fn.shellescape(dir) .. ' rev-parse --show-toplevel')[1]
  if vim.v.shell_error == 0 and git_root ~= '' then
    return git_root
  else
    return dir
  end
end

return {
  "nvim-telescope/telescope.nvim",
  branch = 'master',
  ---------------------------------------------------- config ----------------------------------------------------------
  config = function()
    require("telescope").setup({
      defaults = {
        mappings = {  -- Keys while telescope runs | 运行时按键
          -- Insert mode | 插入模式
          i = {
            ["<C-j>"] = require("telescope.actions").move_selection_next,
            ["<C-k>"] = require("telescope.actions").move_selection_previous,
            ["<C-q>"] = require("telescope.actions").close,
          },
          -- Normal mode | 一般模式
          n = {
            ["q"] = require("telescope.actions").close,
            ["<S-j>"] = function(prompt_bufnr)  -- Move 5 down | 下移 5 格
              local action = require "telescope.actions"
              for _ = 1, 5 do
                action.move_selection_next(prompt_bufnr)
              end
            end,
            ["<S-k>"] = function(prompt_bufnr)  -- Move 5 up | 上移 5 格
              local action = require "telescope.actions"
              for _ = 1, 5 do
                action.move_selection_previous(prompt_bufnr)
              end
            end,
          },
        },
        -- Theme: prompt top-left, preview right | 输入框左上，预览在右
        theme = "center",
        sorting_strategy = "ascending",  -- Sort order | 排序顺序
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.4,
          },
        },
        initial_mode = "normal",  -- Default to normal mode | 默认 normal 模式
      },
    })
    require("telescope").load_extension("file_browser")
    require("telescope").load_extension("persisted")
    require("telescope").load_extension("hierarchy")
    end,
  ----------------------------------------------------- keys -----------------------------------------------------------
  keys = {
    {
      mode = "n",
      "tt",
      function()
        require("telescope.builtin").find_files({ cwd = git_root_or_buf_dir() })
      end,
      desc = "find files at git root | git 根找文件"
    },
    {
      mode = "n",
      "tg",
      function ()
        require('telescope.builtin').live_grep({ cwd = git_root_or_buf_dir() })
      end,
      desc = "live grep at git root | git 根全局搜索"
    },
    { "t<s-b>", "<cmd>Telescope buffers<cr>",    mode = "n", desc = "buffers | 缓冲区列表" },
    { "tn",     "<cmd>Telescope help_tags<cr>",  mode = "n", desc = "help tags | 帮助标签" },
    -- INFO: all native LSP-related telescope pickers get their keys here
    --       原生 LSP 相关 telescope 方法在此绑定
    {
      mode = "n",
      "gd",
      require('telescope.builtin').lsp_definitions,
      desc = "lsp definitions | 跳转定义"
    },
    {
      mode = "n",
      "gD",
      require('telescope.builtin').lsp_type_definitions,
      desc = "lsp type definitions | 跳转类型定义"
    },
    {
      mode = "n",
      "gp",
      require('telescope.builtin').lsp_implementations,
      desc = "implementations | 实现"
    },
    {
      mode = "n",
      "ge",
      require('telescope.builtin').lsp_references,
      desc = "references | 引用"
    },
    {
      mode = "n",
      "go",
      require('telescope.builtin').lsp_document_symbols,
      desc = "document symbols | 文档符号"
    },
    {
      mode = "n",
      "gw",
      require('telescope.builtin').lsp_dynamic_workspace_symbols,
      desc = "dynamic workspace symbols | 动态工作区符号"
    },
    {
      mode = "n",
      "gW",
      require('telescope.builtin').lsp_workspace_symbols,
      desc = "workspace symbols | 工作区符号"
    },
  }
}

