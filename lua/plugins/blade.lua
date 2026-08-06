--[[
  vim-blade — filetype detection + syntax highlighting for Laravel's
  Blade templates (*.blade.php). No tree-sitter grammar for Blade ships
  with nvim-treesitter yet, so this stays a classic syntax-file plugin.
  https://github.com/jwalton512/vim-blade
--]]
vim.pack.add({
  { src = "https://github.com/jwalton512/vim-blade" },
}, { confirm = false })
