-- Entry point.
--
-- Load order matters: leader keys must be set before any plugin config
-- runs (which-key, telescope and laravel.nvim keymaps all read <leader>).

if vim.fn.has("nvim-0.12") == 0 then
  vim.notify("This config targets Neovim >= 0.12 (uses vim.pack).", vim.log.levels.WARN)
end

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("core.options")
require("core.keymaps")
require("core.autocmds")
require("plugins")
