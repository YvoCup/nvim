-- FILE: lua/plugins/blink.lua
-- INFO: Completion popup menu: https://github.com/saghen/blink.cmp
--       提示符框

----------------------------------------------------- highlight --------------------------------------------------------
-- vim.api.nvim_set_hl(0, "BlinkCmpMenu",  { fg = "#527a89" })
vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder",          { bg = "none", fg = "#656c87" })
vim.api.nvim_set_hl(0, "BlinkCmpMenuSelection",       { bg = "#4c5267" })
vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelpBorder", { bg = "none", fg = "#656c87" })

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
        keyword = { range = "prefix", }, -- Prefix match only | 仅前缀匹配
        documentation = {
          window = {
            border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
            scrollbar = false,
          },
        },
        menu = {
          border = "rounded",  -- Rounded border | 圆框
          scrollbar = false,
          draw = {
            -- treesitter = {  },
            -- scrollbar = false,  -- Remove scrollbar | 删除滚动条
            columns = {
              -- { "label", "label_description", gap = 1 },
              -- { "kind_icon", gap = 1 },
              -- { "source_name", gap = 1 , width = { fill = true }},
              { "kind_icon" }, { "label", gap = 1 }
            },
            components = {
              label = {
                width = { fill = true, max = 60 },
                -- Extra rendering (colors/types) via colorful-menu
                -- 借助 colorful-menu 渲染文本
                text = function(ctx)
                  local highlights_info = require("colorful-menu").blink_highlights(ctx)
                  if highlights_info ~= nil then
                    -- Use colorful-menu's highlight info as the label text
                    -- 用 colorful-menu 的高亮信息替换原文本
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
                  -- Return the merged highlight list
                  -- 返回合并后的高亮列表
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
                  -- Return the merged highlight list
                  -- 返回合并后的高亮列表
                  return highlights
                end,
              },
            },
          },
        },
      },
      signature = {
        enabled = true,
        window = {
          border = "rounded",
        },
      },
      sources = {
        default = { 'snippets', 'lsp', 'path' },  -- Completion sources | 补全来源
        providers = {
          snippets = { score_offset = 1000 },
        },
      },
      keymap = {
        preset      = 'default',
        -- <Tab>: next item, fall back when no popup
        -- 弹窗里 Tab 选下一条，没弹窗时 fallback
        ['<Tab>']   = { 'select_next', 'fallback' },
        -- <S-Tab>: previous item | 弹窗里选上一条
        ['<S-Tab>'] = { 'select_prev', 'fallback' },
        ['<CR>']    = { 'accept', 'fallback' },   -- Accept completion | 回车确认补全
        -- Toggle signature help inside function args
        -- 函数参数中显示/隐藏参数信息
        ['<C-h>']   = { 'show_signature', 'hide_signature', 'fallback' },
      },
    })
  end,
}

