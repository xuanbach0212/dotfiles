return {
  {
    "mikavilpas/yazi.nvim",
    keys = {
      { "<leader>yz", "<cmd>Yazi<cr>", desc = "Open Yazi" },
    },
    opts = {
      open_for_directories = false,
      change_neovim_cwd_on_close = false,
      yazi_floating_window_border = "rounded",
    },
  },
}
