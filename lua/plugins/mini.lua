-- FILE: lua/plugins/mini.lua
-- INFO: mini.nvim: ai (text objects) + pairs (auto brackets) + align + comment
--       + operators + move + splitjoin + surround
--       mini.nvim：ai（文本对象）+ 括号自动配对 + 文本对齐 + 注释 + 文本操作符
--       + 行/选区移动 + 单行多行互转 + 包裹符号增删改

----------------------------------------------------- highlight --------------------------------------------------------
-- Only highlight group of mini.operators: background of the "from" region
-- marked by `ix` during exchange; disappears once the swap is done
-- mini.operators 唯一的高亮组：exchange 时 `ix` 标记的第一段区域的背景色，交换完成即消失
vim.api.nvim_set_hl(0, "MiniOperatorsExchangeFrom", { bg = "#ff569c" })

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

        -- Move cursor to left/right edge of the `a` textobject (a motion,
        -- works in n/x/o like an operator motion, no selection made)
        -- 光标跳到 a 对象的左/右边界（motion 语义，n/x/o 三模式可用，不选中）
        -- e.g. cursor inside foo(bar, baz): `g[b` -> jumps to `(`, `g]b` -> to `)`
        -- 例：光标在 foo(bar, baz) 内：`g[b` 跳到 `(`，`g]b` 跳到 `)`；引号同理 `g[q`
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

    -- mini.align: align text by separator (e.g. align consecutive = or :)
    -- mini.align：按分隔符对齐文本（如对齐连续的 = 或 :）
    require('mini.align').setup({
      -- HACK: 具体使用方式说明：
      --       按下 <leader>a 或者 <leader>A 之后，再按以下按键实现功能：
      --       j: 检查当前可拥有的操作
      mappings = {
        start              = "<leader>a",  -- align directly | 直接对齐
        start_with_preview = "<leader>A",  -- align with live preview | 对齐+实时预览
      }
    })

    -- mini.comment: comment operator + textobject, same keys as native (gc/gcc)
    -- mini.comment：注释操作符 + 文本对象，键位与原生一致（gc/gcc）
    --
    -- Behavior identical to native gc/gcc (Neovim>=0.10), plus a comment
    -- textobject `gc` that native lacks: cgc rewrites / dgc deletes / ygc yanks
    -- the comment content. Default options are fine for now:
    --   options.custom_commentstring = nil  (use vim.bo.commentstring as-is)
    --   options.ignore_blank_line    = false
    --   options.start_of_line        = false
    --   options.pad_comment_parts    = true
    -- 默认配置开箱即用：行为与原生一致，额外获得原生没有的注释文本对象，
    -- 可用 cgc 改写 / dgc 删除 / ygc 复制注释内容
    require("mini.comment").setup({})

    -- mini.operators: a set of text operators, each works like d/y/c (takes
    -- motions and textobjects). Prefixes deliberately use `i*` instead of the
    -- default `g*`: `g` space is reserved for LSP (gj/gk/ga/gh/gr) and native
    -- g-keys, `i` is free in normal/operator-pending mode
    -- mini.operators：一组文本操作符，语义与 d/y/c 一致（吃 motion 和文本对象）。
    -- 前缀有意不用默认 g* 而用 i*：g 空间留给 LSP（gj/gk/ga/gh/gr）和原生
    -- g 系列键位；i 在 normal/operator-pending 模式下是空闲的
    require("mini.operators").setup({
      -- Evaluate: feed the region to `func` and replace it with the result
      -- evaluate：把选区交给 func 求值并用结果替换（默认走 vim 表达式求值）
      evaluate = {
        prefix = 'i=',  -- e.g. `i=ip` evaluates the paragraph | 对段落求值

        -- Function which does the evaluation (nil = built-in, vim.fn.eval)
        -- 求值函数（nil = 内置，即 vim.fn.eval）
        func = nil,
      },

      -- Exchange: swap two regions. `ix` marks the first region, second `ix`
      -- swaps it with the region under cursor; `ixx` reverts the last swap
      -- exchange：交换两段文本。ix 标记第一段，第二个 ix 与光标处文本交换；
      -- ixx 撤销上一次交换
      exchange = {
        -- NOTE: default prefix was `gx`; remapped to `ix` for the reason above
        --  默认前缀为 gx，因上述原因改为 ix
        prefix = 'ix',

        -- Whether to reindent new text to match previous indent (default nil
        -- follows global; true forces reindent after linewise exchange)
        -- linewise 交换后是否按上下文重排缩进（默认 nil 跟随全局，true 强制重排）
        reindent_linewise = true,
      },

      -- Multiply: duplicate the region `count` times (`im3j` duplicates the
      -- region spanning 3 lines three times)
      -- multiply：把选区复制 count 遍（如 im3j 把跨 3 行的选区复制 3 遍）
      multiply = {
        prefix = 'im',

        -- Function which can modify text before multiplying (nil = plain copy)
        -- 复制前可修改文本的函数（nil = 原样复制）
        func = nil,
      },

      -- Replace: delete the region and put the default register in its place.
      -- Key feature for the register workflow: the register used for pasting
      -- keeps its value (deleted text goes to unnamed register), so the same
      -- content can be pasted over multiple spots (`iriw` replaces word, then
      -- `iriw` again on the next word, register unchanged)
      -- replace：删除选区并粘贴默认寄存器内容。寄存器工作流核心：
      -- 用于粘贴的寄存器值不变（删掉的进无名寄存器），可多次替换不同位置
      replace = {
        -- NOTE: default prefix was `gr`; remapped to `ir` — `gr` space is
        --       used by LSP (gr = rename in lsp-init.lua)
        -- NOTE: 默认前缀为 gr，改为 ir；gr 空间已被 LSP 占用，gr=重命名
        prefix = 'ir',

        -- Reindent pasted text to match surrounding indent (see exchange)
        -- 粘贴后按上下文重排缩进（同 exchange）
        reindent_linewise = true,
      },

      -- Sort: sort lines in the region (`isip` sorts the paragraph)
      -- sort：对选区内行排序（isip 排序整个段落）
      sort = {
        prefix = 'i<s-s>',

        -- Function which does the sort (nil = built-in string sort; can be
        -- set to 'num' for numeric or 'nato' for natural sort)
        -- 排序函数（nil = 内置字符串排序；可设 'num' 数字排序 / 'nato' 自然排序）
        func = nil,
      }
    })

    -- mini.move: move lines (normal) or selections (visual) with Ctrl+hjkl.
    -- Native Ctrl+hjkl in n/x modes are <Nop>'ed in core/keymaps.lua first
    -- (not the default Alt+hjkl: Ctrl is easier on this keyboard layout and
    -- keeps Alt free). Supports count: `5<C-j>` moves the line 5 lines down
    -- mini.move：Ctrl+hjkl 移动行（normal）或选区（visual）。原生 Ctrl+hjkl
    -- 已在 core/keymaps.lua 中 <Nop> 卸载（不用默认 Alt+hjkl：Ctrl 更顺手，
    -- 且把 Alt 键位空间留出来）。支持 count：5<C-j> 一次下移 5 行
    require("mini.move").setup({
      mappings = {
        -- Move selection in Visual mode | 可视模式下移动选区
        left = '<C-h>',
        right = '<C-l>',
        down = '<C-j>',
        up = '<C-k>',

        -- Move current line in Normal mode | normal 模式下移动当前行
        line_left = '<C-h>',
        line_right = '<C-l>',
        line_down = '<C-j>',
        line_up = '<C-k>',
      },
      -- Reindent after moving a line across indent boundaries (default true)
      -- 移行跨过缩进边界后自动重排缩进（默认 true）
      options = { reindent_linewise = true }
    })

    require('mini.splitjoin').setup({
      mappings = {
        toggle = 'is',   -- 拆分/合并切换（normal + visual）
        split  = '',     -- 强制拆分（默认禁用）
        join   = '',     -- 强制合并（默认禁用）
      },
      detect = {
        separator = nil,   -- 自定义分隔符（nil = 自动检测逗号等）
        min_width = nil,   -- 小于该宽度不拆（nil = 不限制）
      },
      split = { indent_at_cursor = true },       -- 按光标处缩进对齐拆出的行
      join  = { pad_left = '', pad_right = ' ' }, -- 合并后分隔 padding
    })

    -- mini.surround: add / delete / replace surrounding characters.
    -- `s` prefix was freed by <Nop> in keymaps.lua. All defaults kept explicit:
    --   sa{motion}{char} add (saiw{ -> { word }); S{char} in Visual mode
    --   sd{char} delete; sr{old}{new} replace; sf/sF jump right/left; sh highlight
    --   suffix n/l = next/last occurrence (for nested brackets)
    -- mini.surround：增删改包裹符号。s 前缀由 keymaps.lua 的 <Nop> 腾出。
    -- 下列值均为默认，显式写出便于日后微调：
    --   sa{motion}{符号} 添加（saiw{ -> { word }）；可视模式 S{符号} 添加
    --   sd{符号} 删除；sr{旧}{新} 替换；sf/sF 跳右/左侧包裹符；sh 高亮
    --   后缀 n/l 作用于 next/ast（嵌套括号场景）
    require('mini.surround').setup({
      mappings = {
        add = 'sa',            -- Add surrounding in Norma mode | normal 模式添加
        delete = 'sd',         -- Delete surrounding | 删除包裹
        find = 'sf',           -- Find surrounding (to the right) | 找右侧包裹
        find_left = 'sF',      -- Find surrounding (to the left) | 找左侧包裹
        highlight = 'sh',      -- Highlight surrounding | 高亮包裹
        replace = 'sr',        -- Replace surrounding | 替换包裹

        suffix_last = 'p',     -- Suffix to search with "prev" method | last 后缀
        suffix_next = 'n',     -- Suffix to search with "next" method | next 后缀
      },
    })
  end
}

