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
require("telescope").load_extension('cmdline')
require("telescope").load_extension('neorg')
require("telescope").load_extension("zf-native")

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>o', builtin.find_files, {})

-- vim.keymap.set('n', ':', ':Telescope cmdline<CR>', { noremap = true, desc = "Cmdline" })
