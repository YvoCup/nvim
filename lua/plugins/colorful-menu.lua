-- FILE: lua/plugins/colorful-menu.lua
-- INFO: Rich completion menu highlighting (pairs with blink)
--       补全菜单美化高亮（配合 blink）

return {
  "xzbdmw/colorful-menu.nvim",
  ---------------------------------------------------- config ----------------------------------------------------------
  config = function()
    -- Keep defaults with minor tweaks; none are required
    -- 以下保留默认值并稍作调整，其实都可以不设
    require("colorful-menu").setup({
      ls = {
        lua_ls = {
          -- Dim the arguments a bit | 参数调暗一点
          arguments_hl = "@comment",
        },
        gopls = {
          -- Render variable/function type on the rightmost side
          -- 把类型渲染到最右侧，避免和 label 挤在一起

          -- when true:
          -- foo             *Foo
          -- ast         "go/ast"

          -- when false:
          -- foo *Foo
          -- ast "go/ast"
          align_type_to_right = true,
          -- Format label as "foo: Foo" instead of go's "foo Foo"
          -- 标签格式化为 "foo: Foo"；align_type_to_right 为 true 时无效
          add_colon_before_type = false,
          -- See https://github.com/xzbdmw/colorful-menu.nvim/pull/36
          preserve_type_when_truncate = true,
        },
        -- For lsp_config or typescript-tools | 适用于两者
        ts_ls = {
          -- "@comment" = no extra info | 不显示额外信息
          -- See https://github.com/xzbdmw/colorful-menu.nvim/issues/42
          extra_info_hl = "@comment",
        },
        vtsls = {
          -- "@comment" = no extra info | 不显示额外信息
          -- See https://github.com/xzbdmw/colorful-menu.nvim/issues/42
          extra_info_hl = "@comment",
        },
        ["rust-analyzer"] = {
          -- Such as (as Iterator), (use std::io) | 如 (as Iterator)
          extra_info_hl = "@comment",
          align_type_to_right = true,  -- Same as gopls | 同 gopls
          -- See https://github.com/xzbdmw/colorful-menu.nvim/pull/36
          preserve_type_when_truncate = true,
        },
        clangd = {
          -- Such as "From <stdio.h>" | 如 "From <stdio.h>"
          extra_info_hl = "@comment",
          align_type_to_right = true,  -- Same as gopls | 同 gopls
          -- Hl of leading dot in "•std::filesystem::permissions(..)"
          -- "•" 前导点的高亮组
          import_dot_hl = "@comment",
          -- See https://github.com/xzbdmw/colorful-menu.nvim/pull/36
          preserve_type_when_truncate = true,
        },
        zls = {
          align_type_to_right = true,  -- Same as gopls | 同 gopls
        },
        roslyn = {
          extra_info_hl = "@comment",
        },
        dartls = {
          extra_info_hl = "@comment",
        },
        -- The same applies to pyright/pylance | 同样适用于两者
        basedpyright = {
          -- Usually the import path, e.g. "os" | 通常是导入路径
          extra_info_hl = "@comment",
        },
        pylsp = {
          extra_info_hl = "@comment",
          -- Dim function args; main difference from pyright
          -- 参数调暗，与 pyright 的主要区别
          arguments_hl = "@comment",
        },
        -- If true, try to highlight unsupported languages
        -- 为 true 时尝试高亮"不支持"的语言
        fallback = true,
        -- Applied to label description for unsupported languages
        -- 应用于不支持语言的 label description
        fallback_extra_info_hl = "@comment",
      },
      -- Fallback hl when built-in logic finds no suitable group
      -- 内置逻辑找不到合适高亮组时使用
      fallback_highlight = "@variable",
      -- Truncate final text to this width (display cells);
      -- 0~1 float = window width percentage. Default 60
      -- 截断到该宽度；0~1 小数按窗口宽百分比，默认 60
      max_width = 60,
    })
  end,
}

