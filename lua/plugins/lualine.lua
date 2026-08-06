--[[
  lualine.nvim — statusline: mode, git branch, diagnostics, filetype...
  https://github.com/nvim-lualine/lualine.nvim
--]]
vim.pack.add({
  { src = "https://github.com/nvim-lualine/lualine.nvim" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
}, { confirm = false })

require("lualine").setup({
  -- catppuccin/nvim ships its own lualine theme per flavour, named
  -- "catppuccin-<flavour>" (not plain "catppuccin"); keep this in sync
  -- with the `flavour` set in plugins/colorscheme.lua.
  options = { theme = "catppuccin-mocha" },
})
