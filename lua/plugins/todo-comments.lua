return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  lazy = false,
  config = function()
    require("todo-comments").setup({
      keywords = {
        -- INFO: 更为基础的标签了
        INFO = { icon = " ", color = "#79bdb3" },
        -- WARN: 警告部分，警告用法或者写法，但不要和别的地方弄混了
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
      },
    })
  end,
  keys = {
    {
      mode = { "n" },
      "<leader>tj",
      function()
        require("todo-comments").jump_next({
          keywords = { "TODO", "ERROR", "WARN", "HACK", "OPTM", "TEST", "BUGS", "DEAD", "MARK" }
        })
      end,
      desc = "next error/warning todo comment"
    },
    {
      mode = { "n" },
      "<leader>tk",
      function()
        require("todo-comments").jump_prev({
          keywords = { "TODO", "ERROR", "WARN", "HACK", "OPTM", "TEST", "BUGS", "DEAD", "MARK" }
        })
      end,
      desc = "previous error/warning todo comment",
    },
    { "<leader>tt", "<cmd>TodoTelescope<cr>",  mode = "n", desc = "toggle todo telescope" },
    { "<leader>tq", "<cmd>TodoQuickFix<cr>",   mode = "n", desc = "toggle todo Quickfix"  },
    { "<leader>tl", "<cmd>TodoLocList<cr>",    mode = "n", desc = "toggle todo Local list" },
  },
}
