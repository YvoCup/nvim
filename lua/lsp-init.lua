vim.lsp.enable("lua_ls")
vim.lsp.enable("clangd")
vim.lsp.enable("neocmake")
vim.lsp.enable("vue_ls")
vim.lsp.enable("ts_ls")
vim.lsp.enable("cssls")
vim.lsp.enable("html")
vim.lsp.enable("bashls")
vim.lsp.enable("rust_analyzer")
vim.lsp.enable("jsonls")
vim.lsp.enable("yamlls")

vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#656c87", bg = "none" })
vim.api.nvim_set_hl(0, 'DiagnosticError', { fg = '#e78284', bold = true })
vim.api.nvim_set_hl(0, 'DiagnosticWarn',  { fg = '#e5c890', bold = true })
vim.api.nvim_set_hl(0, 'DiagnosticInfo',  { fg = '#79bdb3', bold = true })
vim.api.nvim_set_hl(0, 'DiagnosticHint',  { fg = '#9cc480', bold = true })

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("SetupLSP", {}),
  callback = function(event)
    -- 获取客户端
    local client = vim.lsp.get_client_by_id(event.data.client_id)

    -- client.server_capabilities.hoverProvider = nil
    -- client.server_capabilities.signatureHelpProvider = nil

    -- [folding]
    if client and client:supports_method 'textDocument/foldingRange' then
      local win = vim.api.nvim_get_current_win()
      vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
    end

    -- 启用虚拟文本，也就是报错之后在每一行末尾展现的东西
    vim.diagnostic.config({
      virtual_text = true,
      float = {
        source = true,
        border = "rounded",
        header = nil,
      },
    })

    -- keymaps
    vim.keymap.set("n", "gj", function() vim.diagnostic.jump({count = 1})  end, { buffer = event.buf })
    vim.keymap.set("n", "gk", function() vim.diagnostic.jump({count = -1}) end, { buffer = event.buf })

    vim.keymap.set('n', "ga", function()
      vim.diagnostic.open_float()
    end, { buffer = event.buf, desc = 'LSP: Show Diagnostic' })

    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then  -- [inlay hint]
      vim.keymap.set('n', 'gi', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
      end, { buffer = event.buf, desc = 'LSP: Toggle Inlay Hints' })
    end

    vim.keymap.set("n", "gh", function ()
      vim.lsp.buf.hover({ border = "rounded" })
    end, { buffer = event.buf, desc = 'LSP: vim.lsp.buf.hover' })

    vim.keymap.set("n", "gr", function ()
      vim.lsp.buf.rename()
    end, { buffer = event.buf, desc = 'LSP: vim.lsp.buf.rename' })
  end
})

