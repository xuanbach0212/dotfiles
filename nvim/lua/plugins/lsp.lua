return {
  -- Disable inlay hints for all LSP servers
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = {
        enabled = false,
      },
      servers = {
        -- lang.python extra enables pyright by default; disable it here
        pyright = { enabled = false },
      },
    },
  },

  -- lang.python extra also adds pyright to mason's ensure_installed.
  -- Filter it out so mason stops auto-installing it on startup.
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = vim.tbl_filter(function(s)
        return s ~= "pyright"
      end, opts.ensure_installed or {})
    end,
  },
}
