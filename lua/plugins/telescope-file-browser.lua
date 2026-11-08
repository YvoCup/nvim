-- FILE: lua/plugins/telescope-file-browser.lua
-- INFO: File browser extension for telescope
--       telescope 的文件浏览器扩展

return {
  "nvim-telescope/telescope-file-browser.nvim",
  dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  lazy = false,
  cmd = {},
  ----------------------------------------------------- keys -----------------------------------------------------------
  keys = {
    {
      -- Open at .git root | 打开以 .git 为主的根目录
      mode = "n",
      "tf",
      "<cmd>Telescope file_browser path="
        .. (vim.fn.systemlist('git rev-parse --show-toplevel')[1] or vim.loop.cwd())
        .. " select_buffer=true<cr>",
      desc = "file browser at git root | 浏览器定位 git 根"
    },
    {
      -- Dir of current file; unnamed falls back to cwd | 当前文件目录，无名文件回退 cwd
      mode = "n",
      "tb",
      function()
        ---@type string?
        local dir = vim.fn.expand('%:p:h')
        if dir == '' then dir = (vim.uv or vim.loop).cwd() end
        require('telescope').extensions.file_browser.file_browser({
          path = dir,
          select_buffer = true,
        })
      end,
      desc = "file browser in current file's folder | 定位当前文件目录"
    },
    {
      -- Open at default location | 打开默认文件位置
      mode = "n",
      "td",
      "<cmd>Telescope file_browser<cr>",
      desc = "file browser in cwd | 浏览器定位 cwd"
    },
  },
}

