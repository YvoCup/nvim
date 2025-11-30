------------------------------------------------------ mapleader -------------------------------------------------------
vim.g.mapleader = " "
local keymap = vim.keymap

-- 分割
keymap.set("n", "|", ":vsplit<CR>")
keymap.set("n", "-", ":split<CR>")

-------------------------------------------------------- nope ----------------------------------------------------------
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
-- 用 no-op 把 `[` 和 `]` 本身映射成空操作
-- 这样任何带前缀的 [[ ]](){} 等全失效
vim.keymap.set({"n","x","o"}, "[", "<Nop>", { noremap = true })
vim.keymap.set({"n","x","o"}, "]", "<Nop>", { noremap = true })

-------------------------------------------------------- move ----------------------------------------------------------
-- 快速移动
keymap.set("n", "<s-k>", "5k")
keymap.set("n", "<s-j>", "5j")
keymap.set("n", "<s-h>", "5h")
keymap.set("n", "<s-l>", "5l")

-- 行首和行尾
keymap.set("n", "[[", "^", { noremap = true, silent = true })
keymap.set("n", "]]", "$", { noremap = true, silent = true })

-- 快速跳转函数或者变量什么的，详细查看 lsp 部分能力


-- 快速跳转段首段落尾
-- <c-l> 本段落段尾（最后一行最后一个非空字符）
vim.keymap.set("n", "<c-l>", function()
  local l = vim.fn.line(".")
  local last = vim.fn.line("$")
  -- 向后找到本段最后一行（下一空行或文件尾为止）
  while l < last and vim.fn.getline(l + 1):find("^%s*$") == nil do
    l = l + 1
  end
  -- 定位到该行行尾
  vim.cmd.normal { args = { l .. "G^" }, bang = true }
end, { noremap = true, silent = true })
-- <c-h> 当前段落段首（本段第一行第一个非空字符）
vim.keymap.set("n", "<c-h>", function()
  local l = vim.fn.line(".")
  -- 向前找到本段第一行（上一空行或文件头为止）
  while l > 1 and vim.fn.getline(l - 1):find("^%s*$") == nil do
    l = l - 1
  end
  -- 定位到该行行首第一个非空字符
  vim.cmd.normal { args = { l .. "G^" }, bang = true }
end, { noremap = true, silent = true })

-- 单词移动
vim.keymap.set("n", "w", "b", { noremap = true, silent = true })
vim.keymap.set("n", "e", "b", { noremap = true, silent = true })

------------------------------------------------------- insert ---------------------------------------------------------
vim.keymap.set("n", "a", "a",     { noremap = true, silent = true })
vim.keymap.set("n", "<s-a>", "i", { noremap = true, silent = true })

------------------------------------------------------- locate ---------------------------------------------------------

-- TODO: 下一个
vim.keymap.set('n', '<leader>h', '<C-w>h', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>j', '<C-w>j', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>k', '<C-w>k', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>l', '<C-w>l', { noremap = true, silent = true })
vim.keymap.set("n", "<leader>q", "<C-w>c", { noremap = true, silent = true })
