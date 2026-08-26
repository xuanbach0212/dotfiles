return {
  -- Disable inlay hints for all LSP servers
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = {
        enabled = false,
      },
      servers = {
        -- `tflint` also has a built-in nvim-lspconfig server definition that
        -- runs `tflint --langserver` as a persistent process. It's redundant
        -- with nvim-lint's tflint (see lint.lua), and langserver mode has a
        -- known history of leaking `--act-as-bundled-plugin`/ruleset child
        -- processes on shutdown (terraform-linters/tflint#1808) — that's
        -- what fanned out to ~2000 processes on this machine. Keep tflint
        -- as a one-shot CLI linter only, not a persistent LSP server.
        tflint = { enabled = false },
        basedpyright = {
          handlers = {
            ["$/progress"] = function(err, result, ctx)
              if result.token == (vim.g.basedpyright_progress_token or result.token) then
                vim.g.basedpyright_progress_token = result.token
                vim.lsp.handlers["$/progress"](err, result, ctx)
              end
            end,
          },
          settings = {
            basedpyright = {
              analysis = {
                typeCheckingMode = "off",
                autoImportCompletions = true,
              },
            },
          },
        },
      },
    },
  },
}
