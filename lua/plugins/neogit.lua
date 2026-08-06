--[[
  neogit — Magit-inspired git interface: status buffer with staged/
  unstaged files, hunks, branches, and popups for commit/push/pull.
  https://github.com/NeogitOrg/neogit
  Docs: `:h neogit`

  Default status-buffer keymaps (kept as-is, documented here for
  reference):
    s        stage file/hunk under cursor       S   stage everything
    u        unstage file/hunk under cursor      U   unstage everything
    c        commit popup (then c=commit, a=amend, ...)
    b        branch popup (create/checkout/delete/list branches)
    p / P    pull / push popup
    <tab>    toggle diff for the item under cursor
    q        close

  Keybinds (this file only):
    <leader>gg   open Neogit status buffer
--]]
vim.pack.add({
  { src = "https://github.com/NeogitOrg/neogit" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/nvim-telescope/telescope.nvim" }, -- optional: pickers inside popups
}, { confirm = false })

require("neogit").setup({})

vim.keymap.set("n", "<leader>gg", "<cmd>Neogit<cr>", { desc = "Git: status (Neogit)" })
