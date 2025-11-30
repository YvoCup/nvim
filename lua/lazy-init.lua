-- 1. 准备 lazy.nvim 模块（存在性检测）
-- stdpath("data")
-- macOS/Linux: ~/.local/share/nvim
-- Windows: ~/AppData/Local/nvim-data
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

-- 2. 将 lazypath 设置为运行时路径
-- rtp（runtime path）
-- nvim进行路径搜索的时候，除已有的路径，还会从prepend的路径中查找
-- 否则，下面 require("lazy") 是找不到的
vim.opt.rtp:prepend(lazypath)

-- 3. 加载 lazy.nvim 模块
require("lazy").setup("plugins")

-- 4. lazy.nvim 模块的高亮设置
-- 背景
vim.api.nvim_set_hl(0, "LazyNormal", { bg = "#51576d", fg = "#a0acda" })
-- 标题
vim.api.nvim_set_hl(0, "LazyH1", { bg = "#909bb8", fg = "#d2e0fd", bold = true })  -- HOME
vim.api.nvim_set_hl(0, "LazyH2", { fg = "#d2e0fd", bold = true })  -- 主要是 total 之类的
-- 按钮部分，按钮的高亮和 H1 一致
vim.api.nvim_set_hl(0, "LazyButtonActive", { bg = "#909bb8", fg = "#d2e0fd", bold = true })
vim.api.nvim_set_hl(0, "LazyButton",       { fg = "#777e9e" })
-- 内容
vim.api.nvim_set_hl(0, "LazyProp",       { fg = "#5f73aa" })  -- 信息中前面部分，一般是 dir 之类的
vim.api.nvim_set_hl(0, "LazyDimmed",     { fg = "#b5bfe2" })  -- 信息中内容，一般在 git 中展示
vim.api.nvim_set_hl(0, "LazyValue",      { fg = "#e5c890" })  -- 一些信息，主要是 version, tag 之类的
vim.api.nvim_set_hl(0, "LazyTaskOutput", { fg = "#b5bfe2" })  -- 
vim.api.nvim_set_hl(0, "LazyComment",    { fg = "#a6d189" })  -- 注释
vim.api.nvim_set_hl(0, "LazyUrl", { fg = "#8caaee" })  -- url 内容
vim.api.nvim_set_hl(0, "LazyDir", { fg = "#a9c1f4" })  -- dir 内容

vim.api.nvim_set_hl(0, "LazyCommit",      { fg = "#b07da5" })  -- commit 内容
vim.api.nvim_set_hl(0, "LazySpecial",     { fg = "#80869c" })  -- 特殊字符
