--[[
  gitsigns.nvim — git change markers in the sign column, hunk
  stage/reset/preview, and inline blame.
  https://github.com/lewis6991/gitsigns.nvim
  Docs: `:h gitsigns`

  Keybinds (this file only, buffer-local, set on attach):
    ]c / [c        next/prev hunk
    <leader>gs     stage hunk
    <leader>gr     reset hunk
    <leader>gp     preview hunk
    <leader>gb     toggle line blame (inline virtual text)
    <leader>gB     full git-blame view (scroll-bound split); close
                   with q or <Esc> (bound in core/autocmds.lua, filetype
                   "gitsigns-blame")
--]]
vim.pack.add({
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
}, { confirm = false })

require("gitsigns").setup({
  on_attach = function(bufnr)
    local gs = require("gitsigns")
    local map = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
    end

    map("n", "]c", gs.next_hunk, "Next hunk")
    map("n", "[c", gs.prev_hunk, "Prev hunk")
    map("n", "<leader>gs", gs.stage_hunk, "Stage hunk")
    map("n", "<leader>gr", gs.reset_hunk, "Reset hunk")
    map("n", "<leader>gp", gs.preview_hunk, "Preview hunk")
    map("n", "<leader>gb", gs.toggle_current_line_blame, "Toggle line blame")
    map("n", "<leader>gB", gs.blame, "Full git-blame view")
  end,
})
