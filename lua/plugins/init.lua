--[[
  Loads every plugin module. Each file in this directory is
  self-contained: it declares its own vim.pack.add() spec(s), then
  immediately configures itself (setup + keymaps), with a comment header
  documenting what it is and why it's here.

  Order below is mostly cosmetic; the couple of places it matters are
  called out in the relevant file (e.g. mason before mason-lspconfig,
  both inside lsp.lua; image after telescope, since it overrides
  telescope's previewer config).
--]]

require("plugins.colorscheme")
require("plugins.treesitter")
require("plugins.telescope")
require("plugins.image")
require("plugins.completion")
require("plugins.copilot")
require("plugins.lsp")
require("plugins.autopairs")
require("plugins.gitsigns")
require("plugins.neogit")
require("plugins.lualine")
require("plugins.neotree")
require("plugins.blade")
require("plugins.laravel")
require("plugins.whichkey")
