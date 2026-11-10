-- FILE: lua/plugins/telescope-file-browser.lua
-- INFO: File browser extension for telescope
--       telescope 的文件浏览器扩展

-- Highlight links: git status marks follow GitSigns palette | 高亮链接：git 状态标记沿用 GitSigns 色板
vim.api.nvim_set_hl(0, "TelescopeResultsDiffAdd", { link = "GitSignsAdd" })
vim.api.nvim_set_hl(0, "TelescopeResultsDiffChange", { link = "GitSignsChange" })
vim.api.nvim_set_hl(0, "TelescopeResultsDiffDelete", { link = "GitSignsDelete" })
vim.api.nvim_set_hl(0, "TelescopeResultsDiffUntracked", { link = "GitSignsAdd" })

return {
  "nvim-telescope/telescope-file-browser.nvim",
  dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  cmd = {},
  ------------------------------------------------------ config --------------------------------------------------------
  config = function ()
    require("telescope").setup({
      extensions = {
        file_browser = {
          grouped = true,     -- Group dirs & files | 分组显示文件夹和文件
          -- Show git status marks; symbols borrowed from starship git_status module
          -- 显示 git 状态标记，符号借鉴 starship 的 git_status 模块
          git_status = true,
          git_icons = {
            added     = "",   -- starship: added | 新增
            changed   = "",   -- starship: modified | 修改
            deleted   = "",   -- starship: deleted | 删除
            untracked = "",   -- same family as lualine diff symbols | 与 lualine diff 同族的未跟踪图标
            -- renamed/copied/unmerged not covered here, plugin defaults kept
            -- renamed/copied/unmerged 此处不采用 starship 符号，保留插件默认
          },
          display_stat = { size = true, date = true },   -- Omit mode to hide perms | 不写 mode 即隐藏权限列
          respect_gitignore = false,   -- Don't skip files in .gitignore | 不跳过被 gitignore 的文件
          hidden = {          -- Show hidden files too | 隐藏文件也显示
            file_browser = true,
            folder_browser = true
          },
          mappings = {
            ["i"] = {
              -- <C-n> create new file | <C-n> 新建文件
              ["<C-n>"] = require("telescope._extensions.file_browser.actions").create,
              -- <C-x> move file | <C-x> 移动文件
              ["<C-x>"] = require("telescope._extensions.file_browser.actions").move,
            },
            ["n"] = {
              -- n new file | n 新建文件
              ["n"] = require("telescope._extensions.file_browser.actions").create,
              -- x move file | x 移动文件
              ["x"] = require("telescope._extensions.file_browser.actions").move,
            },
          },
        },
      },
    })
  end,
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
