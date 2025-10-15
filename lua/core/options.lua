local opt = vim.opt
opt.termguicolors = true

-- 编码格式
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

-- 行号
opt.numberwidth = 1
opt.relativenumber = false
opt.number = true
opt.cursorline = true

-- 防止包裹
opt.wrap = true

-- 光标行
opt.relativenumber = true   -- 只保留相对行号

-- 启用鼠标
opt.mouse:append("a")

-- 系统剪切板
opt.clipboard:append("unnamedplus")

-- 设置 signcolumn 始终显示，可以根据需要更改这个设置
opt.signcolumn = "yes:1"
vim.api.nvim_set_hl(0, "SignColumn", {bg = none})

-- 默认新窗口右和下
opt.splitright = true
opt.splitbelow = true

-- 设置 Neovim 窗口分割线的字符
-- `vert` 选项设置垂直分割线的字符
-- `hor` 选项设置水平分割线的字符
-- `eob` 表示余下的没有代码部分的符号
vim.o.fillchars = "vert:│,horiz:─,eob: "

-- 禁用 foldcolumn
vim.opt.foldcolumn = '0'

-- 设置默认 tab 为两个空格
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
-- 文件类型 -> 缩进宽度
-- 想加新类型直接往表里写一行即可
local ft_indent = {
  python     = 4,
  java       = 2,
  lua        = 2,
  html       = 2,
  javascript = 2,
  xml        = 2,
}
for ft, width in pairs(ft_indent) do
  vim.api.nvim_create_autocmd("FileType", {
    pattern = ft,
    callback = function()
      vim.bo.shiftwidth  = width
      vim.bo.tabstop     = width
      vim.bo.expandtab   = true
    end,
  })
end
