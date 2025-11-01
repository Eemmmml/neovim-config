return {
  {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
    opts = {
      transparent_background = true,
      integrations = {
        aerial = true,
        alpha = true,
        cmp = true,
        dashboard = true,
        flash = true,
        fzf = true,
        grug_far = true,
        gitsigns = true,
        headlines = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        leap = true,
        lsp_trouble = true,
        mason = true,
        markdown = true,
        mini = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        navic = { enabled = true, custom_bg = "lualine" },
        neotest = true,
        neotree = true,
        noice = true,
        notify = true,
        semantic_tokens = true,
        snacks = true,
        telescope = true,
        treesitter = true,
        treesitter_context = true,
        which_key = true,
      },
    },
    specs = {
      {
        "akinsho/bufferline.nvim",
        optional = true,
        opts = function(_, opts)
          if (vim.g.colors_name or ""):find "catppuccin" then
            opts.highlights = require("catppuccin.groups.integrations.bufferline").get()
          end
        end,
      },
    },
  },
  -- 安装 tokyonight主题
  {
    "folke/tokyonight.nvim",
    lazy = false, -- 重要：主题需要立即加载
    priority = 1000, -- 最高优先级
    config = function()
      require("tokyonight").setup {
        style = "night", -- storm, night, moon
        transparent = true,
        styles = {
          comments = { italic = true },
          keywords = { italic = false },
        },
        on_colors = function(colors)
          -- 自定义颜色覆盖
          --colors.bg_statusline = "#16161e"
          colors.bg_statusline = "none"
        end,

        on_highlights = function(hl, colors)
          -- 1. 直接在此设置行号颜色（最高优先级）
          hl.LineNr = {
            fg = "#00FF9F", -- 亮青色（在透明背景下非常醒目）
            bg = "none",
          }
          hl.CursorLineNr = {
            fg = "#FFFF00", -- 亮黄色（当前行号）
            bg = "none",
            bold = true,
          }

          -- 3. 关键修复：覆盖NormalFloat背景
          hl.NormalFloat = {
            bg = "#1A1A2E", -- 深蓝灰色（保持可读性）
          }
        end,
      }

      -- 设置主题
      --vim.cmd.colorscheme("tokyonight-moon")

      -- 主题相关的高亮覆盖
      --vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      --vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#4BC437" })
    end,
  },

  -- 可选：启动画面
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    config = function()
      local dashboard = require "alpha.themes.dashboard"

      -- 自定义 Eemmmml ASCII 艺术
      dashboard.section.header.val = {
        "  ███████╗ ███████╗ ███╗   ███╗ ███╗   ███╗ ███╗   ███╗ ██╗     ",
        "  ██╔════╝ ██╔════╝ ████╗ ████║ ████╗ ████║ ████╗ ████║ ██║     ",
        "  █████╗   ███████╗ ██╔████╔██║ ██╔████╔██║ ██╔████╔██║ ██║     ",
        "  ██╔══╝   ╚════██║ ██║╚██╔╝██║ ██║╚██╔╝██║ ██║╚██╔╝██║ ██║     ",
        "  ███████╗ ███████║ ██║ ╚═╝ ██║ ██║ ╚═╝ ██║ ██║ ╚═╝ ██║ ███████╗",
        "  ╚══════╝ ╚══════╝ ╚═╝     ╚═╝ ╚═╝     ╚═╝ ╚═╝     ╚═╝ ╚══════╝",
      }

      -- 添加按钮
      dashboard.section.buttons.val = {
        dashboard.button("e", "  New file", ":ene <BAR> startinsert<CR>"),
        dashboard.button("f", "  Find file", ":Telescope find_files<CR>"),
        dashboard.button("r", "  Recent files", ":Telescope oldfiles<CR>"),
        dashboard.button("t", "  Find text", ":Telescope live_grep<CR>"),
        dashboard.button("c", "  Configuration", ":e ~/.config/nvim/init.lua<CR>"),
        dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
      }

      -- 底部信息
      dashboard.section.footer.val = "Welcome back, Eemmmml!"

      require("alpha").setup(dashboard.config)

      -- 设置高亮
      vim.cmd [[
        highlight AlphaHeader guifg=#89ddff
        highlight AlphaButtons guifg=#c792ea
        highlight AlphaFooter guifg=#c3e88d
      ]]
    end,
  },
}
