--[[
  catppuccin/nvim — colorscheme.
  https://github.com/catppuccin/nvim

  Soft-contrast palette with first-class integrations for telescope,
  treesitter, gitsigns, which-key, native LSP and neo-tree — the
  "everything matches" polish that makes Doom Emacs themes feel cohesive.
  Flavour is "mocha" (dark); other options: latte, frappe, macchiato.
--]]
vim.pack.add({
  { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
}, { confirm = false })

require("catppuccin").setup({
  flavour = "mocha",
  integrations = {
    telescope = true,
    treesitter = true,
    gitsigns = true,
    which_key = true,
    native_lsp = { enabled = true },
    neotree = true,
    mason = true,
  },
})

vim.cmd.colorscheme("catppuccin")
