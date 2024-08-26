return {
  'nvim-tree/nvim-tree.lua',
  lazy = true,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require("nvim-tree").setup {
      update_focused_file = {
        enable = true,
        update_root = true,
      },
    }
  end,
  keys = {
    {'<leader>op', ':NvimTreeToggle <cr>', desc = "Nvim Tree Toggle"},
    {'<leader>e', ':NvimTreeFocus <cr>', desc = "Nvim Tree Focus"}
  },
}
