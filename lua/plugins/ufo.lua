-- FILE: lua/plugins/ufo.lua
-- INFO: nvim-ufo folding: minimal setup, transparent fold line with icon and line count
--       nvim-ufo 折叠：最小配置，折叠行透明背景 + 图标与行数

----- highlight -----
-- Folded: transparent background, keep foreground readable | 折叠行透明背景，前景保持可读
vim.api.nvim_set_hl(0, "Folded", { bg = "none", fg = "#949ab2" })

-- Fold line text: icon + folded line count, truncated to window width | 折叠行文本：图标 + 行数，超长截断
local function fold_text (virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local suffix = ("  󰁂 %d lines"):format(endLnum - lnum)
  local sufWidth = vim.fn.strdisplaywidth(suffix)
  local targetWidth = width - sufWidth
  local curWidth = 0
  for _, chunk in ipairs(virtText) do
    local chunkText = chunk[1]
    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
    if targetWidth > curWidth + chunkWidth then
      table.insert(newVirtText, chunk)
    else
      chunkText = truncate(chunkText, targetWidth - curWidth)
      local hlGroup = chunk[2]
      table.insert(newVirtText, { chunkText, hlGroup })
      chunkWidth = vim.fn.strdisplaywidth(chunkText)
      -- str width occupied from the left of the current window area | 计算已占用宽度
      if curWidth + chunkWidth < targetWidth then
        suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
      end
      break
    end
    curWidth = curWidth + chunkWidth
  end
  table.insert(newVirtText, { suffix, "MoreMsg" })
  return newVirtText
end

return {
  'kevinhwang91/nvim-ufo',
  dependencies = 'kevinhwang91/promise-async',
  lazy = false,
  ---------------------------------------------------- config ----------------------------------------------------------
  config = function ()
    -- ufo 要求的三个 fold 选项，不设的话折叠层级/默认状态不对
    vim.o.foldcolumn = "0"       -- 不显示折叠列，保持 sign 列干净
    vim.o.foldlevel = 99         -- 默认全部展开
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
    require("ufo").setup({
      fold_virt_text_handler = fold_text,
    })
  end,
  ----------------------------------------------------- keys -----------------------------------------------------------
  keys = {
    {
      "zz",
      "za",
      mode = "n",
      desc = "Toggle fold under cursor | 开关光标处折叠"
    },
  },
}

