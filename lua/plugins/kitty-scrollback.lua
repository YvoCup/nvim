-- FILE: lua/plugins/kitty-scrollback.lua
-- INFO: Powerful kitty terminal integration plugin
--       强大的 kitty 终端集成插件
--       Enables kitty scrollback + copy/paste integration
--       支持 kitty 复制粘贴功能
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

