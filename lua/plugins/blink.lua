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
    -- Rich multi-color labels for TS-family servers: colorful-menu only gives
    -- a single kind color for vtsls/ts_ls, and in vue buffers it cannot even
    -- derive a parser. Parse the label with the typescript parser directly
    -- and color by treesitter captures instead. Returns nil for non-TS items
    -- or on any parse failure, so callers fall back to colorful-menu.
    -- TS 系 server 的多彩标签：colorful-menu 对 vtsls/ts_ls 只给单色，且在
    -- vue buffer 里推导不出 parser。直接用 typescript parser 解析标签、按
    -- capture 上色。非 TS 项或解析失败返回 nil，由调用方回退 colorful-menu。
    local ts_servers = { vtsls = true, ts_ls = true, ["typescript-tools"] = true }
    local function rich_ts_label(ctx)
      local item = ctx.item
      if item == nil or item.client_id == nil then return nil end
      local client = vim.lsp.get_client_by_id(item.client_id)
      if client == nil or not ts_servers[client.name] then return nil end
      local label = (item.label or ""):gsub("[\r\n].*", "")
      local lang = "typescript"
      local ok, parser = pcall(vim.treesitter.get_string_parser, label, lang)
      if not ok or parser == nil then return nil end
      local query = vim.treesitter.query.get(lang, "highlights")
      if query == nil then return nil end
      local tree = parser:parse(true)[1]
      if tree == nil then return nil end
      local highlights = {}
      for id, node in query:iter_captures(tree:root(), label, 0, -1) do
        local name = "@" .. query.captures[id] .. "." .. lang
        -- Skip meta captures like @spell | 跳过 @spell 之类的元 capture
        if not name:find("^@spell") and not name:find("^@nospell") then
          local sr, sc, er, ec = node:range()
          if sr == er and ec > sc then
            table.insert(highlights, { sc, ec, group = name })
          end
        end
      end
      if #highlights == 0 then return nil end
      local text = label
      if type(item.detail) == "string" and item.detail ~= "" then
        local detail = item.detail:gsub("[\r\n].*", "")
        text = label .. " " .. detail
        table.insert(highlights, { #label + 1, #text, group = "@comment" })
      end
      return { label = text, highlights = highlights }
    end
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
                  -- Prefer rich TS colors, fall back to colorful-menu
                  -- 优先 TS 多彩渲染，失败回退 colorful-menu
                  return (rich_ts_label(ctx) or require("colorful-menu").blink_highlights(ctx) or { label = ctx.label }).label
                end,
                highlight = function(ctx)
                  local highlights_info = rich_ts_label(ctx)
                    or require("colorful-menu").blink_highlights(ctx)
                  local highlights = highlights_info ~= nil and highlights_info.highlights or {}
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
        -- default = { 'lsp', 'snippets', 'path' },  -- Completion sources | 补全来源
        default = { 'lsp', 'path' },  -- Completion sources | 补全来源
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

