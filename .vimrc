call plug#begin()

Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'kylechui/nvim-surround'
Plug 'numToStr/Comment.nvim'
Plug 'folke/todo-comments.nvim'
Plug 'ray-x/go.nvim'
Plug 'ray-x/guihua.lua'
Plug 'rmagatti/auto-session'
Plug 'editorconfig/editorconfig-vim'
Plug 'akinsho/bufferline.nvim', { 'tag': '*' }
Plug 'windwp/nvim-autopairs'
Plug 'jghauser/mkdir.nvim'
Plug 'tpope/vim-repeat'
Plug 'ggandor/leap.nvim'
Plug 'm4xshen/smartcolumn.nvim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' }
Plug 'jparise/vim-graphql'
Plug 'MeanderingProgrammer/render-markdown.nvim'
Plug 'folke/trouble.nvim'
Plug 'stevearc/conform.nvim'

" Colorscheme
Plug 'marko-cerovac/material.nvim'
Plug 'tanvirtin/monokai.nvim'

" Cmp related plugin
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

" Avante {
" ==============================================================================
" Deps
" Plug 'stevearc/dressing.nvim'
" Plug 'MunifTanjim/nui.nvim'
" Plug 'MeanderingProgrammer/render-markdown.nvim'
"
" Optional deps
" Plug 'echasnovski/mini.pick'
" Plug 'HakonHarnes/img-clip.nvim'
" Plug 'zbirenbaum/copilot.lua'
" Plug 'junegunn/fzf.vim'
" Plug 'ibhagwan/fzf-lua'
"
" Yay, pass source=true if you want to build from source
" Plug 'yetone/avante.nvim', { 'branch': 'main', 'do': 'make' }
" } ============================================================================

" CodeCompanion {
" ==============================================================================
Plug 'github/copilot.vim'
Plug 'olimorris/codecompanion.nvim'
" } ============================================================================

call plug#end()

syntax on

set number
set nowrap
set termguicolors
set cursorcolumn
set cursorline

colorscheme monokai

lua << EOF
-- setup nvim treesitter
-- ================================================================================
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "lua", "vim", "query", "go", "bash", "css", "dockerfile", "gitcommit", "gitignore", "gomod", "gosum", "graphql", "html", "ini", "json", "make", "markdown", "php", "python", "regex", "scss", "sql", "typescript", "tsx", "vue", "yaml"},

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,
}

-- setup lualine
-- ================================================================================
require("lualine").setup()

-- setup nvim tree
-- ================================================================================
-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- empty setup using defaults
require("nvim-tree").setup()

-- OR setup with some options
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

-- setup Comment
require('Comment').setup()

-- setup todo-comments
-- @TODO: create debug mapping
require("todo-comments").setup{}

-- setup go
require('go').setup()
local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.go",
    callback = function()
        require('go.format').goimport()
    end,
    group = format_sync_grp,
})

-- Set up nvim-cmp.
local cmp = require'cmp'
cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
      per_filetype = {
        codecompanion = { "codecompanion" }
      },
    }, {
      { name = 'buffer' },
    })
  }
)
-- Set up lspconfig.
local lspconfig = require('lspconfig')
local configs = require('lspconfig/configs')
local util = require('lspconfig/util')
local path = util.path
local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- Golang LSP Config
lspconfig['gopls'].setup {
	capabilities = capabilities,
	on_attach = on_attach,
}
-- Emmet LSP Config
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
lspconfig['emmet_ls'].setup({
    -- on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less', 'php' },
    init_options = {
      html = {
        options = {
          -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
          ["bem.enabled"] = true,
        },
      },
    }
})
lspconfig.ts_ls.setup{}
lspconfig.phpactor.setup{}

local function get_python_path(workspace)
  -- Use activated virtualenv.
  if vim.env.VIRTUAL_ENV then
    return path.join(vim.env.VIRTUAL_ENV, 'bin', 'python')
  end

  -- Find and use virtualenv in workspace directory.
  for _, pattern in ipairs({'*', '.*'}) do
    local match = vim.fn.glob(path.join(workspace, 'poetry.lock'))
    if match ~= '' then
        local venv = vim.fn.trim(vim.fn.system('poetry env info -p'))
        return path.join(venv, 'bin', 'python')
    end
  end
  -- Find and use virtualenv via poetry in workspace directory.

  -- Fallback to system Python.
  return exepath('python3') or exepath('python') or 'python'
end

lspconfig.pyright.setup({
  before_init = function(_, config)
    config.settings.python.pythonPath = get_python_path(config.root_dir)
  end,
  capabilities = capabilities,
})

-- setup auto-session
require("auto-session").setup{}

-- setup bufferline
require("bufferline").setup{}

-- setup nvim-autopairs
require("nvim-autopairs").setup {}

-- setup leap motion
require('leap').add_default_mappings()

-- setup smart column
require("smartcolumn").setup()

require("nvim-surround").setup()

-- begin CodeCompanion Setup
-- ================================================================================
require("codecompanion").setup({
  strategies = {
    chat = {
      adapter = "copilot",
    },
    inline = {
      adapter = "copilot",
    },
    cmd = {
      adapter = "copilot",
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
  },
})
vim.keymap.set("n", "<Leader><Space>", function()
  require("codecompanion").chat()
end, { desc = "CodeCompanion Chat" })
-- ================================================================================
-- end CodeCompanion Setup

require('render-markdown').setup({
    file_types = { 'markdown', 'codecompanion' },
})

vim.keymap.set("n", "<Leader>xx", function()
    require("trouble").toggle('diagnostics')
end, { desc = "Toggle Trouble" })

require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    -- Conform will run the first available formatter
    javascript = { "prettierd", "prettier", stop_after_first = true },
    typescript = { "prettierd", "prettier", stop_after_first = true },
    typescriptreact = { "prettierd", "prettier", stop_after_first = true },
  },
})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    require("conform").format({ bufnr = args.buf })
  end,
})
EOF

" nvim tree toggle mapping "
map <C-\> :NvimTreeToggle<CR>

" telescope mapping "
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
