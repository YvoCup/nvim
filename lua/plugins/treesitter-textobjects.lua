-- FILE: lua/plugins/treesitter-textobjects.lua
-- INFO: Treesitter semantic text objects: whole function/class, param swap
--       treesitter 语义文本对象：整个函数/类、参数交换

return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  branch = "main",        -- main = standalone setup API | main 分支为独立 setup 接口
  event = "VeryLazy",     -- Load after treesitter | 在 treesitter 之后加载
  ---------------------------------------------------- config ----------------------------------------------------------
  config = function()
    require("nvim-treesitter-textobjects").setup({
      select = {
        -- auto jump to the next object when cursor is not on one
        -- 光标不在对象上时自动跳到下一个（targets.vim 行为）
        lookahead = true,
        -- include surrounding whitespace: daf takes the trailing blank line too
        -- 含周边空白：daf 删除函数时连后面的空行一起带走
        include_surrounding_whitespace = true,
      },
    })

    local select = require("nvim-treesitter-textobjects.select")

    -- Direct if/af mappings override mini.ai's f (function call) via vim's
    -- longest-match rule; only f is affected, other mini.ai objects unchanged.
    -- For selecting a call's arguments use vi( instead of the old vif.
    -- 直接映射 if/af 借 vim 最长匹配规则覆盖 mini.ai 的 f（函数调用），
    -- 其余 mini.ai 对象不受影响；选调用参数改用 vi(。
    local function map_tobj(keys, query)
      vim.keymap.set({ "x", "o" }, keys, function()
        select.select_textobject(query, "textobjects")
      end, { desc = "select " .. query .. " | 选择文本对象" })
    end

    map_tobj("if", "@function.inner")   -- function body | 函数体
    map_tobj("af", "@function.outer")   -- whole function | 整个函数定义
    map_tobj("ic", "@class.inner")      -- class body | 类体
    map_tobj("ac", "@class.outer")      -- whole class | 整个类
  end,
  ----------------------------------------------------- keys -----------------------------------------------------------
  keys = {
    {
      mode = { "n" },
      "ipn",
      function ()
        require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner")
      end,
      desc = "swap param with next | 与后一个参数交换",
    },
    {
      mode = { "n" },
      "ipp",
      function ()
        require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.inner")
      end,
      desc = "swap param with previous | 与前一个参数交换",
    }
  }
}

