---@type LazySpec
return {
  "mikavilpas/yazi.nvim",
  version = "*", -- use the latest stable version
  event = "VeryLazy",
  dependencies = {
    { "nvim-lua/plenary.nvim", lazy = true },
  },
  keys = {
    -- 👇 in this section, choose your own keymappings!
    {
      "<leader>e",
      mode = { "n", "v" },
      "<cmd>Yazi<cr>",
      desc = "[Yazi] Open yazi at the current file",
    },
    {
      -- Open in the current working directory
      "<leader>E",
      "<cmd>Yazi cwd<cr>",
      desc = "[Yazi] Open the file manager in nvim's working directory",
    },
    {
      "<leader>t",
      "<cmd>Yazi toggle<cr>",
      desc = "[Yazi] Resume the last yazi session",
    },
  },
  ---@type YaziConfig | {}
  opts = {
    -- if you want to open yazi instead of netrw, see below for more info
    open_for_directories = false,
    keymaps = {
      show_help = "<f1>",
      -- open_file_in_vertical_split = "<c-v>",
      -- open_file_in_horizontal_split = "<c-x>",
      -- open_file_in_tab = "<c-t>",
      -- grep_in_directory = "<c-s>",
      -- replace_in_directory = "<c-g>",
      -- cycle_open_buffers = "<tab>",
      -- copy_relative_path_to_selected_files = "<c-y>",
      -- send_to_quickfix_list = "<c-q>",
      change_working_directory = "<c-\\>",
      open_and_pick_window = "<c-o>",
    },
    -- the floating window scaling factor. 1 means 100%, 0.9 means 90%, etc.
    floating_window_scaling_factor = 0.9,

    -- the transparency of the yazi floating window (0-100). See :h winblend
    yazi_floating_window_winblend = 0,

    -- the type of border to use for the floating window. Can be many values,
    -- including 'none', 'rounded', 'single', 'double', 'shadow', etc. For
    -- more information, see :h nvim_open_win
    yazi_floating_window_border = "rounded",
  },
  -- 👇 if you use `open_for_directories=true`, this is recommended
  init = function()
    -- mark netrw as loaded so it's not loaded at all.
    --
    -- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
    vim.g.loaded_netrwPlugin = 1
  end,
}
