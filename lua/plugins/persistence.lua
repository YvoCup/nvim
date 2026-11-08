-- FILE: lua/plugins/persistence.lua
-- INFO: Session management, restricted to git repos under ~/Projects
--       会话管理，仅 ~/Projects 下的 git 仓库启用

-- Check whether the current cwd is allowed to own a session:
-- inside ~/Projects, a git repo, and exactly at the repo root.
-- Returns ok (bool) plus err (reason string, nil when ok).
-- 检查当前目录是否允许拥有会话：在 ~/Projects 内、是 git 仓库、
-- 且正好位于仓库根目录。返回 ok（布尔）和 err（原因字符串，成功时为 nil）。
local function can_save()
  local cwd  = vim.fn.getcwd()
  local root = vim.fn.expand("~/Projects")
  -- boundary check: "/x/ProjectsX" must not match "/x/Projects"
  -- 边界校验："/x/ProjectsX" 不能误判为 "/x/Projects" 的子目录
  if cwd ~= root and cwd:sub(1, #root + 1) ~= root .. "/" then
    return false, "not under ~/Projects"
  end
  -- rev-parse --show-toplevel prints the repo root; non-zero exit = not a repo
  -- rev-parse --show-toplevel 输出仓库根目录；退出码非 0 即不在仓库内
  local obj = vim.system({ "git", "rev-parse", "--show-toplevel" },
    { cwd = cwd, text = true }):wait()
  if obj.code ~= 0 then
    return false, "not a git repo"
  end
  -- save only at the repo root, so one project never gets duplicate
  -- sessions via different subdirectories; resolve() makes symlinked
  -- paths compare equal
  -- 只在仓库根目录保存，同一项目不会从不同子目录产生多条会话；
  -- resolve() 解析软链接，保证比较时路径等价
  if vim.fn.resolve(vim.trim(obj.stdout)) ~= vim.fn.resolve(cwd) then
    return false, "not the repo root"
  end
  return true
end

-- Custom Telescope picker with normal-mode keys.
-- 自定义会话选择器，附带 normal 模式键位。
--
-- Why this works / 原理：
--   1. Telescope decouples a picker into finder (data), sorter (order),
--      attach_mappings (keys). persisted.nvim splits its session entries
--      and actions into public modules — its official extension is just
--      a thin wrapper, so we require the same parts and assemble our own.
--      Telescope 把 picker 解耦为 finder/sorter/attach_mappings；
--      persisted.nvim 把条目与动作拆成公开模块，官方扩展只是薄封装，
--      故可直接 require 同样零件自行组装。
--   2. Each entry is a plain table ({name, file_path, branch, dir_path}).
--      Actions read the fields themselves, so as long as our tables match
--      the plugin's format (list_sessions below), stock actions work as-is.
--      每个条目是普通 table，动作自己读字段；只要 list_sessions 组装的
--      字段与插件一致，原生 action 直接可用。
--   3. attach_mappings is Telescope's official hook. The stock extension
--      only maps insert mode; we add normal mode on top.
--      attach_mappings 是官方预留口，官方只映射 i 模式，这里补 n 模式。
--   4. transform_mod actions support :enhance({ post = fn }): run original
--      logic, then ours — no source edit. refresh() swaps the finder's
--      data source so the list updates after delete/branch/copy.
--      action 自带 :enhance({ post = fn }) 钩子，执行原逻辑后再执行我们的；
--      refresh() 更换 finder 数据源，实现列表即时刷新。
local function sessions_picker()
  local pickers      = require("telescope.pickers")
  local conf         = require("telescope.config").values
  local action_state = require("telescope.actions.state")
  -- the persisted.nvim telescope extension's own modules — public parts
  -- persisted.nvim 的 telescope 扩展模块，相当于公开零件
  local tfinders     = require("telescope._extensions.persisted.finders")
  local tactions     = require("telescope._extensions.persisted.actions")

  -- persisted.list() returns raw path strings; the finder wants session
  -- tables, so apply the same transform as the stock extension
  -- persisted.list() 返回原始路径字符串，finder 需要会话表，
  -- 这里照搬官方扩展的转换逻辑
  local function list_sessions()
    local config = require("persisted.config")
    local sep    = require("persisted.utils").dir_pattern()
    local sessions = {}
    for _, path in pairs(require("persisted").list()) do
      -- display name: strip save_dir prefix, restore "/" from "%",
      -- collapse "~", drop ".vim" (last 4 chars)
      -- 显示名：剥掉存储目录前缀，把 "%" 还原为 "/"，
      -- 折叠 "~"，去掉结尾 ".vim"（4 个字符）
      local name = path:gsub(vim.pesc(config.save_dir), "")
        :gsub("%%", sep):gsub(vim.fn.expand("~"), sep):gsub("//", ""):sub(1, -5)
      local branch, dir_path
      -- file name format is "dir@@branch"; no @@ means no branch
      -- 文件名格式为 "dir@@分支"；没有 @@ 即无分支
      if name:find("@@", 1, true) then
        local splits = vim.split(name, "@@", { plain = true })
        branch   = table.remove(splits, #splits)
        dir_path = table.concat(splits, "@@")
      else
        dir_path = name
      end
      -- the exact field set the plugin's actions expect
      -- 插件 actions 所期望的精确字段集合
      table.insert(sessions, { name = name, file_path = path, branch = branch, dir_path = dir_path })
    end
    return sessions
  end

  -- <CR>: hand the highlighted entry to the plugin's own load action
  -- <CR>：把高亮条目交给插件自带的加载 action
  local function load_selected()
    local entry = action_state.get_selected_entry()
    if entry then tactions.load_session(entry) end
  end

  -- bufnr is only available inside attach_mappings; capture it via upvalue
  -- bufnr 只在 attach_mappings 内可用，通过 upvalue 捕获
  local prompt_bufnr
  -- rebuild entries from disk and swap the finder's data source
  -- 从磁盘重建条目并更换 finder 数据源
  local function refresh()
    local picker = action_state.get_current_picker(prompt_bufnr)
    picker:refresh(tfinders.session_finder(list_sessions()), { reset_prompt = true })
  end

  pickers.new({}, {
    prompt_title = "Sessions",
    finder = tfinders.session_finder(list_sessions()),
    sorter = conf.generic_sorter({}),
    attach_mappings = function(bufnr, map)
      prompt_bufnr = bufnr
      -- run refresh() after each mutating action (decorator, no source edit)
      -- 在每个修改操作后执行 refresh()（装饰器方式，不改源码）
      tactions.delete_session:enhance({ post = refresh })
      tactions.change_branch:enhance({ post = refresh })
      tactions.copy_session:enhance({ post = refresh })
      -- insert mode | 插入模式
      map("i", "<CR>",  load_selected)
      map("i", "<C-d>", tactions.delete_session)
      map("i", "<C-b>", tactions.change_branch)
      map("i", "<C-c>", tactions.copy_session)
      -- normal mode (press <Esc> in the picker to reach it)
      -- normal 模式（在 picker 里按 <Esc> 进入）
      map("n", "<CR>",  load_selected)
      map("n", "d",     tactions.delete_session)
      map("n", "b",     tactions.change_branch)
      map("n", "y",     tactions.copy_session)
      return true -- keep Telescope's default mappings | 保留默认键位
    end,
  }):find()
end

return {
  "olimorris/persisted.nvim",
  event = "BufReadPre",  -- load on first real buffer | 首个真实 buffer 时加载
  lazy = true,
  ---------------------------------------------------- config ----------------------------------------------------------
  config = function()
    -- vim's default includes "terminal"/"blank", which is why terminals and
    -- empty buffers leaked into sessions; keep only useful parts
    -- vim 默认值含 "terminal"/"blank"，终端与空 buffer 曾因此混进会话；
    -- 这里只保留有用的部分
    vim.o.sessionoptions = "buffers,curdir,folds,globals,tabpages,winpos,winsize"

    require("persisted").setup({
      autostart      = true,             -- save on exit | 退出时自动保存
      use_git_branch = true,             -- one session per branch | 按分支分别存会话
      allowed_dirs   = { "~/Projects" }, -- gate auto behaviors | 限制自动行为目录
      -- runs before every save; false skips it. Dir rules live in
      -- can_save, this adds the dashboard rule
      -- 每次保存前调用，返回 false 则跳过。目录规则在 can_save 里，
      -- 这里补 dashboard 前台规则
      should_save = function()
        return vim.fn.bufname() ~= "dashboard" and can_save()
      end,
      -- opts.auto is true only for the automatic exit-save
      -- opts.auto 仅退出自动保存时为 true
      before_save = function(opts)
        -- keep terminals on manual save (:ss), drop them on auto-save
        -- 手动保存（:ss）保留终端，自动保存剔除
        if not opts.auto then return end
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          if vim.bo[buf].buftype == "terminal" then
            vim.api.nvim_buf_delete(buf, { force = true })
          end
        end
      end,
    })
  end,
  ----------------------------------------------------- keys -----------------------------------------------------------
  keys = {
    {
      mode = { "n" },
      "ts",
      sessions_picker,
      desc = "Session list (Telescope) | 会话列表",
    },
    {
      mode = { "n" },
      "ss",
      function()
        local ok, err = can_save()
        if not ok then
          -- say why, so a refused save doesn't feel like a dead key
          -- 说明拒绝原因，避免按键像失灵
          vim.notify("Session not saved: " .. err, vim.log.levels.INFO, { title = "Sessions" })
        else
          require("persisted").save()
        end
      end,
      desc = "Save session (repo root only) | 保存会话（仅仓库根目录）",
    },
    {
      mode = { "n" },
      "st",
      function()
        -- vim.g.persisting: nil = never started, true = recording, false = stopped
        -- vim.g.persisting：nil 未启动，true 记录中，false 已停止
        local flag = vim.g.persisting
        local persisted = require("persisted")
        if flag == nil then
          persisted.load()
          vim.notify("Session loaded", vim.log.levels.INFO, { title = "Sessions" })
        elseif flag then
          -- stop keeps the existing file, just stops overwriting it
          -- 停止只是不再覆盖，已有会话文件保留
          persisted.stop()
          vim.notify("Session recording stopped", vim.log.levels.INFO, { title = "Sessions" })
        else
          persisted.start()
          vim.notify("Session recording started", vim.log.levels.INFO, { title = "Sessions" })
        end
      end,
      desc = "Toggle session recording | 切换会话记录",
    },
  },
}

