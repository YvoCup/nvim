return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("lualine").setup({
      options = {
        -- 必须有这个覆盖 lualine 的底层颜色系
        theme = function()
          local custom_theme = require("lualine.themes.gruvbox")
          local bg = "#323647"
          custom_theme.normal.c.bg = bg
          custom_theme.insert.c.bg = bg
          custom_theme.visual.c.bg = bg
          custom_theme.replace.c.bg = bg
          custom_theme.command.c.bg = bg
          custom_theme.inactive.c.bg = bg
          return custom_theme
        end,
        icons_enabled = true,  -- 启用图标
        globalstatus = true,   -- 下划线全局启用
        -- 删除了每个组件中间的符号
        component_separators = { left = "", right = ""},
        section_separators = {left = "", right = ""},
        -- 在某些 filetype 下不启用 lualine
        disabled_filetypes = {
          -- 状态栏彻底隐藏的文件类型，由 `:set filetype` 指出当前类型
          statusline = {},
          -- winbar 也被隐藏
          winbar = {},
        },
      },
      -------------------------------------------------- sctions -------------------------------------------------------
      -- lualine 的主体结构，主要展现状态信息等等体验
      sections = {
        -- mode 当前的 vim 模式
        --------------------------------------------------- a ----------------------------------------------------------
        lualine_a = {
          {
            function()
              -- 只返回一个字母，无多余空格
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
              local bg
              if m == "n" then
                bg = "#8caaee"      -- Normal 蓝
              elseif m == "i" then
                bg = "#93b979"      -- Insert 绿
              elseif m == "v" or m == "V" or m == "␖" then
                bg = "#ff97d7"      -- Visual 粉
              elseif m == "c" then
                bg = "#cdb380"      -- Command 橙
              elseif m == "s" or m == "S" or m == "␓" then
                bg = "#e5c890"      -- Select 黄
              elseif m == "R" or m == "r" then
                bg = "#e78284"      -- Replace 红
              elseif m == "!" then
                bg = "#cdb380"      -- Shell 命令是更深一级别的橙
              elseif m == "t" then
                bg = "#72b1a8"      -- Terminal 灰
              else
                bg = "#8f9ac2"      -- 未知模式
              end
              return { bg = bg, fg = "#4c5267", gui = "bold" }
            end,
            separator = {
              left = "",
              right = "",
            },
          },
        },
        --------------------------------------------------- b ----------------------------------------------------------
        -- 文件地址、名称及其文件图标
        lualine_b = {
          -- git 分支名称
          {
            "branch",
            icon = "",
            color = {
              bg = "#323647",
              fg = "#f4b8e4",
            },
          },
          -- 文件夹相对路径
          {
            function()
              local file_dir = vim.fn.expand("%:p:h")          -- 当前文件所在绝对目录
              if file_dir == "" then return "" end             -- 无落地文件，空

              -- 拿 git 根
              local git_root = vim.fn.systemlist(
                "git -C '" .. file_dir:gsub('"', '\\"') .. "' rev-parse --show-toplevel"
              )[1]
              if vim.v.shell_error == 0 and git_root then
                -- 有仓库：当前文件目录 相对于 git 根
                local rel = file_dir:gsub('^' .. vim.pesc(git_root) .. '/', '')
                return rel
              else
                -- 无仓库：直接缩写成 ~
                return vim.fn.fnamemodify(file_dir, ":~:.")
              end
            end,
            icon = "",
            color = {
              bg = "#323647",
              fg = "#8f9ac2",
            },
          },
          -- 文件名
          {
            function()
              local icons = {
                lua        = '󰢱',
                py         = '',
                js         = '',
                ts         = '',
                jsx        = '',
                tsx        = '',
                rust       = '',
                go         = '󰟓',
                c          = '󰙱',
                cpp        = '󰙲',
                cc         = '󰙲',
                cxx        = '󰙲',
                java       = '',
                md         = '󰍔',
                json       = '',
                yaml       = '',
                yml        = '',
                toml       = '',
                sh         = '',
                bash       = '󱆃',
                txt        = '󱞎',
                html       = '',
                css        = '',
                scss       = '',
                vue        = '',
                dockerfile = '',
              };
              
              local name = vim.fn.expand('%:t')          -- 完整文件名
              if name == "" then return "" end           -- 空缓冲区

              local ext  = vim.fn.expand('%:e')          -- 后缀（不含点）
              local icon = icons[ext] or ''            -- 后缀找不到就用默认

              return icon .. " " .. name
            end,
            color = {
              bg = "#323647",
              fg = "#a9bef2",
            },
          },
        },
        --------------------------------------------------- c ----------------------------------------------------------
        -- 主要是当前文件的错误以及状态等等信息
        lualine_c = {
          {
            'diagnostics',
            sources = { 'nvim_lsp' },
            sections = { 'error', 'warn', 'info', 'hint' },
            symbols = { error = ' ', warn = ' ', info = ' ', hint = ' '},
            diagnostics_color = {
              error = { fg = "#e78284", bg = none },
              warn  = { fg = "#e5c890", bg = none },
              info  = { fg = "#79bdb3", bg = none },
              hint  = { fg = "#9cc480", bg = none },
            },
            update_in_insert = true,
            always_visible = true,
            color = { bg = "#51576d" },
            separator = { left  = '', right = '' },
          },
        },
        --------------------------------------------------- x ----------------------------------------------------------
        lualine_x = {
          {
            "diff",
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
              added = ' ',
              modified = ' ',
              removed = ' ',
            },
            color = { bg = "#323647" },
          },
        },
        --------------------------------------------------- y ----------------------------------------------------------
        lualine_y = {},
        --------------------------------------------------- z ----------------------------------------------------------
        lualine_z = {
          {
            -- 图标 + 百分比 + 行:列 
            function()
              local cur   = vim.fn.line('.')
              local col   = vim.fn.col('.')
              local total = vim.fn.line('$')
              local pct   = total == 0 and 0 or math.floor(cur * 100 / total)
            
              -- 一次性返回整条字符串
              return string.format('%s %d%%%% %d:%d', "󰮯", pct, cur, col)
            end,
            
            -- 颜色随进度一起变
            color = { bg = "#323647", fg = "#8f9ac2", gui = 'bold' },
            separator = { left = '', right = '' },
          },
          {
            'fileformat',
            symbols = {
              unix = '󰣇',
              dos = '',
              mac = '',
            },
            color = { bg = "#323647", fg = "#8f9ac2" },
          },
        },
      },
    })
  end
}

