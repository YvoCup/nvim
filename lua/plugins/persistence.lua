-- FILE: lua/plugins/persistence.lua
-- INFO: 会话保存功能
return {
  "olimorris/persisted.nvim",
  event = "BufReadPre",
  opts = {
    use_git_branch = true,
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
        vim.cmd('SessionSave')
        vim.notify('Session saved', vim.log.levels.INFO)
      end,
      desc = "Persisted save"
    },
  },
}
