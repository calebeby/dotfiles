--- lazy.nvim setup
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

--- MY OWN SETUP

vim.opt.relativenumber = true
vim.opt.number = true

vim.opt.termguicolors = true

-- Permanent undo
vim.opt.undodir = '~/.vimdid'

-- Use system clipboard (requires xsel)
vim.opt.clipboard = 'unnamedplus'

-- New windows down and to the right
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Tab characters are 2 spaces wide
vim.opt.tabstop = 2

-- When indenting with << and >> use 2 spaces width
vim.opt.shiftwidth = 2

-- When pressing tab, use spaces
vim.opt.expandtab = true

-- Quit
vim.keymap.set('n', '<c-q>', ':qall<CR>', { silent = true })

-- Clear search by pressing <esc>
vim.keymap.set('n', '<esc>', ':noh<CR><ESC>', { silent = true })

-- Briefly highlight yanked text
local yank_group = vim.api.nvim_create_augroup('HighlightYank', {})
vim.api.nvim_create_autocmd('TextYankPost', {
  group = yank_group,
  pattern = '*',
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 100 })
  end,
})

-- Use space as leader
vim.g.mapleader = ' '

require("lazy").setup({
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "octaltree/cmp-look",
    },
    config = function ()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      require('mason').setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "rust_analyzer", "tsserver" },
        handlers = {
          function(server_name)
            require("lspconfig")[server_name].setup {
              capabilities = capabilities
            }
          end,
          ["lua_ls"] = function()
            local lspconfig = require("lspconfig")
            lspconfig.lua_ls.setup {
              capabilities = capabilities,
              settings = {
                Lua = {
                  runtime = { version = "Lua 5.1" },
                  diagnostics = {
                    globals = { "vim" },
                  }
                }
              }
            }
          end,
        }
      })

      local cmp = require'cmp'

      cmp.setup({
        snippet = {
          expand = function(args)
            vim.snippet.expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<Tab>'] = function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end,
          ['<c-j>'] = function(fallback)
            if cmp.visible() then
              cmp.confirm({ select = true })
            else
              fallback()
            end
          end,
          ['<s-Tab>'] = function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end,
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<C-Space>'] = function(fallback)
            if cmp.visible() then
              fallback()
            else
              cmp.select_next_item()
            end
          end,
        }),
        sources = cmp.config.sources(
          {
            { name = 'soippets' },
          },
          {
            { name = 'nvim_lsp' },
          },
          {
            {
              name = 'buffer',
              keyword_length = 4,
            },
          },
          {
            {
              name = 'look',
              keyword_length = 5,
              option = {
                convert_case = true,
                loud = true
              }
            },
          }
        ),
        experimental = {
          ghost_text = true,
        },
      })

      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
            { name = 'cmdline' }
          }),
        matching = { disallow_symbol_nonprefix_matching = false }
      })
    end
  },
  "folke/tokyonight.nvim",
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function ()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        ensure_installed = {
          "typescript",
          "javascript",
          "tsx",
          "jsdoc",
          "regex",
          "c",
          "cpp",
          "rust",
          "svelte",
          "html",
          "css",
          "json",
          "astro",
          "markdown",
          "zig",
          "lua",
          "vim",
          "yaml",
          "bash",
          "sql",
          "djot",
          "typst",
          "norg",
        },
        highlight = {
          enable = true,
        },
        indent = {
          enable = true
        },
        -- Expanding selection
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<leader>c",
            node_incremental = "<leader>c",
            scope_incremental = false,
            node_decremental = "<leader>v",
          },
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["aF"] = "@call.outer",
              ["ab"] = "@block.outer",
              ["ib"] = "@block.inner",
              ["a,"] = "@parameter.outer",
              ["i,"] = "@parameter.inner",
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ["<leader>l"] = "@parameter.inner",
            },
            swap_previous = {
              ["<leader>h"] = "@parameter.inner",
            },
          },
        },
      })
    end
  },
  {
    {
      'nvim-telescope/telescope.nvim', tag = '0.1.6',
      dependencies = {
        'nvim-lua/plenary.nvim',
        "nvim-telescope/telescope-ui-select.nvim",
        "debugloop/telescope-undo.nvim",
        "natecraddock/telescope-zf-native.nvim",
      },
      config = function ()
        local actions = require('telescope.actions')
        require('telescope').setup{
          defaults = {
            mappings = {
              i = {
                ["<esc>"] = actions.close,
              },
            },
          },
          pickers = {
            colorscheme = {
              enable_preview = true
            }
          },
          extensions = {
            ["ui-select"] = {
              require("telescope.themes").get_dropdown {}
            },
            undo = {
              side_by_side = true,
              diff_context_lines = 5,
              mappings = {
                i = {
                  ["<cr>"] = require("telescope-undo.actions").restore,
                },
              },
            }
          }
        }

        require("telescope").load_extension("ui-select")
        require("telescope").load_extension("undo")
        require("telescope").load_extension('neorg')
        require("telescope").load_extension("zf-native")

        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>o', builtin.find_files, {})
      end
    },
  },
  {
    "vhyrro/luarocks.nvim",
    priority = 1000,
    config = true,
  },
  {
    "nvim-neorg/neorg",
    dependencies = { "luarocks.nvim", "nvim-neorg/neorg-telescope" },
    config = true,
  },
})

vim.cmd([[colorscheme tokyonight]])


-- Window mappings
vim.keymap.set('n', '<Leader>w', '<c-w>')
vim.keymap.set('n', '<a-h>', '<c-w>h')
vim.keymap.set('n', '<a-j>', '<c-w>j')
vim.keymap.set('n', '<a-k>', '<c-w>k')
vim.keymap.set('n', '<a-l>', '<c-w>l')
vim.keymap.set('t', '<a-h>', '<c-\\><c-n><c-w>h')
vim.keymap.set('t', '<a-j>', '<c-\\><c-n><c-w>j')
vim.keymap.set('t', '<a-k>', '<c-\\><c-n><c-w>k')
vim.keymap.set('t', '<a-l>', '<c-\\><c-n><c-w>l')

-- Save file
vim.keymap.set('n', '<Leader>s', ':write<CR>', { silent = true })

-- Reload/refresh vimrc
vim.keymap.set('n', '<Leader>kr', ':source $MYVIMRC<CR>', { silent = true })

vim.keymap.set('n', 'gr', ':Telescope lsp_references<CR>', { silent = true })
vim.keymap.set('n', 'gd', ':Telescope lsp_definitions<CR>', { silent = true })
vim.keymap.set('n', 'gD', ':Telescope lsp_type_definitions<CR>', { silent = true })
