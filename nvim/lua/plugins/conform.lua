return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      -- ruff_fix runs `ruff check --fix` (sorts imports via isort rules)
      -- ruff_format runs `ruff format` (code formatting)
      python = { "ruff_fix", "ruff_format" },
    },
  },
}
