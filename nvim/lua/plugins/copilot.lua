return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      filetypes = {
        c = false,
        cpp = false,
        h = false,
        hpp = false,
        ["*"] = true,
      },
    },
  },
}
