-- FILE: lua/plugins/mini.lua
-- INFO: mini.nvim: pairs (auto brackets) + align (text alignment)
--       mini.nvim：括号自动配对 + 文本对齐

return {
  'nvim-mini/mini.nvim',
  version = '*',
  ---------------------------------------------------- config ----------------------------------------------------------
  config = function()
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

