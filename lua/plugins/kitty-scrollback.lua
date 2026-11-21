-- FILE: lua/plugins/kitty-scrollback.lua
-- INFO: Kitty terminal integration: scrollback & copy/paste
--       kitty 终端集成：滚动回溯与复制粘贴

return {
  'mikesmithgh/kitty-scrollback.nvim',
  enabled = true,
  lazy = true,
  cmd = { 'KittyScrollbackGenerateKittens', 'KittyScrollbackCheckHealth', 'KittyScrollbackGenerateCommandLineEditing' },
  event = { 'User KittyScrollbackLaunch' },
  ---------------------------------------------------- config ----------------------------------------------------------
  config = function()
    -- Scrollback-only instance: set UI defaults before window creation, no flicker
    -- 此实例只承载回溯 buffer，在窗口创建前设好默认值，避免启动闪烁
    vim.opt.number = false
    vim.opt.relativenumber = false
    vim.opt.signcolumn = 'no'
    vim.opt.statuscolumn = ''
    -- Map y to system clipboard in scrollback buffer | 回溯 buffer 中 y 直接复制到系统剪贴板
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'kitty-scrollback',
      callback = function(ev)
        vim.keymap.set({ 'n', 'v' }, 'y', '"+y', { buffer = ev.buf })
      end,
    })
  end,
}

