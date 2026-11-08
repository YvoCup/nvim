-- FILE: lua/plugins/lualine.lua
-- INFO: Statusline: mode, git branch, file path, diagnostics, diff, position
--       状态栏：模式、分支、路径、诊断、diff、位置

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  ---------------------------------------------------- config ----------------------------------------------------------
  config = function()
    require("lualine").setup({
      options = {
        -- Must override lualine's base colors | 必须覆盖底层颜色系
        theme = function()
          local custom_theme = require("lualine.themes.gruvbox")
          local bg = "NONE"
          custom_theme.normal.c.bg = bg
          custom_theme.insert.c.bg = bg
          custom_theme.visual.c.bg = bg
          custom_theme.replace.c.bg = bg
          custom_theme.command.c.bg = bg
          custom_theme.inactive.c.bg = bg
          return custom_theme
        end,
        icons_enabled = true,   -- Enable icons | 启用图标
        globalstatus = true,    -- Global statusline | 全局状态栏
        component_separators = { left = "", right = ""},  -- No separators | 删分隔符
        section_separators = { left = "", right = ""},
        -- Disable lualine for some filetypes | 部分 filetype 不启用
        disabled_filetypes = {
          -- Set by `:set filetype` | 由 :set filetype 决定
          statusline = {
            "TelescopePrompt",
          },
          winbar = {},  -- winbar hidden too | winbar 同样隐藏
        },
      },
      -------------------------------------------------- sctions -------------------------------------------------------
      -- Main sections: status info | 主体结构，展现状态信息
      sections = {
        -- Current vim mode | 当前模式
        --------------------------------------------------- a ----------------------------------------------------------
        lualine_a = {
          {
            function()
              -- Single letter, no extra space | 只返回一个字母
              local m = vim.fn.mode()
              if m == "n" then
                return "N"
              elseif m == "i" then
                return "I"
              elseif m == "v" or m == "V" or m == "␖" then
                return "V"
              elseif m == "c" then
                return "C"
              elseif m == "s" or m == "S" or m == "␓" then
                return "S"
              elseif m == "R" or m == "r" then
                return "R"
              elseif m == "!" then
                return "!"
              elseif m == "t" then
                return "T"
              else
                return "?"
              end
            end,
            color = function()
              local m = vim.fn.mode()
              local fg
              if m == "n" then
                fg = "#8caaee"      -- Normal blue | 蓝
              elseif m == "i" then
                fg = "#93b979"      -- Insert green | 绿
              elseif m == "v" or m == "V" or m == "␖" then
                fg = "#ff97d7"      -- Visual pink | 粉
              elseif m == "c" then
                fg = "#cdb380"      -- Command orange | 橙
              elseif m == "s" or m == "S" or m == "␓" then
                fg = "#e5c890"      -- Select yellow | 黄
              elseif m == "R" or m == "r" then
                fg = "#e78284"      -- Replace red | 红
              elseif m == "!" then
                fg = "#cdb380"      -- Shell, deeper orange | 更深的橙
              elseif m == "t" then
                fg = "#72b1a8"      -- Terminal gray | 灰
              else
                fg = "#8f9ac2"      -- Unknown | 未知模式
              end
              return { bg = "NONE", fg = fg, gui = "bold" }
            end,
            separator = { left = "", right = "" },
          },
        },
        --------------------------------------------------- b ----------------------------------------------------------
        -- Dir path, filename & file icon | 文件地址、名称及图标
        lualine_b = {
          {
            "branch",  -- Git branch | git 分支名称
            icon = "",
            color = {
              bg = "NONE",
              fg = "#f4b8e4",
            },
          },
          {
            -- Path relative to git root | 文件夹相对路径
            function()
              local file_dir = vim.fn.expand("%:p:h")          -- Abs dir of file | 当前文件绝对目录
              if file_dir == "" then return "" end             -- No file on disk | 无落地文件

              local git_root = vim.fn.systemlist(
                "git -C '" .. file_dir:gsub('"', '\\"') .. "' rev-parse --show-toplevel"
              )[1]
              if vim.v.shell_error == 0 and git_root then
                -- In repo: dir relative to git root | 有仓库：相对 git 根
                local rel = file_dir:gsub('^' .. vim.pesc(git_root) .. '/', '')
                return rel == git_root and "./" or "./" .. rel
              else
                -- No repo: shorten to ~ | 无仓库：缩写成 ~
                return vim.fn.fnamemodify(file_dir, ":~:.")
              end
            end,
            icon = "",
            color = {
              bg = "NONE",
              fg = "#8f9ac2",
            },
          },
          {
            -- Filename | 文件名
            function()
              local icons = {
                lua        = '󰢱',
                py         = '',
                js         = '',
                ts         = '',
                jsx        = '',
                tsx        = '',
                rust       = '',
                go         = '󰟓',
                c          = '󰙱',
                cpp        = '󰙲',
                cc         = '󰙲',
                cxx        = '󰙲',
                java       = '',
                md         = '󰍔',
                json       = '',
                yaml       = '',
                yml        = '',
                toml       = '',
                sh         = '',
                bash       = '󱆃',
                txt        = '󱞎',
                html       = '',
                css        = '',
                scss       = '',
                vue        = '',
                dockerfile = '',
              };

              local name = vim.fn.expand('%:t')          -- Full filename | 完整文件名
              if name == "" then return "" end           -- Empty buffer | 空缓冲区

              local ext  = vim.fn.expand('%:e')          -- Ext without dot | 后缀
              local icon = icons[ext] or ''            -- Fallback icon | 默认图标

              return icon .. " " .. name
            end,
            color = {
              bg = "NONE",
              fg = "#a9bef2",
            },
          },
        },
        --------------------------------------------------- c ----------------------------------------------------------
        -- Diagnostics of current file | 当前文件的错误与状态
        lualine_c = {
          {
            'diagnostics',
            sources = { "nvim_diagnostic" },
            sections = { 'error', 'warn', 'info', 'hint' },
            symbols = { error = ' ', warn = ' ', info = ' ', hint = ' '},
            diagnostics_color = {
              error = { fg = "#e78284" },
              warn  = { fg = "#e5c890" },
              info  = { fg = "#79bdb3" },
              hint  = { fg = "#9cc480" },
            },
            update_in_insert = true,
            always_visible = true,
            color = { bg = "NONE" },
            separator = { left  = '', right = '' },
          },
        },
        --------------------------------------------------- x ----------------------------------------------------------
        lualine_x = {
          {
            "diff",  -- Diff from gitsigns | 来自 gitsigns 的 diff
            source = function()
              ---@diagnostic disable-next-line: undefined-field
              local gitstats = vim.b.gitsigns_status_dict
              if gitstats then
                return {
                  added = gitstats.added,
                  modified = gitstats.changed,
                  removed = gitstats.removed,
                }
              end
            end,
            colored = true,
            symbols = {
              added = ' ',
              modified = ' ',
              removed = ' ',
            },
            color = { bg = "NONE" },
          },
        },
        --------------------------------------------------- y ----------------------------------------------------------
        lualine_y = {},
        --------------------------------------------------- z ----------------------------------------------------------
        lualine_z = {
          {
            -- Icon + percent + line:col | 图标 + 百分比 + 行:列
            function()
              local cur   = vim.fn.line('.')
              local col   = vim.fn.col('.')
              local total = vim.fn.line('$')
              local pct   = total == 0 and 0 or math.floor(cur * 100 / total)

              -- Return the whole string at once | 一次性返回整条
              return string.format('%s %d%%%% %d:%d', "󰮯", pct, cur, col)
            end,

            color = { bg = "NONE", fg = "#8f9ac2", gui = 'bold' },  -- Color w/ progress | 颜色随进度
            separator = { left = '', right = '' },
          },
          {
            'fileformat',
            symbols = {
              unix = '󰣇',
              dos = '',
              mac = '',
            },
            color = { bg = "NONE", fg = "#8f9ac2" },
          },
        },
      },
    })
  end
}

