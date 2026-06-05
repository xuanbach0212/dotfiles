return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        -- Python
        "ruff",
        "debugpy",
        "basedpyright",

        -- Go
        "gopls",
        "gofumpt",
        "goimports",
        "golangci-lint",
        "delve",
        "go-debug-adapter",

        -- C/C++
        "clangd",
        "clang-format",
        "codelldb",

        -- JavaScript / TypeScript
        "vtsls",
        "tsgo",
        "eslint_d",
        "oxlint",
        "prettier",
        "biome",
        "oxfmt",
        "js-debug-adapter",

        -- Infra / DevOps
        "actionlint",
        "terraform-ls",
        "tflint",
        "dockerfile-language-server",
        "docker-compose-language-service",
        "hadolint",
        "ansible-language-server",
        "ansible-lint",
        "yaml-language-server",

        -- Config / Docs
        "json-lsp",
        "taplo",
        "marksman",
        "markdown-toc",

        -- Shell / Lua
        "tree-sitter-cli",
        "bash-language-server",
        "shellcheck",
        "shfmt",
        "lua-language-server",
        "stylua",

        -- SQL
        "sqlfluff",

        -- Frontend extras
        "tailwindcss-language-server",
        "prisma-language-server",

        -- Makefile
        "mbake",
      },
    },
  },
}
