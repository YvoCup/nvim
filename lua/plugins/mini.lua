-- FILE: lua/plugins/mini.lua
-- INFO: mini.nvim: ai (text objects) + pairs (auto brackets) + align
--       mini.nvim：ai（文本对象）+ 括号自动配对 + 文本对齐

return {
  'nvim-mini/mini.nvim',
  version = '*',
  ---------------------------------------------------- config ----------------------------------------------------------
  config = function()
    -- mini.ai: smarter text objects: wraps builtins, adds f/t/? objects
    -- and next/last variants
    -- mini.ai：更聪明的文本对象：接管原生，新增 f/t/? 对象和 next/last 变体
    -- 更聪明的文本对象：接管原生，新增 f/t/? 对象和 next/last 变体
    require("mini.ai").setup({
      -- b/q: grab whatever wraps the cursor, regardless of bracket/quote type
      -- b/q：选中光标外"包着的内容"，不区分括号/引号类型
      custom_textobjects = {
        b = { { '(', ')', '{', '}', '[', ']', '<', '>' } },  -- b = any bracket | 任意括号
        q = { { '"', "'", '`' } },                           -- q = any quote | 任意引号
      },
      mappings = {
        around = "a",   -- a<obj>: object + surroundings | 对象+外围
        inside = "i",   -- i<obj>: object only | 仅对象内部

        -- Move cursor to left/right edge of the `a` textobject
        -- 光标跳到 a 对象的左/右边界（不选中）
        goto_left  = 'g[',
        goto_right = 'g]',

        -- Next/last variants: force select the object after/before cursor
        -- even when cursor is already inside one (cover_or_next only goes forward)
        -- next/last 变体：强制选光标后/前的对象
        -- （即使光标已在对象内也跳出；cover_or_next 只会往后找）
        -- NOTE: deliberately overrides Neovim>=0.12 built-in mappings
        --       （有意覆盖 Neovim>=0.12 原生同名映射，行为等价）
        -- See :h MiniAi-default-an-in
        around_next = 'an',
        inside_next = 'in',
        around_last = 'al',
        inside_last = 'il',
      }
    })

    -- mini.pairs: auto-complete the closing bracket/quote in insert mode
    -- mini.pairs：插入模式自动补全另一半括号/引号
    require('mini.pairs').setup({
      -- Only modes + mappings are valid top-level keys; unknown keys are
      -- silently ignored. Verified in source: skip_ts / skip_unbalanced /
      -- markdown are NOT mini.pairs options (dead config from another plugin)
      -- 顶层只有 modes 和 mappings 两个合法键；其余键被静默忽略
      -- （源码验证过：skip_ts/skip_unbalanced/markdown 均不是本插件选项）
      modes = { insert = true, command = false, terminal = false },
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

