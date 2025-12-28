-- 当前项目 Git 根目录；若不在仓库则退到 buffer 所在目录
local function git_root_or_buf_dir()
  local dir = vim.fn.expand('%:p:h')
  if dir == '' then dir = (vim.uv or vim.loop).cwd() end -- 没打开文件时退到 cwd

  local git_root = vim.fn.systemlist('git -C ' .. vim.fn.shellescape(dir) .. ' rev-parse --show-toplevel')[1]
  if vim.v.shell_error == 0 and git_root ~= '' then
    return git_root
  else
    return dir
  end
end

return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  -- 设置为所有的工作都完成之后再去执行的
  event = "VeryLazy",
  config = function()
    require("todo-comments").setup({
      -- HACK: 每个关键字由以下组成
      --       <name>: 识别的名字
      --       icon: 图标
      --       color: 颜色，这是背景颜色，前景颜色默认黑色
      --       alt: 别名，注意需要删除一些默认的别名
      --       signs: 是否显示图标
      keywords = {
        -- NOTE: 不被检测的注释，用于一般注意项
        NOTE = { icon = " ", color = "#9cc480", alt = {} },
        -- INFO: 注释的主要信息部分
        INFO = { icon = " ", color = "#7f91cd", alt = {} },
        -- WARN: 警告部分，警告用法或者写法
        -- XXXX: 别名
        WARN = { icon = " ", color = "#e5c890", alt = { "XXXX" } },
        -- BUGS: 这是一个 bug
        BUGS = { icon = " ", color = "#c1c8e6" },
        -- TODO: 通常用于描述需要完成的工作
        -- ERRO: 别名
        TODO = { icon = " ", color = "#e78284", alt = { "ERRO" } },
        -- HACK: 这个一般是亮点欣赏，写得好的地方值得高亮
        HACK = { icon = " ", color = "#f3e3ca" },
        -- OPTM: 修复，存在进一步修复的可能的地方
        -- PERF: 别名，参与被跟踪和识别
        PERF = { icon = " ", color = "#9cc480", alt = { "OPTM" } },
        -- DEAD: 这部分已经被抛弃了
        DEAD = { icon = " ", color = "#7b83a0" },
        -- EXAM: 测试阶段，代码不够完善
        EXAM = { icon = "󰂓 ", color = "#8caaee", alt = {} },
        -- MARK: 标记，当需要寻找的时候快速查找
        MARK = { icon = "󰓹 ", color = "#f4b8e4" },
        -- PARA: 一切参数
        -- DEPS: 一切全局依赖
        -- RETN: 一切返回
        PARA = { icon = " ", color = "#e599e5" },
        DEPS = { icon = " ", color = "#dd74dd" },
        RETN = { icon = " ", color = "#d460d4" },
        -- FILE: 文件名
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
        -- 默认是 quickfix，这里改成 noice
        pattern = [[\b(KEYWORDS)\b]], -- KEYWORDS 占位符会被插件替换成 TODO|FIXME|WARN
      },
    })
  end,
  ------------------------------------------------ keys ------------------------------------------------------
  keys = {
    -- 本文件中快速跳转
    {
      mode = { "n" },
      "tj",
      function()
        require("todo-comments").jump_next({
          keywords = { "TODO", "WARN", "HACK", "OPTM", "PERF", "TEST", "BUGS", "DEAD", "MARK", "INFO" }
        })
      end,
      desc = "next error/warning todo comment"
    },
    {
      mode = { "n" },
      "tk",
      function()
        require("todo-comments").jump_prev({
          keywords = { "TODO", "WARN", "HACK", "OPTM", "PERF", "TEST", "BUGS", "DEAD", "MARK", "INFO" }
        })
      end,
      desc = "previous error/warning todo comment",
    },
    -- telescope 查阅重点消息，不会列出一般信息类选项，全局
    {
      mode = { "n" },
      "tm",
      "<cmd>TodoTelescope keywords=TODO,WARN,OPTM,PERF,BUGS,DEAD,MARK,INFO cwd=" ..
      git_root_or_buf_dir() .. "<cr>",
      desc = "toggle todo telescope"
    },
    -- -- 仅仅检查当前文件中的情况
    -- {
    --   mode = { "n" },
    --   "t<s-m>",
    --   "<cmd>TodoTelescope keywords=NOTE,INFO,WARN,XXXX,BUGS,TODO,HACK,OPTM,PERF,DEAD,TEST,MARK,PARA,FILE
    --   cwd=" ..
    --   vim.fn.expand('%:p') ..
    --   "<cr>",
    --   desc = "toggle todo Quickfix"
    -- },
    -- 专门针对 MRAK 做一层标记查阅
    {
      mode = { "n" },
      "t<c-m>",
      "<cmd>TodoTelescope keywords=MARK cwd=" .. git_root_or_buf_dir() .. "<cr>",
      desc = "toggle mark lists"
    },
  },
}
