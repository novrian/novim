return {
  -- -- Colorschemes
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
}
