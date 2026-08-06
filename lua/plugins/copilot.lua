--[[
  copilot.lua — GitHub Copilot inline suggestions (ghost text as you type).
  https://github.com/zbirenbaum/copilot.lua
  Docs: `:h copilot.lua`, `:Copilot status`, `:Copilot panel`

  First-time setup (manual, one-time, do this yourself in Neovim):
    :Copilot auth
  It prints a device code + a github.com/login/device URL — open it,
  paste the code, approve for your GitHub account. Requires an active
  Copilot subscription on that account.

  Suggestions are a separate mechanism from the blink.cmp completion
  menu, so they get their own keymaps instead of going through blink:

  Keybinds (this file only, insert mode):
    <C-l>   accept suggestion
    <C-]>   dismiss suggestion
    <M-]>   next suggestion
    <M-[>   prev suggestion
--]]
vim.pack.add({
  { src = "https://github.com/zbirenbaum/copilot.lua" },
}, { confirm = false })

require("copilot").setup({
  suggestion = {
    auto_trigger = true,
    keymap = {
      accept = "<C-l>",
      next = "<M-]>",
      prev = "<M-[>",
      dismiss = "<C-]>",
    },
  },
  panel = { enabled = false },
})
