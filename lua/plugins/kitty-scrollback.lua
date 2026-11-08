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
  -- version = '*',       -- Latest stable; may break on major bumps | 最新稳定版
  -- version = '^6.0.0',  -- Pin major, fixes & features only | 锁定 major 版本
  config = function()
    require('kitty-scrollback').setup()
  end,
}

