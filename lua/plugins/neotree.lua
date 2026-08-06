--[[
  neo-tree.nvim — sidebar file explorer (a la Doom Emacs' treemacs).
  https://github.com/nvim-neo-tree/neo-tree.nvim
  Pinned to the "v3.x" branch: that's the maintained stable line, `main`
  tracks unreleased work.

  Keybinds (this file only):
    <leader>op   toggle explorer, revealing the current file
--]]
vim.pack.add({
  { src = "https://github.com/nvim-neo-tree/neo-tree.nvim", version = "v3.x" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/MunifTanjim/nui.nvim" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
}, { confirm = false })

require("neo-tree").setup({
  filesystem = {
    filtered_items = {
      hide_dotfiles = false,
      hide_gitignored = false,
      never_show = { "vendor", "node_modules", ".git" },
    },
    follow_current_file = { enabled = true },
  },
})

vim.keymap.set("n", "<leader>op", "<cmd>Neotree toggle reveal<cr>", { desc = "Explorer: toggle" })
