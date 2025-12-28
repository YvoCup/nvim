return {
  'nvim-mini/mini.nvim',
  version = '*',
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
      -- HACK: 每一次使用都有三个属性：split, justify, merge
      --       split 表示分割方式，justify 表示对其左中右，merge 表示插入符号
    })
  end
}
