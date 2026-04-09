return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        -- Python
        "ruff",
        "debugpy",

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
        "eslint_d",
        "prettier",
        "js-debug-adapter",

        -- Infra / DevOps
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
        "markdownlint-cli2",
        "marksman",
        "markdown-toc",

        -- Shell / Lua
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
      },
    },
  },
}
