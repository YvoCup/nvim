return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  -- 设置为所有的工作都完成之后再去执行的
  event = "VeryLazy",
  config = function()
    require("todo-comments").setup({
      keywords = {
        -- INFO: 简单基础的介绍，主要介绍基本的功能
        INFO = { icon = " ", color = "#a6dbff" },
        -- WARN: 警告部分，警告用法或者写法
        WARN = { icon = " ", color = "#e5c890" },
        -- BUGS: 这是一个 bug
        BUGS = { icon = " ", color = "#c1c8e6" },
        -- TODO: 通常用于描述需要完成的工作
        TODO = { icon = " ", color = "#e78284" },
        -- HACK: 这个一般是亮点欣赏，写得好的地方值得高亮
        HACK = { icon = " ", color = "#f3e3ca" },
        -- OPTM: 修复，存在进一步修复的可能的地方
        OPTM = { icon = " ", color = "#9cc480" },
        -- DEAD: 这部分已经被抛弃了
        DEAD = { icon = " ", color = "#7b83a0" },
        -- TEST: 测试阶段，代码不够完善
        TEST = { icon = "󰂓 ", color = "#8caaee" },
        -- MARK: 标记，当需要寻找的时候快速查找
        MARK = { icon = "󰓹 ", color = "#f4b8e4" },
        -- PARA: 函数或者别的什么的参数高亮提示
        PARA = { icon = " ", color = "#dd74dd" },
        -- FILE: 文件名
        FILE = { icon = " ", color = "#81c8be" },
      },
    })
  end,
  keys = {
    {
      mode = { "n" },
      "<leader>tj",
      function()
        require("todo-comments").jump_next({
          keywords = { "TODO", "WARN", "HACK", "OPTM", "TEST", "BUGS", "DEAD", "MARK", "INFO" }
        })
      end,
      desc = "next error/warning todo comment"
    },
    {
      mode = { "n" },
      "<leader>tk",
      function()
        require("todo-comments").jump_prev({
          keywords = { "TODO", "WARN", "HACK", "OPTM", "TEST", "BUGS", "DEAD", "MARK", "INFO" }
        })
      end,
      desc = "previous error/warning todo comment",
    },
    -- telescope 查阅，不会列出一般信息类选项
    {
      mode = { "n" },
      "<leader>tt",
      "<cmd>TodoTelescope keywords=TODO,WARN,OPTM,BUGS,DEAD,MARK,INFO<cr>",
      desc = "toggle todo telescope"
    },
    -- 列出几个关键的需要快速修复的问题
    { 
      mode = { "n" },
      "<leader>tq",
      "<cmd>TodoQuickFix keywords=TODO,BUGS,OPTM<cr>",
      desc = "toggle todo Quickfix"
    },
    -- 除了一般信息类选项之外都会列举出来，相当于 buffer 形式的 telescope
    {
      mode = { "n" },
      "<leader>tl",
      "<cmd>TodoLocList keywords=TODO,WARN,OPTM,BUGS,DEAD,MARK,INFO<cr>",
      desc = "toggle todo Local list"
    },
    -- 专门针对 MRAK 做一层标记查阅
    {
      mode = { "n" },
      "<leader>tm",
      "<cmd>TodoLocList keywords=MARK<cr>",
      desc = "toggle mark lists"
    },
  },
}
