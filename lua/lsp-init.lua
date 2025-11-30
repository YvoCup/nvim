vim.lsp.enable("luau_lsp")
vim.lsp.enable("lua_ls")
vim.lsp.enable("clangd")
vim.lsp.enable("neocmake")

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("SetupLSP", {}),
  callback = function(event)
    -- 获取客户端
    local client = vim.lsp.get_client_by_id(event.data.client_id)

    -- [inlay hint]
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
      vim.keymap.set('n', 'gl', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
      end, { buffer = event.buf, desc = 'LSP: Toggle Inlay Hints' })
    end

    -- [folding]
    if client and client:supports_method 'textDocument/foldingRange' then
      local win = vim.api.nvim_get_current_win()
      vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
    end

    -- 启用虚拟文本，也就是报错之后在每一行末尾展现的东西
    vim.diagnostic.config {
      virtual_text = true,
      float = {
        source = true,
        border = "rounded",
        title  = nil,
      },
    }

    -- keymaps
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = event.buf })
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = event.buf })
    vim.keymap.set('n', "ga", function()
      vim.diagnostic.open_float()
    end, { buffer = event.buf, desc = 'LSP: Show Diagnostic' })
  end
})

