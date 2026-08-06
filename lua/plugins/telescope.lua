--[[
  telescope.nvim — fuzzy finder for files, live grep, buffers, help, etc.
  https://github.com/nvim-telescope/telescope.nvim
  Docs: `:h telescope`

  Keybinds (this file only):
    <leader><leader>  find files
    <leader>/         live grep
    <leader>fb        buffers
    <leader>bb        buffers (alias, see lua/plugins/whichkey.lua "b" group)
    <leader>fh        help tags
    <leader>fr        recent files (oldfiles)
    <leader>fd        diagnostics
    <leader>fg        git status (changed files)

  telescope-fzf-native.nvim swaps in the real fzf matching algorithm.
  The plain Lua sorter treats the whole typed query as one ordered
  subsequence (spaces included), so "job model" won't match
  "app/Models/Job.php" — wrong order, and there's no literal space in
  the path. fzf-native ANDs space-separated words instead, matching each
  one fuzzily anywhere, in any order.
  https://github.com/nvim-telescope/telescope-fzf-native.nvim

  It's a C extension and vim.pack.Spec has no declarative `build` field
  (unlike lazy.nvim), so it's compiled via a PackChanged autocmd — the
  pattern from `:h vim.pack-examples`. Needs `make` + a C compiler
  (Xcode Command Line Tools on macOS).
--]]

-- Must be registered before vim.pack.add below so it catches this
-- session's own install/update event.
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    if ev.data.spec.name == "telescope-fzf-native.nvim" and ev.data.kind ~= "delete" then
      vim.system({ "make" }, { cwd = ev.data.path }):wait()
    end
  end,
})

vim.pack.add({
  { src = "https://github.com/nvim-telescope/telescope.nvim" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" },
}, { confirm = false })

local telescope = require("telescope")

telescope.setup({
  defaults = {
    -- Keep results relevant in PHP/Laravel and JS projects by skipping
    -- vendor/build noise. Add repo-specific patterns per-project if needed.
    file_ignore_patterns = {
      "%.git/",
      "vendor/",
      "node_modules/",
      "storage/",
      "bootstrap/cache/",
      "public/build/",
      "public/hot",
      "%.lock",
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
  },
})

telescope.load_extension("fzf")

local builtin = require("telescope.builtin")
local map = vim.keymap.set

map("n", "<leader><leader>", builtin.find_files, { desc = "Find files" })
map("n", "<leader>/", builtin.live_grep, { desc = "Live grep" })
map("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
map("n", "<leader>bb", builtin.buffers, { desc = "List open buffers" })
map("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
map("n", "<leader>fr", builtin.oldfiles, { desc = "Recent files" })
map("n", "<leader>fd", builtin.diagnostics, { desc = "Diagnostics" })
map("n", "<leader>fg", builtin.git_status, { desc = "Git status" })
