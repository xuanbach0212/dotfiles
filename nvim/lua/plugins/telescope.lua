return {
  "nvim-telescope/telescope.nvim",
  opts = {
    defaults = {
      file_ignore_patterns = { "^.git/" },
    },
    pickers = {
      find_files = {
        hidden = true,
        find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
      },
    },
  },
  keys = {
    {
      "<leader><space>",
      function()
        require("telescope.builtin").find_files({
          cwd = vim.uv.cwd(),
          hidden = true,
          find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
        })
      end,
      desc = "Find Files (cwd)",
    },
    {
      "<leader>ff",
      function()
        require("telescope.builtin").git_files()
      end,
      desc = "Find Files (git)",
    },
  },
}
