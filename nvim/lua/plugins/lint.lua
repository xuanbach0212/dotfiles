return {
  "mfussenegger/nvim-lint",
  opts = {
    linters_by_ft = {
      -- `terraform_validate` runs `terraform validate` in the exact directory
      -- of the open file. Terraform state/init is a root-module concept —
      -- submodules under modules/* don't have (and shouldn't need) their own
      -- init, so that linter just reports "Missing required provider" on
      -- every submodule file. `tflint` covers style/best-practice checks and
      -- never needs init, so it's the only one wired up here.
      terraform = { "tflint" },
      tf = { "tflint" },
    },
  },
}
