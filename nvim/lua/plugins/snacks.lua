return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    explorer = { enabled = false },
    scratch = { enabled = true },
  },
  keys = {
    { "<leader>bs", function() Snacks.scratch({ ft = "markdown" }) end, desc = "Scratch Buffer" },
  },
}
