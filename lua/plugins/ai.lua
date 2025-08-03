return {
  "github/copilot.vim",
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "echasnovski/mini.diff",
      "j-hui/fidget.nvim",
    },
    opts = {
      strategies = {
        chat = {
          adapter = "copilot",
          model = "claude-3.7-sonnet",
        },
        inline = {
          adapter = "copilot",
          model = "claude-3.7-sonnet",
        },
        cmd = {
          adapter = "copilot",
          model = "claude-3.7-sonnet",
        }
      },
      display = {
        chat = {
          -- Options to customize the UI of the chat buffer
          window = {
            layout = "vertical", -- float|vertical|horizontal|buffer
            position = "right", -- left|right|top|bottom (nil will default depending on vim.opt.plitright|vim.opt.splitbelow)
            border = "single",
            height = 0.8,
            width = 0.25,
            relative = "editor",
            full_height = true, -- when set to false, vsplit will be used to open the chat buffer vs. botright/topleft vsplit
            opts = {
              breakindent = true,
              cursorcolumn = false,
              cursorline = false,
              foldcolumn = "0",
              linebreak = true,
              list = false,
              numberwidth = 1,
              signcolumn = "no",
              spell = false,
              wrap = true,
            }
          },
        },
        diff = {
          provider = "mini_diff",
        },
      },
      adapters = {
        copilot = function()
          return require("codecompanion.adapters").extend("copilot", {
            schema = {
              model = {
                default = "claude-3.7-sonnet",
              },
            },
          })
        end,
      },

    },
    keys = {
      { "<Leader><Space>", "<cmd>CodeCompanionChat<cr>", desc = "Open Codecompanion Chat" },
    },
  },
}
