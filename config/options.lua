-- 开启光标行高亮
vim.opt.cursorline = false
-- 开启行号
vim.opt.number = true
vim.opt.relativenumber = true
-- 搜索的大小写智能
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- 关闭mode显示
vim.opt.showmode = false
-- 设置全局缩进选项
vim.opt.autoindent = true -- 自动继承上一行缩进
vim.opt.smartindent = true -- 智能缩进（如函数体）
vim.opt.expandtab = true -- 将 Tab 转换为空格
vim.opt.shiftwidth = 2 -- >> 和 << 命令的缩进量
vim.opt.tabstop = 2 -- Tab 显示的宽度
vim.opt.softtabstop = 2 -- 编辑时插入的空格数

-- 关键：设置诊断浮动窗口的高亮组
-- 确保背景透明
vim.api.nvim_set_hl(0, "DiagnosticFloatDefaultNormal", { bg = "none" })

-- 如果你使用了不同严重程度的诊断样式，可以一并设置
vim.api.nvim_set_hl(0, "DiagnosticFloatDefaultError", { bg = "none", fg = "#F2481B" })
vim.api.nvim_set_hl(0, "DiagnosticFloatDefaultWarn", { bg = "none", fg = "#B5B20D" })
vim.api.nvim_set_hl(0, "DiagnosticFloatDefaultInfo", { bg = "none", fg = "#FFFFFF" })
vim.api.nvim_set_hl(0, "DiagnosticFloatDefaultHint", { bg = "none", fg = "#FFFFFF" })

-- 如果虚拟文本也有背景问题，可以设置虚拟文本的高亮
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { bg = "none", fg = "#F2481B" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { bg = "none", fg = "#B5B20D" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { bg = "none", fg = "#FFFFFF" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { bg = "none", fg = "#FFFFFF" })

-- 配置普通行号（非当前行）的颜色
vim.api.nvim_set_hl(0, "LineNr", {
  fg = "#41827A", -- 行号文字颜色（十六进制或颜色名，如 "gray"）
  bg = "none", -- 行号背景色（none 表示透明）
  -- ctermfg = 244,  -- 终端环境下的文字颜色（使用终端颜色编号）
  -- ctermbg = "none" -- 终端环境下的背景色
})

-- 配置当前行号的颜色（通常会与普通行号区分开）
vim.api.nvim_set_hl(0, "CursorLineNr", {
  fg = "#FFFFFF", -- 当前行号文字颜色
  bg = "none", -- 背景色
  -- ctermfg = 255,  -- 终端下的当前行号颜色
  -- ctermbg = "none"
})

-- 配置Visiual模式下的高亮颜色
vim.api.nvim_set_hl(0, "Visual", {
  bg = "#41827A", -- 选中区域的背景色
  fg = "#000000", -- 选中区域的文字颜色
})

-- 主题相关的高亮覆盖
---- 配置透明背景
---- 定义设置透明背景的函数
---- 基础透明设置
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" }) -- 非活动窗口
vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" }) -- 文件末尾标识
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" }) -- 悬浮窗背景透明
vim.api.nvim_set_hl(0, "FloatBorder", {
  bg = "none", -- 边框背景透明
  fg = "#2AADC7", -- 边框线条颜色（根据你的主题调整，如浅灰色）
})
-- 其他可能的通用组（如弹窗标题）
vim.api.nvim_set_hl(0, "FloatTitle", { bg = "none", fg = "#FA9B69" })
-- BlinkCmp 背景和高亮设置
-- 添加透明背景设置
-- 设置透明背景的高亮组
vim.api.nvim_set_hl(0, "BlinkCmpMenu", { bg = "NONE" })
vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { bg = "NONE", fg = "#2984E6" })
vim.api.nvim_set_hl(0, "BlinkCmpDoc", { bg = "NONE" })
vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", { bg = "NONE", fg = "#2984E6" })
vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelp", { bg = "NONE" })
vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelpBorder", { bg = "NONE", fg = "#2984E6" })

-- SnacksIndentChunk
-- vim.api.nvim_set_hl(0, "SnacksIndentChunk", { fg = "#1CEB89" })
vim.api.nvim_set_hl(0, "SnacksIndentChunk", { fg = "#2CD17B" })

-- vim.api.nvim_set_hl(0, "illuminatedWord", { bg = "#BABFFF", fg = "#1F2240", bold = true })
-- vim.api.nvim_set_hl(0, "illuminatedCurWord", { bg = "#BABFFF", fg = "#1F2240", bold = true })
-- vim.api.nvim_set_hl(0, "IlluminatedWordRead", { bg = "#BABFFF", fg = "#1F2240", bold = true })
-- vim.api.nvim_set_hl(0, "IlluminatedWordText", { bg = "#BABFFF", fg = "#1F2240", bold = true })
-- vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { bg = "#BABFFF", fg = "#1F2240", bold = true })
vim.api.nvim_set_hl(0, "IlluminatedWordRead", {
  -- gui = underline,
  -- cterm = underline,
  bg = "NONE",
  bold = true,
  italic = true,
  -- undercurl = true,
  underline = true,
  sp = "#8AE384", -- undercurl/line 用这个颜色
  nocombine = true,
})
vim.api.nvim_set_hl(0, "IlluminatedWordText", {
  -- gui = underline,
  -- cterm = underline,
  bg = "NONE",
  bold = true,
  italic = true,
  -- undercurl = true,
  underline = true,
  sp = "#8AE384", -- undercurl/line 用这个颜色
  nocombine = true,
})
vim.api.nvim_set_hl(0, "IlluminatedWordWrite", {
  -- gui = underline,
  -- cterm = underline,
  bg = "NONE",
  bold = true,
  italic = true,
  -- undercurl = true,
  underline = true,
  sp = "#8AE384", -- undercurl/line 用这个颜色
  nocombine = true,
})
