return {
  'nvim-telescope/telescope.nvim',
  event = 'VeryLazy',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-file-browser.nvim',
    'andrew-george/telescope-themes',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
    },
  },
  opts = {
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = 'smart_case',
      },
      themes = {
        persist = {
          enabled = true,
          path = vim.fn.stdpath("config") .. "/lua/colorscheme.lua"
        },
      },
    }
  },
  config = function (opts)
    require('telescope').setup(opts)
    require('telescope').load_extension('fzf')
    require('telescope').load_extension('themes')
  end,
  keys = {
    {
      '<leader>gt',
      function ()
        require('telescope.builtin').git_status({ show_untracked = true })
      end,
      desc = 'Telescope Git Files',
    },
    {
      '<leader>bb',
      function ()
        require('telescope.builtin').buffers()
      end,
      desc = 'Telescope Buffers',
    },
    --{
    --  '<leader><leader>',
    --  function ()
    --    require('telescope.builtin').find_files()
    --  end,
    --  desc = 'Telescope Find Files',
    --},
    {
      '<leader>`',
      function ()
        require('telescope.builtin').resume()
      end,
      desc = 'Telescope Find Files Resume',
    },
    {
      '<leader>.',
      function ()
        require('telescope').extensions.file_browser.file_browser({ path='%:h:p', select_buffer = true })
      end,
      desc = 'Telescope Find Files In Current Directory',
    },
    {
      '<leader>th',
      function ()
        vim.cmd('Telescope themes')
      end,
      desc = 'Change Theme',
    },
    {
      '<leader>/',
      function ()
        require('telescope.builtin').live_grep()
      end,
      desc = 'Telescope Live Grep',
    },
  },
}
