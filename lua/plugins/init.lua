return {
  "neovim/nvim-lspconfig",

  -- Treesitter
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  "nvim-treesitter/nvim-treesitter-textobjects",

  -- Core plugins
  "nvim-lua/plenary.nvim",
  { "nvim-telescope/telescope.nvim", version = "0.1.8" },
  "nvim-lualine/lualine.nvim",
  "nvim-tree/nvim-web-devicons",
  "nvim-tree/nvim-tree.lua",
  "kylechui/nvim-surround",
  "numToStr/Comment.nvim",
  "folke/todo-comments.nvim",

  -- Go support
  "ray-x/go.nvim",
  "ray-x/guihua.lua",

  -- Editor enhancements
  "rmagatti/auto-session",
  "editorconfig/editorconfig-vim",
  { "akinsho/bufferline.nvim", version = "*" },
  "windwp/nvim-autopairs",
  "jghauser/mkdir.nvim",
  "tpope/vim-repeat",
  "ggandor/leap.nvim",
  "m4xshen/smartcolumn.nvim",

  -- Markdown
  { "iamcco/markdown-preview.nvim", build = "cd app && npx --yes yarn install" },
  "MeanderingProgrammer/render-markdown.nvim",

  -- Language support
  "jparise/vim-graphql",

  -- UI enhancements
  "folke/trouble.nvim",
  "stevearc/conform.nvim",
  "j-hui/fidget.nvim",

  -- Colorschemes
  "marko-cerovac/material.nvim",
  "tanvirtin/monokai.nvim",
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("kanagawa").setup()
      vim.cmd.colorscheme("kanagawa-dragon")
    end,
  },

  -- Completion
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-vsnip",
  "hrsh7th/vim-vsnip",

  -- CodeCompanion
  "github/copilot.vim",
  "echasnovski/mini.diff",
  "olimorris/codecompanion.nvim",
}
