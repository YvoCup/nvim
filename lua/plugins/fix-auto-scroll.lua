-- FILE: lua/plugins/fix-auto-scroll.lua
-- INFO: Fix unwanted auto-scroll on cursorhold etc.
--       修复光标停留时自动滚动的问题

return {
  'BranimirE/fix-auto-scroll.nvim',
  ---------------------------------------------------- config ----------------------------------------------------------
  config = true,
  event = 'VeryLazy'
}

