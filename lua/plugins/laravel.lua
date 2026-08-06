--[[
  laravel.nvim — Laravel-aware pickers: artisan commands, routes,
  make:* scaffolds, project resources, view finder, and "go to resource"
  (gf) for views/routes/controllers.
  https://github.com/adalessa/laravel.nvim
  Docs: https://adalessa.github.io/laravel-nvim-docs/

  Requires the project's vendor/ to be writable (drops a small PHP
  introspection script there) and `rg` (ripgrep) on PATH.

  Keybinds (this file only):
    <leader>ll   Laravel picker (entry point)
    <leader>la   Artisan command picker
    <leader>lr   Routes picker
    <leader>lm   make:* picker
    <leader>lo   Resources (project files) picker
    <C-g>        View finder (blade <-> usage)
    gf           Go to resource under cursor (view/route/...), falls
                 back to Vim's built-in gf when not over a resource
--]]
vim.pack.add({
  { src = "https://github.com/adalessa/laravel.nvim" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/MunifTanjim/nui.nvim" },
  { src = "https://github.com/nvim-neotest/nvim-nio" },
}, { confirm = false })

require("laravel").setup({
  features = {
    pickers = { provider = "telescope" },
  },
})

local map = vim.keymap.set
map("n", "<leader>ll", function() Laravel.pickers.laravel() end, { desc = "Laravel: picker" })
map("n", "<leader>la", function() Laravel.pickers.artisan() end, { desc = "Laravel: artisan" })
map("n", "<leader>lr", function() Laravel.pickers.routes() end, { desc = "Laravel: routes" })
map("n", "<leader>lm", function() Laravel.pickers.make() end, { desc = "Laravel: make" })
map("n", "<leader>lo", function() Laravel.pickers.resources() end, { desc = "Laravel: resources" })
map("n", "<C-g>", function() Laravel.commands.run("view:finder") end, { desc = "Laravel: view finder" })
map("n", "gf", function()
  if Laravel.app("gf").cursorOnResource() then
    return "<cmd>lua Laravel.commands.run('gf')<cr>"
  end
  return "gf"
end, { expr = true, desc = "Laravel: go to resource" })
