-- FILE: lua/plugins/persistence.lua
-- INFO: Session saving (persisted.nvim)
--       会话保存功能

local session_active = false  -- Track toggle state | 跟踪开关状态

return {
  "olimorris/persisted.nvim",
  event = "BufReadPre",
  opts = {
    use_git_branch = true,  -- One session per git branch | 按 git 分支区分会话
    autosave = false,
  },
  ----------------------------------------------------- keys -----------------------------------------------------------
  keys = {
    {
      mode = "n",
      "ts",
      "<cmd>Telescope persisted<cr>",
      desc = "open persisted sessions | 会话列表"
    },
    {
      mode = "n",
      "ss",
      function ()
        require("persisted").save()
        vim.notify("Session saved.", vim.log.levels.INFO)
      end,
      desc = "save session | 保存会话"
    },
    {
      mode = "n",
      "st",
      function()
        require("persisted").toggle()
        session_active = not session_active
        vim.notify(
          session_active and "Session track started" or "Session track stopped",
          vim.log.levels.INFO
        )
      end,
      desc = "toggle session tracking | 开关会话跟踪",
    },
  },
}

