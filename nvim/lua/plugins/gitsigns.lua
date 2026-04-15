return {
  "lewis6991/gitsigns.nvim",
  event = "VeryLazy",
  opts = {
    current_line_blame = true,
    current_line_blame_opts = {
      delay = 500, -- ms before the blame appears
      virt_text_pos = "eol", -- show at end of line
    },
  },
}
