-- FILE: lua/core/statuscolumn.lua
-- INFO: 主要实现了如下功能：
--       对特殊状态栏图标的排序，排序过程分为了左中右三个部分
--       主要依靠高亮组进行图标抓取工作，并重新返回应得的图标
--       因为是手动控制制作的，因此行号需要重新写相对行号

------------------------------------------------ get git current number ------------------------------------------------
-- INFO: 由真实行号和虚拟行号组成，虚拟行号会被用特殊字符代替
-- PARA: lnum: 真实行号
--       virtnum: 虚拟行号
local function render_number(lnum, virtnum)
  -- 折叠虚行：只给占位符
  if virtnum ~= 0 then
    local w = lnum <= 1 and 1 or math.ceil(math.log10(lnum))
    return (" "):rep(w - 1) .. (virtnum > 0 and "┆" or " ")
  end
  -- 当前行吗？
  local is_cursor = lnum == vim.api.nvim_win_get_cursor(vim.g.statusline_winid)[1]
  -- v:relnum 在光标行总是 0，在其他行就是相对值
  local num = is_cursor and lnum .. " " or " " .. vim.v.relnum
  return num
end

-------------------------------------------------- get signs columns ---------------------------------------------------
-- PARA: bufnr: 渲染工作的 buffer
--       lnum: 获取当前渲染行，是劫持的基础
--       name: 劫持的高亮字符中通用部分
local function get_signs(bufnr, lnum, name)
  -- 拿到这一行所有的 extmark（sign）
  local marks = vim.api.nvim_buf_get_extmarks(
    bufnr, -1, {lnum, 0}, {lnum, -1},
    {details = true, type = "sign"}
  )
  -- HACK: 找第一个属于 GitSign 的 mark
  --       mark 会返回如下格式
  --       {
  --         extmark_id,            -- [1] 内部 id
  --         lnum,                  -- [2] 行号（0-index）
  --         col,                   -- [3] 列号（0-index）
  --         {                      -- [4] details 表
  --           sign_text   = "┃",   -- 2 字符以内的图标
  --           sign_hl_group = "GitSignAdd",
  --           priority    = 10,    -- 同列冲突时谁靠前
  --                                -- 还可能 end_row/end_col 等
  --         }
  --      }
  local mark = vim.iter(marks):find(
    function(item)
      return item[2] == lnum
        and item[4].sign_hl_group
        and item[4].sign_hl_group:find(name)
    end
  )
  -- 没找到就留两个空格，必须是两个否则可能会拥挤
  if not mark then
    return "  "
  end
  -- 用 mark 自带的高亮组和文字
  return ("%%#%s#%s%%*"):format(
    mark[4].sign_hl_group,
    mark[4].sign_text
  )
end

----------------------------------------------------- return stc -------------------------------------------------------
-- INFO: 实现整理并输出
local function stc()
  local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
  local lnum, virtnum = vim.v.lnum, vim.v.virtnum
  return ("%s%%=%s%s"):format(
    get_signs(bufnr, lnum - 1, "Todo"),
    render_number(lnum, virtnum),
    get_signs(bufnr, lnum - 1, "GitSign")
  )
end

return { stc = stc }
