--[[
  Misc editor autocommands not tied to a specific plugin.
--]]

-- Briefly highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight yanked text",
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Reopen files at the last edited line
vim.api.nvim_create_autocmd("BufReadPost", {
  desc = "Restore cursor position",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Close utility windows with 'q' or <Esc>
vim.api.nvim_create_autocmd("FileType", {
  desc = "Close with q or <Esc>",
  pattern = { "help", "qf", "lspinfo", "checkhealth", "man", "gitsigns-blame" },
  callback = function(ev)
    local o = { buffer = ev.buf, silent = true }
    vim.keymap.set("n", "q", "<cmd>close<cr>", o)
    vim.keymap.set("n", "<Esc>", "<cmd>close<cr>", o)
  end,
})
