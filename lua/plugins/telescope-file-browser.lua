return {
  "nvim-telescope/telescope-file-browser.nvim",
  dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  lazy = false,
  cmd = {},
  ----------------------------------------------------- keys -----------------------------------------------------------
  keys = {
    {
      mode = "n",
      "tf",
      "<cmd>Telescope file_browser path="
        .. (vim.fn.systemlist('git rev-parse --show-toplevel')[1] or vim.loop.cwd())
        .. " select_buffer=true<cr>",
      desc = "open telescpe file browser in git root path"
    },
    {
      mode = "n",
      "tb",
      function()
        -- 当前文件所在目录，无名文件则回退到 cwd
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
      mode = "n",
      "td",
      "<cmd>Telescope file_browser<cr>",
      desc = "opne telescope file browser in cwd"
    },
  },
}
