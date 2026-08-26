config {
  # Default ("local") makes tflint recursively lint every module reached via
  # a local `source = "../..."` path. On a repo with hundreds of modules
  # (e.g. environments/poc calling 100+ modules/*) that fans out into
  # thousands of worker processes and pegs the machine. "none" restricts
  # tflint to only the directory it's actually invoked in.
  call_module_type = "none"
}

plugin "terraform" {
  enabled = true
  preset  = "recommended"
}

plugin "aws" {
  enabled = true
  version = "0.48.0"
  source  = "github.com/terraform-linters/tflint-ruleset-aws"
}
