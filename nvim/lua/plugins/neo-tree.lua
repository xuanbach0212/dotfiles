return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- icon
    "MunifTanjim/nui.nvim",
  },
  cmd = "Neotree",
  keys = {
    { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Explorer NeoTree (root dir)" },
    { "<leader>E", "<cmd>Neotree toggle reveal_force_cwd<cr>", desc = "Explorer NeoTree (cwd)" },
  },
  init = function()
    vim.g.load_netrw = 1
    vim.g.loaded_netrwPlugin = 1
  end,
  priority = 1001,
  enabled = true,
  opts = {
    close_if_last_window = true,
    enable_git_status = true,
    enable_diagnostics = true,
    filesystem = {
      follow_current_file = {
        enabled = true,
      },
      filtered_items = {
        visible = true, -- show hidden files
        hide_dotfiles = false, -- don't hide dotfiles
        hide_gitignored = false,
        hide_hidden = false, -- show hidden files on Windows
        hide_by_name = {},
        never_show = {},
      },
    },
    default_component_configs = {
      indent = {
        with_markers = true,
        highlight = "NeoTreeIndentMarker",
      },
      icon = {
        folder_closed = "",
        folder_open = "",
        folder_empty = "󰜌",
        default = "",
      },
      name = {
        trailing_slash = false,
        use_git_status_colors = true,
      },
      git_status = {
        symbols = {
          added = "",
          modified = "",
          deleted = "",
          renamed = "➜",
          untracked = "★",
          ignored = "◌",
          unstaged = "✗",
          staged = "✓",
          conflict = "",
        },
      },
    },
  },
}
