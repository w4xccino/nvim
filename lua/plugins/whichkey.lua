--[[
  which-key.nvim — pop-up showing available keybinds as you type a
  prefix (press <leader> and wait). This is what makes every other
  file's keymaps discoverable without memorizing a cheat sheet.
  https://github.com/folke/which-key.nvim
--]]
vim.pack.add({
  { src = "https://github.com/folke/which-key.nvim" },
}, { confirm = false })

require("which-key").setup({})

require("which-key").add({
  { "<leader>f", group = "Find" },
  { "<leader>b", group = "Buffers" },
  { "<leader>g", group = "Git" },
  { "<leader>l", group = "Laravel" },
  { "<leader>c", group = "Code" },
  { "<leader>o", group = "Open" },
})
