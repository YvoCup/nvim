-- FILE: lua/plugins/persistence.lua
-- INFO: Capacity of saving sessions.
--       会话保存功能      
local session_active = false

return {
  "olimorris/persisted.nvim",
  event = "BufReadPre",
  opts = {
    use_git_branch = true,
    autosave = false
  },
  keys = {
    {
      mode = "n",
      "ts",
      "<cmd>Telescope persisted<cr>",
      desc = "Telescope open persisted"
    },
    {
      mode = "n",
      "ss",
      function ()
        require("persisted").save()
        vim.notify("Session saved.", vim.log.levels.INFO)
      end,
      desc = "Persisted save."
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
      desc = "Toggle session tracking",
    },
  },
}
