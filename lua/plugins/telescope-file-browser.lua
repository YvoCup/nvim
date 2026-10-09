return {
  "nvim-telescope/telescope-file-browser.nvim",
  dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  lazy = false,
  cmd = {},
  ----------------------------------------------------- keys -----------------------------------------------------------
  keys = {
    {
      -- 打开以 .git 为主的根目录所在地
      mode = "n",
      "tf",
      "<cmd>Telescope file_browser path="
        .. (vim.fn.systemlist('git rev-parse --show-toplevel')[1] or vim.loop.cwd())
        .. " select_buffer=true<cr>",
      desc = "open telescpe file browser in git root path"
    },
    {
      -- 当前文件所在目录，无名文件则回退到 cwd
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
      desc = "open telescope file_browser in current file's folder"
    },
    {
      -- 打开默认的文件位置
      mode = "n",
      "td",
      "<cmd>Telescope file_browser<cr>",
      desc = "opne telescope file browser in cwd"
    },
  },
}
