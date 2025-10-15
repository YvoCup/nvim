vim.api.nvim_set_hl(0, "BlankLine",       { bg = none, fg = "#626880" })
vim.api.nvim_set_hl(0, "BlankLineActive", { bg = none, fg = "#61AFEF" })

return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",         -- 别名，方便 require
  branch = "master",    -- 其主要的分支使用
  lazy = false,         -- 非 lazy 加载
  config = function ()  -- 插件内部配置
    require("ibl").setup({
      indent = { 
        smart_indent_cap = true,
        highlight = { "BlankLine" },
      },
      scope  = {
        show_start = true,
        show_end   = true,
        highlight = { "BlankLineActive" },
      }
    })
  end
}
