-- FILE: lua/plugins/notify.nvim
-- INFO: Base notification plugin; mainly custom highlights here
--       基础通知插件，此处主要改高亮

----------------------------------------------------- highlight --------------------------------------------------------
vim.api.nvim_set_hl(0, "NotifyBackground",  { bg = "#323647", fg = "#323647" })
vim.api.nvim_set_hl(0, "NotifyERRORBorder", { bg = "none", fg = "#e78284" })
vim.api.nvim_set_hl(0, "NotifyWARNBorder",  { bg = "none", fg = "#d9be88" })
vim.api.nvim_set_hl(0, "NotifyINFOBorder",  { bg = "none", fg = "#7f91cd" })
vim.api.nvim_set_hl(0, "NotifyDEBUGBorder", { bg = "none", fg = "#c1c8e6" })
vim.api.nvim_set_hl(0, "NotifyTRACEBorder", { bg = "none", fg = "#8caaee" })

vim.api.nvim_set_hl(0, "NotifyERRORIcon", { bg = "none", fg = "#e78284" })
vim.api.nvim_set_hl(0, "NotifyWARNIcon",  { bg = "none", fg = "#d9be88" })
vim.api.nvim_set_hl(0, "NotifyINFOIcon",  { bg = "none", fg = "#7f91cd" })
vim.api.nvim_set_hl(0, "NotifyDEBUGIcon", { bg = "none", fg = "#c1c8e6" })
vim.api.nvim_set_hl(0, "NotifyTRACEIcon", { bg = "none", fg = "#8caaee" })

vim.api.nvim_set_hl(0, "NotifyERRORTitle", { bg = "none", fg = "#e78284" })
vim.api.nvim_set_hl(0, "NotifyWARNTitle",  { bg = "none", fg = "#d9be88" })
vim.api.nvim_set_hl(0, "NotifyINFOTitle",  { bg = "none", fg = "#7f91cd" })
vim.api.nvim_set_hl(0, "NotifyDEBUGTitle", { bg = "none", fg = "#c1c8e6" })
vim.api.nvim_set_hl(0, "NotifyTRACETitle", { bg = "none", fg = "#8caaee" })

return {
  "rcarriga/nvim-notify",
  event = "VeryLazy",
  ---------------------------------------------------- config ----------------------------------------------------------
  config = function()
    require("notify").setup({
      -- NOTE: must hardcode this or use a highlight group; "none" won't work
      -- 注意：必须写死或配 highlight，不能用 none 代替
      background_colour = "#323647",
      stages = "slide",   -- Preset animation | 滑入动画预设
      render = "default", -- Preset renderer | 渲染预设
    })
  end,
}

