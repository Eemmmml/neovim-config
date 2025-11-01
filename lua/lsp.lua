return {
  -- 安装Mason
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {},
    },
    opts_extend = { "ensure_installed" },
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require "mason-registry"

      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end
      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
  },
  -- 安装nvim-lspconfig
  {
    "neovim/nvim-lspconfig",
    dependencies = { "saghen/blink.cmp" },

    -- example calling setup directly for each LSP
    config = function()
      vim.diagnostic.config {
        underline = false,
        signs = false,
        update_in_insert = false,
        virtual_text = { spacing = 2, prefix = "●" },
        serverity_sort = true,
        float = { border = "rounded", bg = "none" },
      }

      -- Use LspAttach autocommand to only map the following keys
      -- after the language server attaches to the current buffer
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          vim.keymap.set("n", "K", vim.lsp.buf.hover) -- configured in "nvim-ufo" plugin
          vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, {
            buffer = ev.buf,
            desc = "[LSP] Show diagnostic",
          })
          -- vim.keymap.set("n", "<leader>gk", vim.lsp.buf.signature_help, { desc = "[LSP] Signature help" })
          -- vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { desc = "[LSP] Add workspace folder" })
          -- vim.keymap.set(
          --   "n",
          --   "<leader>wr",
          --   vim.lsp.buf.remove_workspace_folder,
          --   { desc = "[LSP] Remove workspace folder" }
          -- )
          -- vim.keymap.set("n", "<leader>wl", function()
          --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          -- end, { desc = "[LSP] List workspace folders" })
          vim.keymap.set("n", "<leader>lrn", vim.lsp.buf.rename, { buffer = ev.buf, desc = "[LSP] Rename" })
        end,
      })

      local capabilities = require("blink.cmp").get_lsp_capabilities()
      local lspconfig = require "lspconfig"

      -- lspconfig["lua_ls"].setup { capabilities = capabilities }
      -- lspconfig["pyright"].setup { capabilities = capabilities }
      -- lspconfig["clangd"].setup { capabilities = capabilities }
      -- lspconfig["marksman"].setup { capabilities = capabilities }
      -- lspconfig["texlab"].setup { capabilities = capabilities }
      -- lspconfig["ltex-ls"].setup { capabilities = capabilities }
      vim.lsp.enable("lua_ls", { capabilities = capabilities })
      vim.lsp.enable("pyright", { capabilities = capabilities })
      vim.lsp.enable("clangd", { capabilities = capabilities })
      vim.lsp.enable("marksman", { capabilities = capabilities })
      vim.lsp.enable("texlab", { capabilities = capabilities })
      vim.lsp.enable("ltex-ls", { capabilities = capabilities })
    end,
  },
  -- 代码格式化
  {
    "stevearc/conform.nvim",
    opts = {
      -- 自定义格式化工具配置
      formatters = {
        stylua = {
          prepend_args = {
            "--indent-width",
            "2", -- 缩进宽度设置为 2 空格
            "--indent-type",
            "Spaces", -- 强制使用空格（非制表符）
            "--collapse-simple-statement",
            "Never", -- 禁止折叠简单语句
            "--quote-style",
            "AutoPreferDouble", -- 引号样式
            "--call-parentheses",
            "None", -- 移除不必要的调用括号
          },
        },
        ["markdown-toc"] = {
          condition = function(_, ctx)
            for _, line in ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false)) do
              if line:find "<!%-%- toc %-%->" then
                return true
              end
            end
          end,
        },
        ["markdownlint-cli2"] = {
          condition = function(_, ctx)
            local diag = vim.tbl_filter(function(d)
              return d.source == "markdownlint"
            end, vim.diagnostic.get(ctx.buf))
            return #diag > 0
          end,
        },
      },
      formatters_by_ft = {
        lua = { "stylua" },
        -- Conform will run multiple formatters sequentially
        python = { "isort", "black" },
        -- You can customize some of the format options for the filetype (:help conform.format)
        -- rust = { "rustfmt", lsp_format = "fallback" },
        -- Conform will run the first available formatter
        -- javascript = { "prettierd", "prettier", stop_after_first = true },
        markdown = { "prettier", "markdownlint-cli2", "markdown-toc" },
      },
      format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_format = "fallback",
      },
    },
  },
}
