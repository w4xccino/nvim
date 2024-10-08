local opt = vim.opt
local g = vim.g

opt.wrap = false
opt.clipboard = "unnamedplus"

opt.number = true
opt.relativenumber = true
opt.undofile = true
opt.cursorline = true
opt.ignorecase = true

g.mapleader = " "
g.maplocalleader = "\\"

require("config.lazy")
require("current-theme")
