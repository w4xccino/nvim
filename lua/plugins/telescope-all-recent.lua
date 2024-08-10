return {
  'prochri/telescope-all-recent.nvim',
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "kkharji/sqlite.lua",
    "stevearc/dressing.nvim"
  },
  opts =
    {
      pickers = {
        find_files = {
          theme = 'dropdown',
        },
      },
    },
  keys = {
    {
      '<leader><leader>',
      function ()
        require('telescope.builtin').find_files()
      end,
      desc = 'Testing',
    },
  }
}
