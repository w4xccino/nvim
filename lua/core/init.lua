local opt = vim.opt
local g = vim.g

opt.wrap = false
opt.clipboard = "unnamedplus"

opt.relativenumber = true

g.mapleader = " "
g.maplocalleader = "\\"

require("config.lazy")
