vim.api.nvim_set_hl(0, "NotifyBackground",  { bg = "#323647", fg = "#323647" })
vim.api.nvim_set_hl(0, "NotifyERRORBorder", { bg = "none", fg = "#e78284" })
vim.api.nvim_set_hl(0, "NotifyWARNBorder",  { bg = "none", fg = "#d9be88" })
vim.api.nvim_set_hl(0, "NotifyINFOBorder",  { bg = "none", fg = "#7f91cd" })
vim.api.nvim_set_hl(0, "NotifyDEBUGBorder", { bg = "none", fg = "#c1c8e6" })
vim.api.nvim_set_hl(0, "NotifyTRACEBorder", { bg = "none", fg = "#8caaee" })

vim.api.nvim_set_hl(0, "NotifyERRORIcon", { bg = "none", fg = "#e78284" })
vim.api.nvim_set_hl(0, "NotifyWARNIcon",  { bg = "none", fg = "#d9be88" })
vim.api.nvim_set_hl(0, "NotifyINFOIcon",  { bg = "none", fg = "#7f91cd" })
vim.api.nvim_set_hl(0, "NotifyDEBUGIcon", { bg = "none", fg = "#c1c8e6" })
vim.api.nvim_set_hl(0, "NotifyTRACEIcon", { bg = "none", fg = "#8caaee" })

vim.api.nvim_set_hl(0, "NotifyERRORTitle", { bg = "none", fg = "#e78284" })
vim.api.nvim_set_hl(0, "NotifyWARNTitle",  { bg = "none", fg = "#d9be88" })
vim.api.nvim_set_hl(0, "NotifyINFOTitle",  { bg = "none", fg = "#7f91cd" })
vim.api.nvim_set_hl(0, "NotifyDEBUGTitle", { bg = "none", fg = "#c1c8e6" })
vim.api.nvim_set_hl(0, "NotifyTRACETitle", { bg = "none", fg = "#8caaee" })

------------------------------------------- function: show notify with float -------------------------------------------
-- INFO: 一个通用的信息输出手段，将 notify 中的信息以浮动窗口的形式输出出去
-- PARA: notify 需要显示的信息
--
-- local function show_notify_float(notif)
--   -- 如果 notif 是 quickfix 里解析出来的，可能不是 table，需要再查一次
--   if type(notif) ~= "table" or not notif.id then
--     local hist = require("notify").history()
--     for _, n in ipairs(hist) do
--       if n.id == notif.id then
--         notif = n
--         break
--       end
--     end
--   end
--   if not notif or not notif.id then return end
--
--   local opened = require("notify").open(notif)
--   local lines  = vim.o.lines
--   local cols   = vim.o.columns
--   local win = vim.api.nvim_open_win(opened.buffer, true, {
--     relative = "editor",
--     row      = math.floor((lines - opened.height) / 2),
--     col      = math.floor((cols  - opened.width) / 2),
--     width    = opened.width,
--     height   = opened.height,
--     border   = "rounded",
--     style    = "minimal",
--   })
--   vim.fn.setwinvar(win, "&winhl",
--     "Normal:" .. opened.highlights.body .. ",FloatBorder:" .. opened.highlights.border)
--   vim.fn.setwinvar(win, "&wrap", 0)
-- end
--
-- ----------------------------------------- function: notify history to quick fix ----------------------------------------
-- -- INFO: 实现调用一个 qiuck fix 窗口
--
-- local function notify_history_to_qf()
--   local ok, notify = pcall(require, "notify")
--   if not ok then
--     vim.notify("nvim-notify not installed", vim.log.levels.ERROR)
--     return
--   end
--
--   local items = {}
--   for _, msg in ipairs(notify.history()) do
--     local text = type(msg.message) == "table" and table.concat(msg.message, " ") or tostring(msg.message)
--     text = text:gsub("%s+", " ")
--     items[#items + 1] = {
--       filename = "[notify-history]",   -- 特殊标记
--       lnum     = 1,
--       col      = 1,
--       text     = ("[id:%s] %s: %s"):format(msg.id, msg.level:upper(), text),
--       -- 把整条 notify 记录塞到 user_data，后面好取
--       user_data = msg,
--     }
--   end
--   vim.fn.setqflist({}, "r", { title = "notify-history", items = items })
--   vim.cmd "copen"
-- end
--
-- local function show_notify_by_id(id)
--   for _, msg in ipairs(require("notify").history()) do
--     if msg.id == id then
--       local opened = require("notify").open(msg)
--       local lines, cols = vim.o.lines, vim.o.columns
--       local win = vim.api.nvim_open_win(opened.buffer, true, {
--         relative = "editor",
--         row      = math.floor((lines - opened.height) / 2),
--         col      = math.floor((cols  - opened.width) / 2),
--         width    = opened.width,
--         height   = opened.height,
--         border   = "rounded",
--         style    = "minimal",
--       })
--       vim.fn.setwinvar(win, "&winhl",
--         "Normal:" .. opened.highlights.body
--         .. ",FloatBorder:" .. opened.highlights.border)
--       vim.fn.setwinvar(win, "&wrap", 0)
--       return
--     end
--   end
-- end
--
-- local function qf_open_notify()
--   local line = vim.fn.getqflist({ idx = vim.fn.line('.'), items = 0 })
--                .items[vim.fn.line('.')]
--   if not line then return end
--   -- 解析 [id:xxx]
--   local id = line.text:match("^%[id:(%w+)%]")
--   if id then
--     show_notify_by_id(id)
--   end
--   -- 其余情况什么也不做
-- end

---------------------------------------------------------- api ---------------------------------------------------------
-- HACK: 这是一个劫持机制，通过对 FileType 进行检查实现
--       如果模式是 qf，那么回掉函数实现直接替换其中的某些指令，比方说 q 
--
-- vim.api.nvim_create_autocmd('FileType', {
--   pattern = 'qf',
--   callback = function(args)
--     if vim.bo[args.buf].buftype ~= 'quickfix' then return end
--     local w = vim.fn.bufwinid(args.buf)
--     if w == -1 then return end
--
--     local title = vim.w[w].quickfix_title or ''  -- 关键：防 nil
--     local buf = args.buf
--
--     if title:find('^Make') then
--       vim.keymap.set('n', '<CR>', qf_open_notify, { buffer = buf, nowait = true })
--       vim.keymap.set('n', 'q', '<cmd>cclose<CR>', { buffer = buf })
--
--     elseif title:find('notify%-history') then
--       vim.keymap.set('n', '<CR>', function()
--         local ln = vim.fn.line('.')
--         local item = vim.fn.getqflist({ idx = ln, items = 0 }).items[ln]
--         if item and item.user_data then
--           vim.notify(item.user_data.message, item.user_data.level, { timeout = 5000 })
--         end
--       end, { buffer = buf, nowait = true })
--       vim.keymap.set('n', 'q', '<cmd>cclose<CR>', { buffer = buf })
--
--     else  -- 其余任何 qf
--       vim.keymap.set('n', '<CR>', loc_open_notify, { buffer = buf, nowait = true })
--       vim.keymap.set('n', 'q', '<cmd>lclose<CR>', { buffer = buf })
--     end
--   end,
-- })

-- 注册为我的私人的命令
-- vim.api.nvim_create_user_command("YvoCupNotifyHistoryList", notify_history_to_qf, {})

return {
  "rcarriga/nvim-notify",
  event = "VeryLazy",
  config = function()
    require("notify").setup({
      -- NOTE: 此处需要注意必须写死这个，或者写个 highlight 类去实现，不能用 none 代替
      background_colour = "#323647",
      -- 滑入方式的控制，采用预设
      stages = "slide",
      -- 内部的字符的渲染逻辑，采用预设
      render = "default",
    })
  end,
  keys = {
    {
      mode = { "n" },
      "<leader>nt",
      "<cmd>Telescope notify<CR>",
      desc = "set telescop show notufy history"
    },
    {
      mode = { "n" },
      "<leader>nc",
      "<cmd>NotificationsClear<CR>"
    },
    -- {
    --   mode = { "n" },
    --   "<leader>nl",
    --   "<cmd>YvoCupNotifyHistoryList<CR>",
    --   desc = "YvoCup build this qf"
    -- },
    -- {
    --   mode = { "n" },
    --   "<leader>nq",
    --   "<cmd>YvoCupNotifyQuickFix error<CR>",
    --   desc = "YvoCup quickly fix error"
    -- }
  }
}

