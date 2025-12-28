-- mapleader
vim.g.mapleader = " "
local keymap = vim.keymap

-- split
keymap.set("n", "|", ":vsplit<CR>")
keymap.set("n", "-", ":split<CR>")

-- nop
-- 删除一些不必要容易引起麻烦的键
keymap.set("n", "s", "<Nop>")
keymap.set("n", "S", "<Nop>")
keymap.set("n", "r", "<Nop>")
keymap.set("n", "q", "<Nop>")
keymap.set("n", "i", "<Nop>")
keymap.set("n", "I", "<Nop>")
keymap.set("n", "G", "<Nop>")
keymap.set("n", "^", "<Nop>")
keymap.set("n", "$", "<Nop>")
keymap.set('n', 'K', "<Nop>")
keymap.del('n', 'grr')
keymap.del('n', 'grn')
keymap.del('n', 'grt')
keymap.del('n', 'gra')
keymap.del('x', 'gra')
keymap.del('n', 'gri')
-- 用 no-op 把 `[` 和 `]` 本身映射成空操作
-- 这样任何带前缀的 [[ ]](){} 等全失效
keymap.set({ "n", "x", "o" }, "[", "<Nop>", { noremap = true })
keymap.set({ "n", "x", "o" }, "]", "<Nop>", { noremap = true })

-- move
-- 快速移动
keymap.set("n", "<s-k>", "5k")
keymap.set("n", "<s-j>", "5j")
keymap.set("n", "<s-h>", "5h")
keymap.set("n", "<s-l>", "5l")

-- 行首和行尾
keymap.set("n", "[[", "^", { noremap = true, silent = true })
keymap.set("n", "]]", "$", { noremap = true, silent = true })

-- 取消高亮的快捷选项
keymap.set("n", "<leader>nh", "<cmd>noh<cr>", { noremap = true, silent = true })

-- 单词移动
vim.keymap.set("n", "w", "b", { noremap = true, silent = true })
vim.keymap.set("n", "e", "b", { noremap = true, silent = true })

-- 进入插入模式
vim.keymap.set("n", "a", "a", { noremap = true, silent = true })
vim.keymap.set("n", "<s-a>", "i", { noremap = true, silent = true })

-- locate 定位
vim.keymap.set('n', '<leader>h', '<C-w>h', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>j', '<C-w>j', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>k', '<C-w>k', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>l', '<C-w>l', { noremap = true, silent = true })
vim.keymap.set("n", "<leader>q", "<C-w>c", { noremap = true, silent = true })

-- 撤销与重做
vim.keymap.set("n", "<s-u>", "<c-r>", { noremap = true, silent = true })
vim.keymap.set("n", "<c-u>", "<c-r>", { noremap = true, silent = true })
