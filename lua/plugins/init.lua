return {
  -- -- Colorschemes
  {
    "marko-cerovac/material.nvim",
    opts = {},
    config = function(_, opts)
      require("material").setup(opts)
      vim.g.material_style = "darker"
      -- vim.cmd("colorscheme material")
    end,
  },
  "tanvirtin/monokai.nvim",
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("kanagawa").setup()
      vim.cmd("colorscheme kanagawa-dragon")
    end,
  },
}
