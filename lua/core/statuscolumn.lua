------------------------------------------------ get git current number ------------------------------------------------
local function show_break(lnum, virtnum)
  if virtnum > 0 then
    return (' '):rep(math.floor(math.ceil(math.log10(lnum))) - 1) .. '┆'
  end
  return virtnum < 0 and '' or lnum
end

------------------------------------------------ get git signs columns -------------------------------------------------
-- @parms - bufnr: 是当前 buffer 的句柄，表示在当前 buffer 渲染
--        - lnum: 表示当前的行号
local function get_git_signs(bufnr, lnum)
  -- 拿到这一行所有的 extmark（sign）
  local marks = vim.api.nvim_buf_get_extmarks(
    bufnr, -1, {lnum, 0}, {lnum, -1},
    {details = true, type = 'sign'}
  )

  -- 找第一个属于 GitSign 的 mark
  -- mark 会返回如下格式
  -- {
  --   extmark_id,            -- [1] 内部 id
  --   lnum,                  -- [2] 行号（0-index）
  --   col,                   -- [3] 列号（0-index）
  --   {                      -- [4] details 表
  --     sign_text   = '┃',   -- 2 字符以内的图标
  --     sign_hl_group = 'GitSignAdd',
  --     priority    = 10,    -- 同列冲突时谁靠前
  --                          -- 还可能 end_row/end_col 等
  --   }
  --}
  local mark = vim.iter(marks):find(
    function(item)
      return item[2] == lnum
        and item[4].sign_hl_group
        and item[4].sign_hl_group:find('GitSign')
    end
  )
  -- 没找到就留两个空格，一个是没有的时候做的
  if not mark then
    return '  '
  end
  -- 用 mark 自带的高亮组和文字
  return ('%%#%s#%s%%*'):format(
    mark[4].sign_hl_group, -- 例如 GitSignAdd
    mark[4].sign_text      -- 例如  │
  )
end

------------------------------------------------ get git signs columns -------------------------------------------------
-- @parms - bufnr: 是当前 buffer 的句柄，表示在当前 buffer 渲染
--        - lnum: 表示当前的行号
local function get_todo_signs(bufnr, lnum)
  local marks = vim.api.nvim_buf_get_extmarks(
    bufnr, -1, {lnum, 0}, {lnum, -1},
    {details = true, type = 'sign'}
  )
  local mark = vim.iter(marks):find(
    function(item)
      return item[2] == lnum
        and item[4].sign_hl_group
        and item[4].sign_hl_group:find('Todo')
    end
  )
  if not mark then
    return '  '
  end
  -- 用 mark 自带的高亮组和文字
  return ('%%#%s#%s%%*'):format(
    mark[4].sign_hl_group,
    mark[4].sign_text
  )
end

----------------------------------------------------- return stc -------------------------------------------------------
local function stc()
  local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
  local lnum, virtnum = vim.v.lnum, vim.v.virtnum
  return ('%s%%=%s%s'):format(
    get_todo_signs(bufnr, lnum - 1),
    show_break(lnum, virtnum),
    get_git_signs(bufnr, lnum - 1)
  )
end

return { stc = stc }
