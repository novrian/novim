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

" Avante
" Deps
Plug 'stevearc/dressing.nvim'
Plug 'MunifTanjim/nui.nvim'
Plug 'MeanderingProgrammer/render-markdown.nvim'

" Optional deps
Plug 'nvim-tree/nvim-web-devicons' "or Plug 'echasnovski/mini.icons'
Plug 'HakonHarnes/img-clip.nvim'
Plug 'zbirenbaum/copilot.lua'

" Yay, pass source=true if you want to build from source
Plug 'yetone/avante.nvim', { 'branch': 'main', 'do': 'make' }

call plug#end()

syntax on

set number
set nowrap
set termguicolors
set cursorcolumn
set cursorline

colorscheme monokai

autocmd! User avante.nvim

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

require('avante').setup({
  ---@alias Provider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | string
  provider = "copilot", -- The provider used in Aider mode or in the planning phase of Cursor Planning Mode
  -- WARNING: Since auto-suggestions are a high-frequency operation and therefore expensive,
  -- currently designating it as `copilot` provider is dangerous because: https://github.com/yetone/avante.nvim/issues/1048
  -- Of course, you can reduce the request frequency by increasing `suggestion.debounce`.
  auto_suggestions_provider = "copilot",
  cursor_applying_provider = nil, -- The provider used in the applying phase of Cursor Planning Mode, defaults to nil, when nil uses Config.provider as the provider for the applying phase
  claude = {
    endpoint = "https://api.anthropic.com",
    model = "claude-3-5-sonnet-20241022",
    temperature = 0,
    max_tokens = 4096,
  },
  ---Specify the special dual_boost mode
  ---1. enabled: Whether to enable dual_boost mode. Default to false.
  ---2. first_provider: The first provider to generate response. Default to "openai".
  ---3. second_provider: The second provider to generate response. Default to "claude".
  ---4. prompt: The prompt to generate response based on the two reference outputs.
  ---5. timeout: Timeout in milliseconds. Default to 60000.
  ---How it works:
  --- When dual_boost is enabled, avante will generate two responses from the first_provider and second_provider respectively. Then use the response from the first_provider as provider1_output and the response from the second_provider as provider2_output. Finally, avante will generate a response based on the prompt and the two reference outputs, with the default Provider as normal.
  ---Note: This is an experimental feature and may not work as expected.
  dual_boost = {
    enabled = false,
    first_provider = "copilot",
    second_provider = "openai",
    prompt = "Based on the two reference outputs below, generate a response that incorporates elements from both but reflects your own judgment and unique perspective. Do not provide any explanation, just give the response directly. Reference Output 1: [{{provider1_output}}], Reference Output 2: [{{provider2_output}}]",
    timeout = 60000, -- Timeout in milliseconds
  },
  behaviour = {
    auto_suggestions = false, -- Experimental stage
    auto_set_highlight_group = true,
    auto_set_keymaps = true,
    auto_apply_diff_after_generation = false,
    support_paste_from_clipboard = false,
    minimize_diff = true, -- Whether to remove unchanged lines when applying a code block
    enable_token_counting = true, -- Whether to enable token counting. Default to true.
    enable_cursor_planning_mode = false, -- Whether to enable Cursor Planning Mode. Default to false.
    enable_claude_text_editor_tool_mode = false, -- Whether to enable Claude Text Editor Tool Mode.
  },
  mappings = {
    --- @class AvanteConflictMappings
    diff = {
      ours = "co",
      theirs = "ct",
      all_theirs = "ca",
      both = "cb",
      cursor = "cc",
      next = "]x",
      prev = "[x",
    },
    suggestion = {
      accept = "<M-l>",
      next = "<M-]>",
      prev = "<M-[>",
      dismiss = "<C-]>",
    },
    jump = {
      next = "]]",
      prev = "[[",
    },
    submit = {
      normal = "<CR>",
      insert = "<C-s>",
    },
    cancel = {
      normal = { "<C-c>", "<Esc>", "q" },
      insert = { "<C-c>" },
    },
    sidebar = {
      apply_all = "A",
      apply_cursor = "a",
      retry_user_request = "r",
      edit_user_request = "e",
      switch_windows = "<Tab>",
      reverse_switch_windows = "<S-Tab>",
      remove_file = "d",
      add_file = "@",
      close = { "<Esc>", "q" },
      close_from_input = nil, -- e.g., { normal = "<Esc>", insert = "<C-d>" }
    },
  },
  hints = { enabled = true },
  windows = {
    ---@type "right" | "left" | "top" | "bottom"
    position = "right", -- the position of the sidebar
    wrap = true, -- similar to vim.o.wrap
    width = 30, -- default % based on available width
    sidebar_header = {
      enabled = true, -- true, false to enable/disable the header
      align = "center", -- left, center, right for title
      rounded = true,
    },
    input = {
      prefix = "> ",
      height = 8, -- Height of the input window in vertical layout
    },
    edit = {
      border = "rounded",
      start_insert = true, -- Start insert mode when opening the edit window
    },
    ask = {
      floating = false, -- Open the 'AvanteAsk' prompt in a floating window
      start_insert = true, -- Start insert mode when opening the ask window
      border = "rounded",
      ---@type "ours" | "theirs"
      focus_on_apply = "ours", -- which diff to focus after applying
    },
  },
  highlights = {
    ---@type AvanteConflictHighlights
    diff = {
      current = "DiffText",
      incoming = "DiffAdd",
    },
  },
  --- @class AvanteConflictUserConfig
  diff = {
    autojump = true,
    ---@type string | fun(): any
    list_opener = "copen",
    --- Override the 'timeoutlen' setting while hovering over a diff (see :help timeoutlen).
    --- Helps to avoid entering operator-pending mode with diff mappings starting with `c`.
    --- Disable by setting to -1.
    override_timeoutlen = 500,
  },
  suggestion = {
    debounce = 600,
    throttle = 600,
  },
})
EOF

" nvim tree toggle mapping "
map <C-\> :NvimTreeToggle<CR>

" telescope mapping "
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
