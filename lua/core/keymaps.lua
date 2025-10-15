vim.g.mapleader = " "
local keymap = vim.keymap

-- 分割
keymap.set("n", "|", ":vsplit<CR>")
keymap.set("n", "-", ":split<CR>")

-- 删除一些不必要容易引起麻烦的键
keymap.set("n", "s", "<Nop>")
keymap.set("n", "S", "<Nop>")
keymap.set("n", "r", "<Nop>")
keymap.set("n", "q", "<Nop>")
keymap.set("n", "i", "<Nop>")
keymap.set("n", "I", "<Nop>")
keymap.set("n", "G", "<Nop>")
