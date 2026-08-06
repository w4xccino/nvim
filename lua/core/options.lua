--[[
  Base editor settings: UI, indentation, search, files.
  Everything plugin-specific lives in lua/plugins/*.lua instead.
--]]

local opt = vim.opt

-- UI
opt.number = true
opt.relativenumber = true
opt.numberwidth = 2 -- default (4) pads more than relative numbers need
opt.cursorline = true
opt.signcolumn = "number" -- merge git/diagnostic signs into the number column
opt.termguicolors = true
opt.scrolloff = 8
opt.wrap = false
opt.splitright = true
opt.splitbelow = true

-- Indentation: 4 spaces by default (PSR-12 / Laravel convention).
-- Per-project overrides: Neovim reads .editorconfig files natively, so a
-- repo that wants something else (e.g. 2-space JS) just works without
-- touching this file.
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true
vim.g.editorconfig = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true

-- Files / undo
opt.undofile = true
opt.swapfile = false
opt.backup = false

-- macOS system clipboard
opt.clipboard = "unnamedplus"

-- Behavior
opt.mouse = "a"
opt.updatetime = 250
opt.timeoutlen = 400 -- how long which-key waits before showing its popup
opt.completeopt = { "menu", "menuone", "noselect" }
