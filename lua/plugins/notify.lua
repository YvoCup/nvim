-- FILE: lua/plugins/notify.nvim
-- INFO: 基础的通知能力，此处主要是修改了起部分的高亮显示

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
      -- NOTE: 此处需要注意必须写死这个，或者写个 highlight 类去实现，不能用 none 代替
      background_colour = "#323647",
      -- 滑入方式的控制，采用预设
      stages = "slide",
      -- 内部的字符的渲染逻辑，采用预设
      render = "default",
    })
  end,
}

