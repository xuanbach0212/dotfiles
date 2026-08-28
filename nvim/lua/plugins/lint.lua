return {
  "mfussenegger/nvim-lint",
  opts = {
    linters_by_ft = {
      -- Nothing wired up for terraform/tf here on purpose.
      --
      -- `terraform_validate` runs `terraform validate` in the exact directory
      -- of the open file. Terraform state/init is a root-module concept —
      -- submodules under modules/* don't have (and shouldn't need) their own
      -- init, so it just reports "Missing required provider" on every
      -- submodule file.
      --
      -- `tflint` doesn't need init, but every invocation (CLI or the
      -- `--langserver` mode disabled in lsp.lua) leaks a
      -- `tflint --act-as-bundled-plugin` child process that never exits
      -- (terraform-linters/tflint#1808 — go-plugin ignores the shutdown
      -- signal). nvim-lint auto-triggers on BufWritePost/BufReadPost/
      -- InsertLeave, so wiring tflint in here means one leaked process per
      -- save/insert-leave — measured ~170 leaked processes / 5GB RAM over a
      -- single afternoon of normal editing. Run `tflint` manually from a
      -- terminal instead when you actually want a lint pass — that leaks
      -- one process per run instead of accumulating all day.
    },
  },
}
