return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opt = {
      ensure_installed = { "c", "lua", "vim", "query", "go", "bash", "css", "dockerfile", "gitcommit", "gitignore", "gomod", "gosum", "graphql", "html", "ini", "json", "make", "markdown", "php", "python", "regex", "scss", "sql", "typescript", "tsx", "vue", "yaml"},

      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,

      -- Automatically install missing parsers when entering buffer
      -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
      auto_install = true,

      highlight = {
        enable = true,
      },
    }
  },
  "nvim-treesitter/nvim-treesitter-textobjects",
}
