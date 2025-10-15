-- 基于 Catppuccin Frappé 制作的多色调色板调色板
local color = {
  -- 基础 16 色与其对应的 6 色阶，其中 4 号是正常色阶，其中数字越靠低，颜色越暗

  -- 一种灰蓝色，可以被描述为淡蓝灰色或中性灰
  brand_1 = "#6f7994",
  brand_2 = "#909bb8",
  brand_3 = "#b2bfdb",
  brand_4 = "#d2e0fd",
  brand_5 = "#dfeaff",
  brand_6 = "#e7f0ff",

  -- 偏蓝色深灰
  black_1 = "#222533",
  black_2 = "#323647",
  black_3 = "#43485c",
  black_4 = "#51576d",
  black_5 = "#71788d",
  black_6 = "#9197a9",

  -- 偏粉的珊瑚红
  red_1 = "#7f4147",
  red_2 = "#a3585d",
  red_3 = "#c67174",
  red_4 = "#e78284",
  red_5 = "#eea3a2",
  red_6 = "#f2bbb8",

  -- 清新薄荷绿
  green_1 = "#526a45",
  green_2 = "#6f8d5e",
  green_3 = "#8db177",
  green_4 = "#a6d189",
  green_5 = "#bcdda5",
  green_6 = "#cde5ba",

  -- 柔和的奶油黄
  yellow_1 = "#745f49",
  yellow_2 = "#9b8262",
  yellow_3 = "#c1a77d",
  yellow_4 = "#e5c890",
  yellow_5 = "#edd9ab",
  yellow_6 = "#f1e4bf",

  -- 清新明亮的粉蓝色
  blue_1 = "#475786",
  blue_2 = "#5f73aa",
  blue_3 = "#7991cd",
  blue_4 = "#8caaee",
  blue_5 = "#a9c1f4",
  blue_6 = "#bed1f7",

  -- 棉花糖般的淡粉紫
  magenta_1 = "#8c6084",
  magenta_2 = "#b07da5",
  magenta_3 = "#d39dc7",
  magenta_4 = "#f4b8e4",
  magenta_5 = "#f9cceb",
  magenta_6 = "#fad8ef",

  -- 清爽的青绿色
  cyan_1 = "#416662",
  cyan_2 = "#588782",
  cyan_3 = "#70a9a2",
  cyan_4 = "#81c8be",
  cyan_5 = "#9dd5cc",
  cyan_6 = "#b3e0d8",

  -- 柔和的云灰蓝
  white_1 = "#595e7a",
  white_2 = "#777e9e",
  white_3 = "#98a0c1",
  white_4 = "#b5bfe2",
  white_5 = "#c8d0ea",
  white_6 = "#d5dcef",

  -- 暴风雨灰
  gray_1 = "#303346",
  gray_2 = "#41455a",
  gray_3 = "#53586f",
  gray_4 = "#626880",
  gray_5 = "#80869c",
  gray_6 = "#9da2b5",

  -- 灰调长春花色
  Periwinkle_1 = "#4a4e66",
  Periwinkle_2 = "#686d8a",
  Periwinkle_3 = "#888fad",
  Periwinkle_4 = "#a5adce",
  Periwinkle_5 = "#bac1da",
  Periwinkle_6 = "#cad0e3",
}

-- 快速构建函数
-- 前景，背景，gui 设置这样的顺序
local function hi(group, opts)
  local gui = opts.gui and " gui=" .. opts.gui or ""
  vim.cmd(string.format(
    "highlight %s guifg=%s guibg=%s%s",
    group,
    opts.fg or "none",
    opts.bg or "none",
    gui)
  )
end

-- 基础透明
hi("Normal",             {})
hi("NormalFloat",        {})
hi("VertSplit",          {})
hi("StatusLine",         {})
hi("StatusLineNC",       {})
hi("WinBar",             {})
hi("WinBarNC",           {})
hi("FloatShadow",        {})
hi("FloatShadowThrough", {})
hi("Pmenu",              {})

-- 行号与光标
hi("CursorLineNr", { fg = color.blue_6 })
hi("CursorLine",   {})
hi("LineNr",       { fg = color.gray_5 })

-- 语法高亮
hi("Comment",    { fg = color.cyan_3,   gui = "italic" })       -- 注释
hi("Keyword",    { fg = color.yellow_5, gui = "italic,bold" })  -- 关键字
hi("Constant",   { fg = color.magenta_3 }) -- 常量
hi("Function",   { fg = color.blue_4 })    -- 函数名
hi("Identifier", { fg = color.blue_6 })    -- 变量名
hi("Type",       { fg = color.red_4,    gui = "bold" })         -- 类型
hi("Statement",  { fg = color.yellow_3, gui = "italic,bold" })  -- 状态，例如 case 等
hi("Special",    { fg = color.magenta_4 }) -- 特殊符号，如 {} 等
hi("Character",  { fg = color.green_3 })   -- 字符，如 "a" 等
hi("Structure",  { fg = color.red_6 })   -- 结构
hi("Macro",      { fg = color.green_4 }) -- 预处理等
hi("Title",      { fg = color.red_4 })   -- 标题
hi("Directory",  { fg = color.blue_4 })  -- 与文档相关操作

-- 搜索与匹配
hi("Search",    { fg = color.brand_4, bg = color.brand_2, gui = "bold" })
hi("CurSearch", { fg = color.brand_5, bg = color.black_2, gui = "italic,bold" })
hi("Visual",    { fg = color.Periwinkle_4, bg = color.Periwinkle_2, gui = "bold" })

-- hi("Added",      { fg = color.green })
-- hi("Changed",    { fg = color.yellow })
-- hi("Removed",    { fg = color.red })
-- hi("DiffAdd",    { fg = "#9ACD32" })
-- hi("DiffChange", { fg = "#EEB422" })
-- hi("DiffDelete", { fg = "#EE6363" })
-- hi("DiffText",   { fg = color.bright_white })
