return {
  "nvim-tree/nvim-web-devicons",
  lazy = false,
  priority = 1000,
  enabled = true,
  config = function()
    require("nvim-web-devicons").setup({
      override = {
        zsh = {
          icon = "",
          color = "#428850",
          name = "Zsh",
        },
        ["tailwind.config.js"] = {
          icon = "󱏿",
          color = "#38BDF8",
          name = "TailwindConfigJs",
        },
        ["tailwind.config.ts"] = {
          icon = "󱏿",
          color = "#38BDF8",
          name = "TailwindConfigTs",
        },
      },
      default = true,
      color_icons = true,
      override_by_filename = {
        [".gitignore"] = {
          icon = "",
          color = "#f1502f",
          name = "Gitignore",
        },
      },
      override_by_extension = {
        ["log"] = {
          icon = "󰒺",
          color = "#81e043",
        },
      },
      override_by_operating_system = {
        ["apple"] = {
          icon = "",
          color = "#A2AAAD",
          cterm_color = "248",
          name = "Apple",
        },
      },
    })
  end,
}
