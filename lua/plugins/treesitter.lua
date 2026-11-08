-- FILE: lua/plugins/treesitter.lua
-- INFO: Treesitter parser manager (Neovim 0.12+ handles highlighting itself)
--       treesitter parser 管理器（0.12+ 高亮由 Neovim 内置接管）

return {
  "nvim-treesitter/nvim-treesitter",
  -- :TSInstall all = install every parser (old ensure_installed = "all").
  -- Already-installed parsers are a no-op, so this is safe to re-run.
  -- :TSInstall all 安装全部 parser（等价旧 ensure_installed = "all"）；
  -- 已安装的自动跳过，可反复执行。
  build = ":TSInstall all",
  branch = "main",        -- Use the main branch | 使用主分支
  event = "VeryLazy",     -- Lazy load | 懒加载
  ---------------------------------------------------- config ----------------------------------------------------------
  config = function ()
    -- NOTE: the main branch is a rewrite; setup() only accepts install_dir.
    --       Old module keys (highlight/indent/incremental_selection) are
    --       silently ignored and must NOT be re-added. Highlight is started
    --       by core/options.lua; indent is enabled per-buffer below.
    -- NOTE: main 分支是重写版，setup() 只接受 install_dir；旧模块键
    --       （highlight/indent/incremental_selection）被静默忽略，勿再加回。
    --       高亮由 core/options.lua 启动；缩进在下面按 buffer 启用。
    require("nvim-treesitter").setup()

    -- Enable treesitter-powered indent (= re-indent) for every buffer.
    -- Highlight is handled in core/options.lua FileType autocmd.
    -- 为每个 buffer 启用 treesitter 缩进（= 重排）；高亮在 options.lua。
    vim.api.nvim_create_autocmd("FileType", {
      callback = function()
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })

    -- Start treesitter highlighting for every buffer; no-op if already
    -- running. Moved here from core/options.lua so all treesitter setup
    -- lives in one file.
    -- 为每个 buffer 启动 treesitter 高亮；已启动则跳过。
    -- 从 core/options.lua 移至此处，treesitter 相关集中管理。
    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        pcall(vim.treesitter.start, args.buf)
      end,
    })
  end
}

