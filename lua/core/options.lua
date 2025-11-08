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

-- 将下面的命令行隐藏起来
vim.o.cmdheight = 0

-- HACK: 这是实现左侧栏的按照逻辑位置进行工作的函数，基于此再拓展即可
opt.stc = '%!v:lua.require("core.statuscolumn").stc()'

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
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
-- 文件类型 -> 缩进宽度
-- 想加新类型直接往表里写一行即可，只对必须非两个的进行书写
local ft_indent = {
  python = 4,
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

