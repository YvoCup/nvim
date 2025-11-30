-- FILE: lua/plugins/blink.lua
-- INFO: 提示符

----------------------------------------------------- highlight --------------------------------------------------------
-- vim.api.nvim_set_hl(0, "BlinkCmpMenu",  { fg = "#527a89" })
vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder",       { bg = "#323647", fg = "#656c87" })
vim.api.nvim_set_hl(0, "BlinkCmpMenuSelection",    { bg = "#4c5267" })
-- vim.api.nvim_set_hl(0, "BlinkCmpLabel",  { fg = "#7a809b" })
-- vim.api.nvim_set_hl(0, "BlinkCmpLabelDeprecated",  { fg = "#7a809b", underline = true, italic = true })
-- vim.api.nvim_set_hl(0, "BlinkCmpLabelMatch",  { fg = "#80a2ec" })
--
-- vim.api.nvim_set_hl(0, "BlinkCmpLabelDetail",  { fg = "#123456" })
-- vim.api.nvim_set_hl(0, "BlinkCmpLabelDescription",  { fg = "#523456" })
-- vim.api.nvim_set_hl(0, "BlinkCmpKind",  { fg = "#923456" })
-- vim.api.nvim_set_hl(0, "BlinkCmpKindFunction",  { fg = "#723456" })

return {
  "saghen/blink.cmp",
  -- dependencies = { "archie-judd/blink-cmp-words" },
  version = "1.*",
  event = { "BufReadPost", "BufNewFile" },
  ---------------------------------------------------- config ----------------------------------------------------------
  config = function()
    require("blink.cmp").setup({
      cmdline = { enabled = false },
      completion = {
        ghost_text = { enabled = false },
        keyword = {
          range = "full",  -- 控制光标的检查范围，此处会检查前后所有的信息生成
        },
        menu = {
          border = "rounded",  -- 圆框
          draw = {
            -- treesitter = {  },
            -- scrollbar = false,  -- 删除滚动条
            columns = {
              -- { "label", "label_description", gap = 1 },
              -- { "kind_icon", gap = 1 },
              -- { "source_name", gap = 1 , width = { fill = true }},
              { "kind_icon" }, { "label", gap = 1 }
            },
            components = {
              label = {
                width = { fill = true, max = 60 },
                -- 这个给予了文本的一些补充
                text = function(ctx)
                  local highlights_info = require("colorful-menu").blink_highlights(ctx)
                  if highlights_info ~= nil then
                    -- Or you want to add more item to label
                    return highlights_info.label
                  else
                    return ctx.label
                  end
                end,
                highlight = function(ctx)
                  local highlights = {}
                  local highlights_info = require("colorful-menu").blink_highlights(ctx)
                  if highlights_info ~= nil then
                    highlights = highlights_info.highlights
                  end
                  for _, idx in ipairs(ctx.label_matched_indices) do
                    table.insert(highlights, { idx, idx + 1, group = "BlinkCmpLabelMatch" })
                  end
                  -- Do something else
                  return highlights
                end,
              },
              kind_icon = {
                width = { fill = true, max = 60 },
                  highlight = function(ctx)
                  local highlights = {}
                  local highlights_info = require("colorful-menu").blink_highlights(ctx)
                  if highlights_info ~= nil then
                    highlights = highlights_info.highlights
                  end
                  for _, idx in ipairs(ctx.label_matched_indices) do
                    table.insert(highlights, { idx, idx + 1, group = "BlinkCmpLabelMatch" })
                  end
                  -- Do something else
                  return highlights
                end,
              },
            },
          },
        },
      },
      sources = {
        -- 会显示的补全来源
        default = { 'snippets', 'lsp', 'path' },
        providers = {
          snippets = { score_offset = 1000 },
        },
      },
      ------------------------------------------------- keys -----------------------------------------------------------
      keymap = {
        preset = 'default',
        -- 弹窗里 Tab 选下一条，没弹窗时 fallback 到原 Tab
        ['<Tab>'] = { 'select_next', 'fallback' },
        -- Shift-Tab 选上一条
        ['<S-Tab>'] = { 'select_prev', 'fallback' },
        -- 回车确认补全
        ['<CR>'] = { 'accept', 'fallback' },
      },
    })
  end,
}

