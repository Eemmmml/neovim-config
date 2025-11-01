return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local configs = require "nvim-treesitter.configs"
      local install = require "nvim-treesitter.install"

      -- 配置 curl 证书
      install.command_extra_args = {
        curl = {
          -- 方案1: 指定正确的证书路径（推荐）
          "--cacert",
          "/System/Volumes/Data/opt/homebrew/etc/openssl@3/cert.pem", -- 根据你的系统修改为实际路径

          -- 方案2: 临时禁用 SSL 验证（不推荐长期使用）
          --"--insecure"
        },
      }

      configs.setup {
        auto_install = true,
        ensure_installed = {
          "c",
          "lua",
          "vim",
          "vimdoc",
          "query",
          "elixir",
          "heex",
          "javascript",
          "html",
          "python",
          "latex",
          "markdown",
          "markdown_inline",
        },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
        markdown = { enable = true },
      }
    end,
  },
}
