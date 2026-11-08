-- FILE: lua/plugins/mini.lua
-- INFO: mini.nvim: ai (text objects) + pairs (auto brackets) + align
--       mini.nvim：ai（文本对象）+ 括号自动配对 + 文本对齐

return {
  'nvim-mini/mini.nvim',
  version = '*',
  ---------------------------------------------------- config ----------------------------------------------------------
  config = function()
    require("mini.ai").setup({
      -- b/q: "grab whatever wraps this" without caring which bracket/quote type
      -- b/q：不关心是哪种括号/引号，一键选中"被包起来的内容"
      custom_textobjects = {
        b = { { '(', ')', '{', '}', '[', ']', '<', '>' } },  -- b = any bracket | 任意括号
        q = { { '"', "'", '`' } },                           -- q = any quote | 任意引号
      },
      mappings = {
        around = "a",
        inside = "i",

        -- Move cursor to corresponding edge of `a` textobject
        goto_left  = 'g[',
        goto_right = 'g]',

        -- Next/last variants
        -- NOTE: This (deliberately) overrides Neovim>=0.12 built-in incremental
        -- selection mappings. See `:h MiniAi-default-an-in` for more details.
        around_next = 'an',
        inside_next = 'in',
        around_last = 'al',
        inside_last = 'il',
      }
    })
    require('mini.pairs').setup({
      modes           = { insert = true, command = false },
      skip_ts         = { "string" },
      skip_unbalanced = true,
      markdown        = true,
    })
    require('mini.align').setup({
      mappings = {
        start              = "<leader>a",
        start_with_preview = "<leader>A",
      }
      -- HACK: three props per use: split, justify, merge
      --       split = separator, justify = l/c/r, merge = join symbol
      --       三个属性：split 分割方式，justify 左中右，merge 插入符号
    })
  end
}

