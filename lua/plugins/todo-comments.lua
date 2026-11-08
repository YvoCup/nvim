-- FILE: lua/plugins/todo-comments.lua
-- INFO: Highlight & jump for custom todo keywords
--       自定义 todo 关键字的高亮与跳转

-- Git root of current project; fallback to buffer dir | 当前项目 Git 根，退到 buffer 目录
-- local function git_root_or_buf_dir()
--   local dir = vim.fn.expand('%:p:h')
--   if dir == '' then dir = (vim.uv or vim.loop).cwd() end -- No file: fallback to cwd | 没文件退到 cwd
--
--   local git_root = vim.fn.systemlist('git -C ' .. vim.fn.shellescape(dir) .. ' rev-parse --show-toplevel')[1]
--   if vim.v.shell_error == 0 and git_root ~= '' then
--     return git_root
--   else
--     return dir
--   end
-- end

return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = "VeryLazy",  -- Load after everything else | 所有工作完成后加载
  ---------------------------------------------------- config ----------------------------------------------------------
  config = function()
    require("todo-comments").setup({
      -- HACK: each keyword has: <name>, icon, color (bg; fg defaults to black), alt (aliases), signs
      --       关键字字段：名字、图标、颜色（背景色，前景默认黑）、别名、是否显示图标
      keywords = {
        -- NOTE: undetected comment, for general notes | 一般注意项
        NOTE = { icon = " ", color = "#9cc480", alt = {} },
        -- INFO: main info part of a comment | 注释的主要信息
        INFO = { icon = " ", color = "#7f91cd", alt = {} },
        -- WARN: usage/style warnings | 警告用法或写法
        -- XXXX: alias | 别名
        WARN = { icon = " ", color = "#e5c890", alt = { "XXXX" } },
        -- BUGS: this is a bug | 这是一个 bug
        BUGS = { icon = " ", color = "#c1c8e6" },
        -- TODO: work to be done | 待完成的工作
        -- ERRO: alias | 别名
        TODO = { icon = " ", color = "#e78284", alt = { "ERRO" } },
        -- HACK: highlight well-written gems | 写得好的亮点
        HACK = { icon = " ", color = "#f3e3ca" },
        -- OPTM: improvable spots | 可进一步优化
        -- PERF: alias, tracked too | 别名，同样识别
        PERF = { icon = " ", color = "#9cc480", alt = { "OPTM" } },
        -- DEAD: abandoned code | 已抛弃的代码
        DEAD = { icon = " ", color = "#7b83a0" },
        -- EXAM: under testing, not final | 测试阶段，不够完善
        EXAM = { icon = "󰂓 ", color = "#8caaee", alt = {} },
        -- MARK: quick-find markers | 标记，便于查找
        MARK = { icon = "󰓹 ", color = "#f4b8e4" },
        -- PARA: parameters | 一切参数
        -- DEPS: global deps | 一切全局依赖
        -- RETN: returns | 一切返回
        PARA = { icon = " ", color = "#e599e5" },
        DEPS = { icon = " ", color = "#dd74dd" },
        RETN = { icon = " ", color = "#d460d4" },
        -- FILE: filename | 文件名
        FILE = { icon = " ", color = "#91e0d5" },
      },
      search = {
        command = 'rg',
        args = {
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
          '--hidden',
          '--glob=!.git',
        },
        -- Default quickfix; changed to noice here | 默认 quickfix，此处改 noice
        pattern = [[\b(KEYWORDS)\b]],  -- KEYWORDS is replaced by plugin | 占位符由插件替换
      },
    })
  end,
  ----------------------------------------------------- keys -----------------------------------------------------------
  keys = {
    -- Jump within current file | 本文件内快速跳转
    {
      mode = { "n" },
      "tj",
      function()
        require("todo-comments").jump_next({
          keywords = { "TODO", "WARN", "HACK", "OPTM", "PERF", "TEST", "BUGS", "DEAD", "MARK", "INFO" }
        })
      end,
      desc = "next todo comment | 下一个 todo 注释"
    },
    {
      mode = { "n" },
      "tk",
      function()
        require("todo-comments").jump_prev({
          keywords = { "TODO", "WARN", "HACK", "OPTM", "PERF", "TEST", "BUGS", "DEAD", "MARK", "INFO" }
        })
      end,
      desc = "previous todo comment | 上一个 todo 注释",
    },
    -- Telescope global: only key items, no general info | 全局查阅重点，不含一般信息
    -- {
    --   mode = { "n" },
    --   "tm",
    --   "<cmd>TodoTelescope keywords=TODO,WARN,OPTM,PERF,BUGS,DEAD,MARK,INFO cwd=" ..
    --   git_root_or_buf_dir() .. "<cr>",
    --   desc = "toggle todo telescope"
    -- },
    -- -- Only current file | 仅当前文件
    -- {
    --   mode = { "n" },
    --   "t<s-m>",
    --   "<cmd>TodoTelescope keywords=NOTE,INFO,WARN,XXXX,BUGS,TODO,HACK,OPTM,PERF,DEAD,TEST,MARK,PARA,FILE
    --   cwd=" ..
    --   vim.fn.expand('%:p') ..
    --   "<cr>",
    --   desc = "toggle todo Quickfix"
    -- },
    -- -- MARK-only lookup | 专门查阅 MARK
    -- {
    --   mode = { "n" },
    --   "t<c-m>",
    --   "<cmd>TodoTelescope keywords=MARK cwd=" .. git_root_or_buf_dir() .. "<cr>",
    --   desc = "toggle mark lists"
    -- },
  },
}

