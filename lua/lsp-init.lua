vim.lsp.enable("lua_ls")
vim.lsp.enable("clangd")

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
  callback = function(event)
    -- 获取客户端
    local client = vim.lsp.get_client_by_id(event.data.client_id)

    -- 启用虚拟文本，也就是报错之后在每一行末尾展现的东西
    vim.diagnostic.config {
      virtual_text = true,
    }

    -- keymaps
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = event.buf })
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = event.buf })
  end
})
