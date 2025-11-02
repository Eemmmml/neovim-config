return {
  -- noice 插件，更美观的通知
  -- lazy.nvim
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      cmdline = {
        enabled = true, -- enables the Noice cmdline UI
        view = "cmdline_popup", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
        opts = {}, -- global options for the cmdline. See section on views
        ---@type table<string, CmdlineFormat>
        format = {
          -- conceal: (default=true) This will hide the text in the cmdline that matches the pattern.
          -- view: (default is cmdline view)
          -- opts: any options passed to the view
          -- icon_hl_group: optional hl_group for the icon
          -- title: set to anything or empty string to hide
          cmdline = { pattern = "^:", icon = "", lang = "vim" },
          search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
          search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
          filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
          lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
          help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
          input = { view = "cmdline_input", icon = "󰥻 " }, -- Used by input()
          -- lua = false, -- to disable a format, set to `false`
        },
      },
      messages = {
        -- NOTE: If you enable messages, then the cmdline is enabled automatically.
        -- This is a current Neovim limitation.
        enabled = true, -- enables the Noice messages UI
        view = "notify", -- default view for messages
        view_error = "notify", -- view for errors
        view_warn = "notify", -- view for warnings
        view_history = "messages", -- view for :messages
        view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
      },
      popupmenu = {
        enabled = true, -- enables the Noice popupmenu UI
        ---@type 'nui'|'cmp'
        backend = "nui", -- backend to use to show regular cmdline completions
        ---@type NoicePopupmenuItemKind|false
        -- Icons for completion item kinds (see defaults at noice.config.icons.kinds)
        kind_icons = {}, -- set to `false` to disable icons
        position = {
          row = "auto", -- 自动跟随命令行位置:cite[7]
          col = "auto",
        },
        size = {
          width = 120, -- 与命令行同宽
          height = "auto",
        },
        border = {
          style = "double",
          padding = { 0, 1 },
        },
      },
      -- default options for require('noice').redirect
      -- see the section on Command Redirection
      ---@type NoiceRouteConfig
      redirect = {
        view = "popup",
        filter = { event = "msg_show" },
      },
      -- You can add any custom commands below that will be available with `:Noice command`
      ---@type table<string, NoiceCommand>
      commands = {
        history = {
          -- options for the message history that you get with `:Noice`
          view = "split",
          opts = { enter = true, format = "details" },
          filter = {
            any = {
              { event = "notify" },
              { error = true },
              { warning = true },
              { event = "msg_show", kind = { "" } },
              { event = "lsp", kind = "message" },
            },
          },
        },
        -- :Noice last
        last = {
          view = "popup",
          opts = { enter = true, format = "details" },
          filter = {
            any = {
              { event = "notify" },
              { error = true },
              { warning = true },
              { event = "msg_show", kind = { "" } },
              { event = "lsp", kind = "message" },
            },
          },
          filter_opts = { count = 1 },
        },
        -- :Noice errors
        errors = {
          -- options for the message history that you get with `:Noice`
          view = "popup",
          opts = { enter = true, format = "details" },
          filter = { error = true },
          filter_opts = { reverse = true },
        },
        all = {
          -- options for the message history that you get with `:Noice`
          view = "split",
          opts = { enter = true, format = "details" },
          filter = {},
        },
      },
      notify = {
        -- Noice can be used as `vim.notify` so you can route any notification like other messages
        -- Notification messages have their level and other properties set.
        -- event is always "notify" and kind can be any log level as a string
        -- The default routes will forward notifications to nvim-notify
        -- Benefit of using Noice for this is the routing and consistent history view
        enabled = true,
        view = "notify",
      },
      lsp = {
        progress = {
          enabled = true,
          -- Lsp Progress is formatted using the builtins for lsp_progress. See config.format.builtin
          -- See the section on formatting for more details on how to customize.
          --- @type NoiceFormat|string
          format = "lsp_progress",
          --- @type NoiceFormat|string
          format_done = "lsp_progress_done",
          throttle = 1000 / 30, -- frequency to update lsp progress message
          view = "mini",
        },
        override = {
          -- override the default lsp markdown formatter with Noice
          ["vim.lsp.util.convert_input_to_markdown_lines"] = false,
          -- override the lsp markdown formatter with Noice
          ["vim.lsp.util.stylize_markdown"] = false,
          -- override cmp documentation with Noice (needs the other options to work)
          ["cmp.entry.get_documentation"] = false,
        },
        hover = {
          enabled = true,
          silent = false, -- set to true to not show a message if hover is not available
          view = nil, -- when nil, use defaults from documentation
          ---@type NoiceViewOptions
          opts = {}, -- merged with defaults from documentation
        },
        signature = {
          enabled = false,
          auto_open = {
            enabled = true,
            trigger = true, -- Automatically show signature help when typing a trigger character from the LSP
            luasnip = true, -- Will open signature help when jumping to Luasnip insert nodes
            throttle = 50, -- Debounce lsp signature help request by 50ms
          },
          view = nil, -- when nil, use defaults from documentation
          ---@type NoiceViewOptions
          opts = {}, -- merged with defaults from documentation
        },
        message = {
          -- Messages shown by lsp servers
          enabled = true,
          view = "notify",
          opts = {},
        },
        -- defaults for hover and signature help
        documentation = {
          view = "hover",
          ---@type NoiceViewOptions
          opts = {
            lang = "markdown",
            replace = true,
            render = "plain",
            format = { "{message}" },
            win_options = { concealcursor = "n", conceallevel = 3 },
            border = {
              style = "rounded", -- 边框样式: rounded(圆角), single(单线), double(双线), solid(实心)等
              padding = { 0, 1 }, -- 边框内边距
            },
            size = {
              -- width = 80, -- 宽度(字符数)
              -- height = 20, -- 高度(行数)
              -- 或者使用最大尺寸限制:
              max_width = 80,
              max_height = 20,
            },
          },
        },
      },
      markdown = {
        hover = {
          ["|(%S-)|"] = vim.cmd.help, -- vim help links
          ["%[.-%]%((%S-)%)"] = require("noice.util").open, -- markdown links
        },
        highlights = {
          ["|%S-|"] = "@text.reference",
          ["@%S+"] = "@parameter",
          ["^%s*(Parameters:)"] = "@text.title",
          ["^%s*(Return:)"] = "@text.title",
          ["^%s*(See also:)"] = "@text.title",
          ["{%S-}"] = "@parameter",
        },
      },
      health = {
        checker = true, -- Disable if you don't want health checks to run
      },
      ---@type NoicePresets
      presets = {
        -- you can enable a preset by setting it to true, or a table that will override the preset config
        -- you can also add custom presets that you can enable/disable with enabled=true
        bottom_search = false, -- use a classic bottom cmdline for search
        command_palette = false, -- position the cmdline and popupmenu together
        long_message_to_split = false, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
      throttle = 1000 / 30, -- how frequently does Noice need to check for ui updates? This has no effect when in blocking mode.
      ---@type NoiceConfigViews
      views = {
        -- 配置cmdline弹出位置在屏幕上方
        cmdline_popup = {
          backend = "popup",
          relative = "editor",
          zindex = 200,
          position = {
            row = "20%", -- 距离顶部2行:cite[4]
            col = "50%", -- 水平居中
          },
          size = {
            width = 90, -- 固定宽度
            height = "auto",
          },
          win_options = {
            winhighlight = {
              Normal = "NoiceCmdlinePopup",
              FloatTitle = "NoiceCmdlinePopupTitle",
              FloatBorder = "NoiceCmdlinePopupBorder",
            },
          },
        },
        hover = {
          border = {
            style = "rounded",
            padding = { 0, 1 },
          },
          size = {
            width = 80, -- 宽度可以根据需要调整
            height = 20, -- 高度可以根据需要调整，或者使用 max_height
          },
          position = {
            -- 关键调整：控制垂直位置，增加 row 值使其向下移动
            -- 方案一：使用固定行数（例如，从屏幕顶部算起第10行开始）
            row = 4,
            -- 方案二：使用百分比（例如，从屏幕顶部 30% 的位置开始）
            -- row = "30%",
            -- 方案三：动态计算位置（推荐，尝试让其在当前行下方显示）
            -- row = function()
            --   local cursor_row = vim.fn.line "." -- 获取当前光标行号（相对于窗口）
            --   -- 将窗口相对行号转换为屏幕绝对行号可能需要更多计算
            --   -- 一个简单的偏移：在当前行号基础上加上一个固定值
            --   -- 注意：这个简单方法可能并不完全精确，但可以先尝试
            --   return cursor_row + 5 -- 尝试在当前行下方第5行显示
            -- end,

            -- col = "50%", -- 水平位置通常可以保持居中
          },
          -- 确保滚动条是隐藏的，如你之前的要求
          scrollbar = false,
        },
      }, ---@see section on views
      ---@type NoiceRouteConfig[]
      routes = {}, --- @see section on routes
      ---@type table<string, NoiceFilter>
      status = {}, --- @see section on statusline components
      ---@type NoiceFormatOptions
      format = {}, --- @see section on formatting
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      -- "rcarriga/nvim-notify",
    },
  },

  -- lualine 集成
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "AndreM222/copilot-lualine",
    },
    opts = {
      options = {
        always_divide_middle = false,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        theme = "auto",
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { "filename" },
        lualine_x = {},
        lualine_y = { "encoding", "fileformat", "filetype", "progress" },
        lualine_z = { "location" },
      },
      -- stylua: ignore
      -- winbar = {
      --   lualine_a = { "filename", },
      --   lualine_b = { { function() return " " end, color = "Comment", }, },
      --   lualine_x = { "lsp_status", },
      -- },
      -- inactive_winbar = {
      --   -- Always show winbar
      --   -- stylua: ignore
      --   lualine_b = { function() return " " end, },
      -- },
    },
    config = function(_, opts)
      local mocha = require("catppuccin.palettes").get_palette "mocha"

      -- 创建完全透明的主题
      local transparent_theme = {
        normal = {
          a = { fg = mocha.blue, bg = "NONE" },
          b = { fg = mocha.text, bg = "NONE" },
          c = { fg = mocha.text, bg = "NONE" },
          x = { fg = mocha.text, bg = "NONE" },
          y = { fg = mocha.text, bg = "NONE" },
          z = { fg = mocha.text, bg = "NONE" },
        },
        insert = {
          a = { fg = mocha.green, bg = "NONE" },
          b = { fg = mocha.text, bg = "NONE" },
          c = { fg = mocha.text, bg = "NONE" },
          x = { fg = mocha.text, bg = "NONE" },
          y = { fg = mocha.text, bg = "NONE" },
          z = { fg = mocha.text, bg = "NONE" },
        },
        visual = {
          a = { fg = mocha.mauve, bg = "NONE" },
          b = { fg = mocha.text, bg = "NONE" },
          c = { fg = mocha.text, bg = "NONE" },
          x = { fg = mocha.text, bg = "NONE" },
          y = { fg = mocha.text, bg = "NONE" },
          z = { fg = mocha.text, bg = "NONE" },
        },
        replace = {
          a = { fg = mocha.red, bg = "NONE" },
          b = { fg = mocha.text, bg = "NONE" },
          c = { fg = mocha.text, bg = "NONE" },
          x = { fg = mocha.text, bg = "NONE" },
          y = { fg = mocha.text, bg = "NONE" },
          z = { fg = mocha.text, bg = "NONE" },
        },
        inactive = {
          a = { fg = mocha.overlay0, bg = "NONE" },
          b = { fg = mocha.overlay0, bg = "NONE" },
          c = { fg = mocha.overlay0, bg = "NONE" },
          x = { fg = mocha.overlay0, bg = "NONE" },
          y = { fg = mocha.overlay0, bg = "NONE" },
          z = { fg = mocha.overlay0, bg = "NONE" },
        },
      }

      opts.options.theme = transparent_theme

      local function show_macro_recording()
        local recording_register = vim.fn.reg_recording()
        if recording_register == "" then
          return ""
        else
          return "󰑋 " .. recording_register
        end
      end

      local macro_recording = {
        show_macro_recording,
        color = { fg = "#333333", bg = mocha.red },
        separator = { left = "", right = "" },
        padding = 0,
      }

      local copilot = {
        "copilot",
        show_colors = true,
        symbols = {
          status = {
            hl = {
              enabled = mocha.green,
              sleep = mocha.overlay0,
              disabled = mocha.surface0,
              warning = mocha.peach,
              unknown = mocha.red,
            },
          },
          spinner_color = mocha.mauve,
        },
      }

      table.insert(opts.sections.lualine_x, 1, macro_recording)
      table.insert(opts.sections.lualine_c, copilot)

      require("lualine").setup(opts)
    end,
  },

  -- barbar
  {
    "romgrk/barbar.nvim",
    version = "^1.0.0", -- optional: only update when a new 1.x version is released
    dependencies = {
      "lewis6991/gitsigns.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    init = function()
      vim.g.barbar_auto_setup = false
    end,
    lazy = false,
    -- stylua: ignore
    keys = {
      { "<leader>b<", "<CMD>BufferMovePrevious<CR>", mode = {"n"}, desc = "[Buffer] Move buffer left"},
      { "<leader>b>", "<CMD>BufferMoveNext<CR>",     mode = {"n"}, desc = "[Buffer] Move buffer right"  },
      { "<leader>b1", "<CMD>BufferGoto 1<CR>",       mode = {"n"}, desc = "[Buffer] Go to buffer 1"      },
      { "<leader>b2", "<CMD>BufferGoto 2<CR>",       mode = {"n"}, desc = "[Buffer] Go to buffer 2"      },
      { "<leader>b3", "<CMD>BufferGoto 3<CR>",       mode = {"n"}, desc = "[Buffer] Go to buffer 3"      },
      { "<leader>b4", "<CMD>BufferGoto 4<CR>",       mode = {"n"}, desc = "[Buffer] Go to buffer 4"      },
      { "<leader>b5", "<CMD>BufferGoto 5<CR>",       mode = {"n"}, desc = "[Buffer] Go to buffer 5"      },
      { "<leader>b6", "<CMD>BufferGoto 6<CR>",       mode = {"n"}, desc = "[Buffer] Go to buffer 6"      },
      { "<leader>b7", "<CMD>BufferGoto 7<CR>",       mode = {"n"}, desc = "[Buffer] Go to buffer 7"      },
      { "<leader>b8", "<CMD>BufferGoto 8<CR>",       mode = {"n"}, desc = "[Buffer] Go to buffer 8"      },
      { "<leader>b9", "<CMD>BufferGoto 9<CR>",       mode = {"n"}, desc = "[Buffer] Go to buffer 9"      },
      { "<leader>bq", "<CMD>BufferClose<CR>", mode = {"n"}, desc = "[Buffer] Close current buffer"   },
    },
    opts = {
      animation = false,
      -- Automatically hide the tabline when there are this many buffers left.
      -- Set to any value >=0 to enable.
      auto_hide = 1,
      icons = {
        buffer_index = true,

        -- separator = { left = "·", right = "·" },
        separator_at_end = true,
        -- Sets the maximum padding width with which to surround each tab
        maximum_padding = 3,

        -- Sets the minimum padding width with which to surround each tab
        minimum_padding = 3,
        -- Use a preconfigured buffer appearance— can be 'default', 'powerline', or 'slanted'
        preset = "default",
      },

      -- Set the filetypes which barbar will offset itself for
      sidebar_filetypes = {
        NvimTree = true, -- Use the default values: {event = 'BufWinLeave', text = '', align = 'left'}
      },
    },
    config = function(_, opts)
      require("barbar").setup(opts)

      -- 设置背景透明的高亮组
      vim.api.nvim_set_hl(0, "BufferCurrent", { fg = "#ffffff", bg = "NONE" })
      vim.api.nvim_set_hl(0, "BufferCurrentIndex", { fg = "#ffffff", bg = "NONE" })
      vim.api.nvim_set_hl(0, "BufferCurrentMod", { fg = "#e5c07b", bg = "NONE" })
      vim.api.nvim_set_hl(0, "BufferCurrentSign", { fg = "#61afef", bg = "NONE" })

      -- 设置非当前缓冲区的样式（透明背景）
      vim.api.nvim_set_hl(0, "BufferVisible", { fg = "#9da5b3", bg = "NONE" })
      vim.api.nvim_set_hl(0, "BufferVisibleIndex", { fg = "#9da5b3", bg = "NONE" })
      vim.api.nvim_set_hl(0, "BufferVisibleMod", { fg = "#e5c07b", bg = "NONE" })
      vim.api.nvim_set_hl(0, "BufferVisibleSign", { fg = "#61afef", bg = "NONE" })

      -- 设置隐藏缓冲区的样式（透明背景）
      vim.api.nvim_set_hl(0, "BufferInactive", { fg = "#6b7280", bg = "NONE" })
      vim.api.nvim_set_hl(0, "BufferInactiveIndex", { fg = "#6b7280", bg = "NONE" })
      vim.api.nvim_set_hl(0, "BufferInactiveMod", { fg = "#e5c07b", bg = "NONE" })
      vim.api.nvim_set_hl(0, "BufferInactiveSign", { fg = "#61afef", bg = "NONE" })

      -- 设置标签页填充背景透明
      vim.api.nvim_set_hl(0, "BufferTabpageFill", { fg = "#9da5b3", bg = "NONE" })
      -- 设置分隔符颜色为透明
      vim.api.nvim_set_hl(0, "BufferCurrentSeparator", { fg = "NONE", bg = "NONE" })
      vim.api.nvim_set_hl(0, "BufferVisibleSeparator", { fg = "NONE", bg = "NONE" })
      vim.api.nvim_set_hl(0, "BufferInactiveSeparator", { fg = "NONE", bg = "NONE" })
      -- 设置分隔符为透明
      vim.api.nvim_set_hl(0, "BufferCurrentSign", { fg = "#5C9DD6", bg = "NONE" })
      vim.api.nvim_set_hl(0, "BufferCurrentSignRight", { fg = "#5C9DD6", bg = "NONE" })
      vim.api.nvim_set_hl(0, "BufferInactiveSign", { fg = "#5C9DD6", bg = "NONE" })
      vim.api.nvim_set_hl(0, "BufferInactiveSignRight", { fg = "#5C9DD6", bg = "NONE" })
    end,
  },

  -- rainbow delimiters
  {
    "HiPhish/rainbow-delimiters.nvim",
    main = "rainbow-delimiters.setup",
    submodules = false,
    opts = {
      strategy = {
        [""] = "rainbow-delimiters.strategy.global",
        vim = "rainbow-delimiters.strategy.local",
      },
      query = {
        [""] = "rainbow-delimiters",
        lua = "rainbow-blocks",
      },
      priority = {
        [""] = 110,
        lua = 210,
      },
      highlight = {
        "RainbowDelimiterRed",
        "RainbowDelimiterYellow",
        "RainbowDelimiterBlue",
        "RainbowDelimiterOrange",
        "RainbowDelimiterGreen",
        "RainbowDelimiterViolet",
        "RainbowDelimiterCyan",
      },
    },
  },

  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      bigfile = { enabled = true },
      -- dashboard = { enabled = true },
      explorer = { enabled = false },
      input = { enabled = true },
      picker = { enabled = true },
      notifier = {
        enabled = true,
        timeout = 3000,
      },
      quickfile = { enabled = true },
      scroll = { enabled = false },
      statuscolumn = { enabled = true },
      scope = {
        enabled = true,
        cursor = false,
      },
      words = { enabled = false },
      indent = {
        priority = 1,
        enabled = true, -- enable indent guides
        char = "│",
        only_scope = false, -- only show indent guides of the scope
        only_current = false, -- only show indent guides in the current window
        hl = "SnacksIndent", ---@type string|string[] hl groups for indent guides
        -- can be a list of hl groups to cycle through
        -- hl = {
        --     "SnacksIndent1",
        --     "SnacksIndent2",
        --     "SnacksIndent3",
        --     "SnacksIndent4",
        --     "SnacksIndent5",
        --     "SnacksIndent6",
        --     "SnacksIndent7",
        --     "SnacksIndent8",
        -- },
        -- animate scopes. Enabled by default for Neovim >= 0.10
        -- Works on older versions but has to trigger redraws during animation.
        ---@class snacks.indent.animate: snacks.animate.Config
        ---@field enabled? boolean
        --- * out: animate outwards from the cursor
        --- * up: animate upwards from the cursor
        --- * down: animate downwards from the cursor
        --- * up_down: animate up or down based on the cursor position
        ---@field style? "out"|"up_down"|"down"|"up"
        animate = {
          enabled = vim.fn.has "nvim-0.10" == 1,
          style = "out",
          easing = "linear",
          duration = {
            step = 20, -- ms per step
            total = 500, -- maximum duration
          },
        },
        ---@class snacks.indent.Scope.Config: snacks.scope.Config
        scope = {
          enabled = true, -- enable highlighting the current scope
          priority = 200,
          char = "│",
          underline = false, -- underline the start of the scope
          only_current = false, -- only show scope in the current window
          hl = "SnacksIndentScope", ---@type string|string[] hl group for scopes
        },
        chunk = {
          -- when enabled, scopes will be rendered as chunks, except for the
          -- top-level scope which will be rendered as a scope.
          enabled = true,
          -- only show chunk scopes in the current window
          only_current = false,
          priority = 200,
          hl = "SnacksIndentChunk", ---@type string|string[] hl group for chunk scopes
          char = {
            -- corner_top = "┌",
            -- corner_bottom = "└",
            corner_top = "╭",
            corner_bottom = "╰",
            horizontal = "─",
            vertical = "│",
            arrow = ">",
          },
        },
        -- filter for buffers to enable indent guides
        filter = function(buf)
          return vim.g.snacks_indent ~= false and vim.b[buf].snacks_indent ~= false and vim.bo[buf].buftype == ""
        end,
      },
    },

    -- stylua: ignore
    keys = {
      -- Top Pickers & Explorer
      {
        "<leader><space>",
        function()
          Snacks.picker.smart()
        end,
        desc = "Smart Find Files",
      },
      {
        "<leader>,",
        function()
          Snacks.picker.buffers()
        end,
        desc = "Buffers",
      },
      {
        "<leader>/",
        function()
          Snacks.picker.grep()
        end,
        desc = "Grep",
      },
      {
        "<leader>:",
        function()
          Snacks.picker.command_history()
        end,
        desc = "Command History",
      },
      {
        "<leader>n",
        function()
          Snacks.picker.notifications()
        end,
        desc = "Notification History",
      },
      -- find
      {
        "<leader>fb",
        function()
          Snacks.picker.buffers()
        end,
        desc = "Buffers",
      },
      {
        "<leader>fg",
        function()
          Snacks.picker.git_files()
        end,
        desc = "Find Git Files",
      },
      {
        "<leader>fp",
        function()
          Snacks.picker.projects()
        end,
        desc = "Projects",
      },
      {
        "<leader>fr",
        function()
          Snacks.picker.recent()
        end,
        desc = "Recent",
      },
      -- git
      {
        "<leader>gb",
        function()
          Snacks.picker.git_branches()
        end,
        desc = "Git Branches",
      },
      {
        "<leader>gl",
        function()
          Snacks.picker.git_log()
        end,
        desc = "Git Log",
      },
      {
        "<leader>gL",
        function()
          Snacks.picker.git_log_line()
        end,
        desc = "Git Log Line",
      },
      {
        "<leader>gs",
        function()
          Snacks.picker.git_status()
        end,
        desc = "Git Status",
      },
      {
        "<leader>gS",
        function()
          Snacks.picker.git_stash()
        end,
        desc = "Git Stash",
      },
      {
        "<leader>gd",
        function()
          Snacks.picker.git_diff()
        end,
        desc = "Git Diff (Hunks)",
      },
      {
        "<leader>gf",
        function()
          Snacks.picker.git_log_file()
        end,
        desc = "Git Log File",
      },
      -- search
      {
        "<leader>sw",
        function()
          Snacks.picker.grep_word()
        end,
        desc = "Visual selection or word",
        mode = { "n", "x" },
      },
      {
        "<leader>sd",
        function()
          Snacks.picker.diagnostics()
        end,
        desc = "Diagnostics",
      },
      {
        "<leader>sD",
        function()
          Snacks.picker.diagnostics_buffer()
        end,
        desc = "Buffer Diagnostics",
      },
      {
        "<leader>si",
        function()
          Snacks.picker.icons()
        end,
        desc = "Icons",
      },
      {
        "<leader>sj",
        function()
          Snacks.picker.jumps()
        end,
        desc = "Jumps",
      },
      {
        "<leader>sk",
        function()
          Snacks.picker.keymaps()
        end,
        desc = "Keymaps",
      },
      {
        "<leader>sl",
        function()
          Snacks.picker.loclist()
        end,
        desc = "Location List",
      },
      {
        "<leader>sm",
        function()
          Snacks.picker.marks()
        end,
        desc = "Marks",
      },
      {
        "<leader>sM",
        function()
          Snacks.picker.man()
        end,
        desc = "Man Pages",
      },
      {
        "<leader>sp",
        function()
          Snacks.picker.lazy()
        end,
        desc = "Search for Plugin Spec",
      },
      {
        "<leader>sq",
        function()
          Snacks.picker.qflist()
        end,
        desc = "Quickfix List",
      },
      {
        "<leader>sR",
        function()
          Snacks.picker.resume()
        end,
        desc = "Resume",
      },
      {
        "<leader>su",
        function()
          Snacks.picker.undo()
        end,
        desc = "Undo History",
      },
      {
        "<leader>uC",
        function()
          Snacks.picker.colorschemes()
        end,
        desc = "Colorschemes",
      },
      -- LSP
      {
        "gd",
        function()
          Snacks.picker.lsp_definitions()
        end,
        desc = "Goto Definition",
      },
      {
        "gD",
        function()
          Snacks.picker.lsp_declarations()
        end,
        desc = "Goto Declaration",
      },
      {
        "gr",
        function()
          Snacks.picker.lsp_references()
        end,
        nowait = true,
        desc = "References",
      },
      {
        "gI",
        function()
          Snacks.picker.lsp_implementations()
        end,
        desc = "Goto Implementation",
      },
      {
        "gy",
        function()
          Snacks.picker.lsp_type_definitions()
        end,
        desc = "Goto T[y]pe Definition",
      },
      {
        "<leader>ss",
        function()
          Snacks.picker.lsp_symbols()
        end,
        desc = "LSP Symbols",
      },
      {
        "<leader>sS",
        function()
          Snacks.picker.lsp_workspace_symbols()
        end,
        desc = "LSP Workspace Symbols",
      },
      -- Other
      {
        "<leader>z",
        function()
          Snacks.zen()
        end,
        desc = "Toggle Zen Mode",
      },
      {
        "<leader>Z",
        function()
          Snacks.zen.zoom()
        end,
        desc = "Toggle Zoom",
      },
      {
        "<leader>.",
        function()
          Snacks.scratch()
        end,
        desc = "Toggle Scratch Buffer",
      },
      {
        "<leader>S",
        function()
          Snacks.scratch.select()
        end,
        desc = "Select Scratch Buffer",
      },
      {
        "<leader>n",
        function()
          Snacks.notifier.show_history()
        end,
        desc = "Notification History",
      },
      {
        "<leader>bd",
        function()
          Snacks.bufdelete()
        end,
        desc = "Delete Buffer",
      },
      {
        "<leader>cR",
        function()
          Snacks.rename.rename_file()
        end,
        desc = "Rename File",
      },
      {
        "<leader>gB",
        function()
          Snacks.gitbrowse()
        end,
        desc = "Git Browse",
        mode = { "n", "v" },
      },
      {
        "<leader>gg",
        function()
          Snacks.lazygit()
        end,
        desc = "Lazygit",
      },
      {
        "<leader>un",
        function()
          Snacks.notifier.hide()
        end,
        desc = "Dismiss All Notifications",
      },
      {
        "<c-/>",
        function()
          Snacks.terminal()
        end,
        desc = "Toggle Terminal",
      },
      {
        "<c-_>",
        function()
          Snacks.terminal()
        end,
        desc = "which_key_ignore",
      },
      {
        "]]",
        function()
          Snacks.words.jump(vim.v.count1)
        end,
        desc = "Next Reference",
        mode = { "n", "t" },
      },
      {
        "[[",
        function()
          Snacks.words.jump(-vim.v.count1)
        end,
        desc = "Prev Reference",
        mode = { "n", "t" },
      },
      {
        "<leader>N",
        desc = "Neovim News",
        function()
          Snacks.win {
            file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
            width = 0.6,
            height = 0.6,
            wo = {
              spell = false,
              wrap = false,
              signcolumn = "yes",
              statuscolumn = " ",
              conceallevel = 3,
            },
          }
        end,
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          -- Setup some globals for debugging (lazy-loaded)
          _G.dd = function(...)
            Snacks.debug.inspect(...)
          end
          _G.bt = function()
            Snacks.debug.backtrace()
          end

          -- Override print to use snacks for `:=` command
          if vim.fn.has "nvim-0.11" == 1 then
            vim._print = function(_, ...)
              dd(...)
            end
          else
            vim.print = _G.dd
          end

          -- Create some toggle mappings
          Snacks.toggle.option("spell", { name = "Spelling" }):map "<leader>us"
          Snacks.toggle.option("wrap", { name = "Wrap" }):map "<leader>uw"
          Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map "<leader>uL"
          Snacks.toggle.diagnostics():map "<leader>ud"
          Snacks.toggle.line_number():map "<leader>ul"
          Snacks.toggle
            .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
            :map "<leader>uc"
          Snacks.toggle.treesitter():map "<leader>uT"
          Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map "<leader>ub"
          Snacks.toggle.inlay_hints():map "<leader>uh"
          Snacks.toggle.indent():map "<leader>ug"
          Snacks.toggle.dim():map "<leader>uD"
        end,
      })
    end,
  },
  -- Highlights other uses of the word under the cursor
  {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      delay = 200,
      large_file_cutoff = 2000,
      large_file_overrides = {
        providers = { "lsp" },
      },
      under_cursor = false,
      modes_allowlist = { "n", "no", "nt" },
      filetypes_denylist = {
        "DiffviewFileHistory",
        "DiffviewFiles",
        "fugitive",
        "git",
        "minifiles",
        "neo-tree",
        "Outline",
        "SidebarNvim",
      },
    },
    keys = {
      { "]r", mode = { "n", "o" }, desc = "Next Reference" },
      { "[r", mode = { "n", "o" }, desc = "Prev Reference" },
    },
    config = function(_, opts)
      require("illuminate").configure(opts)

      local function map(key, dir, buffer)
        vim.keymap.set("n", key, function()
          require("illuminate")["goto_" .. dir .. "_reference"](false)
        end, {
          desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference",
          buffer = buffer,
        })
      end

      Snacks.toggle({
        name = "Illuminate",
        get = function()
          return not require("illuminate.engine").is_paused()
        end,
        set = function(enabled)
          local m = require "illuminate"
          if enabled then
            m.resume()
          else
            m.pause()
          end
        end,
      }):map "<leader>mi"

      map("]r", "next")
      map("[r", "prev")

      -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("rafi.illuminate", {}),
        callback = function()
          local buffer = vim.api.nvim_get_current_buf()
          map("]r", "next", buffer)
          map("[r", "prev", buffer)
        end,
      })
    end,
  },
}
