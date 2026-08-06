--[[
  nvim-autopairs — auto-closes brackets/quotes as you type.
  https://github.com/windwp/nvim-autopairs

  Works independently of blink.cmp (triggers on character insertion, not
  on completion), so no extra glue code is needed between the two.
--]]
vim.pack.add({
  { src = "https://github.com/windwp/nvim-autopairs" },
}, { confirm = false })

require("nvim-autopairs").setup({})
