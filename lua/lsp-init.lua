-- FILE: ./lua/lsp-init.lua
-- INFO: lsp 配置部分，集合了启动、客户端配置、高亮以及快捷键配置方案

------------------------------------------------ highlight ---------------------------------------------------
vim.api.nvim_set_hl(0, "FloatBorder",     { fg = "#656c87" })
vim.api.nvim_set_hl(0, 'DiagnosticError', { fg = '#e78284', bold = true })
vim.api.nvim_set_hl(0, 'DiagnosticWarn',  { fg = '#e5c890', bold = true })
vim.api.nvim_set_hl(0, 'DiagnosticInfo',  { fg = '#79bdb3', bold = true })
vim.api.nvim_set_hl(0, 'DiagnosticHint',  { fg = '#9cc480', bold = true })

---------------------------------------------- enable lanugage -----------------------------------------------
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
vim.lsp.enable("eslint")
vim.lsp.enable("pylsp")

---------------------------------------------- general configs -----------------------------------------------
-- 通用配置中包含了部分快捷键配置操作
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("SetupLSP", {}),
  callback = function(event)
    -- 获取客户端
    local client = vim.lsp.get_client_by_id(event.data.client_id)

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
    -- fast jump to the next/previous diagnostic
    vim.keymap.set("n", "gj", function() vim.diagnostic.jump({ count = 1  }) end, { buffer = event.buf })
    vim.keymap.set("n", "gk", function() vim.diagnostic.jump({ count = -1 }) end, { buffer = event.buf })

    -- code action
    vim.keymap.set('n', "ga", function()
      vim.diagnostic.open_float()
    end, { buffer = event.buf, desc = 'LSP: Show Diagnostic' })

    -- inlay hint
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
      vim.keymap.set('n', 'gi', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
      end, { buffer = event.buf, desc = 'LSP: Toggle Inlay Hints' })
    end

    -- hover
    vim.keymap.set("n", "gh", function()
      vim.lsp.buf.hover({ border = "rounded" })
    end, { buffer = event.buf, desc = 'LSP: vim.lsp.buf.hover' })

    -- rename
    vim.keymap.set("n", "gr", function()
      vim.lsp.buf.rename()
    end, { buffer = event.buf, desc = 'LSP: vim.lsp.buf.rename' })

    -- INFO: 
  end
})

-- format 部分，这部分暂时就先别写了
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   callback = function()
--     local mode = vim.api.nvim_get_mode().mode
--     local filetype = vim.bo.filetype
--     if vim.bo.modified == true and mode == 'n' and filetype ~= "oil" then
--       vim.cmd('lua vim.lsp.buf.format()')
--     else
--     end
--   end
-- })

