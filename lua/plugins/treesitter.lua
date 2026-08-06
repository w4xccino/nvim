--[[
  nvim-treesitter (main branch) — parsers for syntax highlighting,
  indentation and folding based on real syntax trees instead of regex.
  https://github.com/nvim-treesitter/nvim-treesitter
  Docs: `:h treesitter`

  The `main` branch is a rewrite that dropped the old `ensure_installed` /
  `highlight.enable` config table: parsers are installed explicitly with
  `install()`, and highlighting/indent are started per-filetype below via
  core Neovim APIs (`vim.treesitter.start`).
--]]
vim.pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
}, { confirm = false })

require("nvim-treesitter").setup({
  install_dir = vim.fn.stdpath("data") .. "/site",
})

-- PHP/Laravel + general web-dev stack. Add more languages here as needed.
local parsers = {
  "php", "html", "css", "javascript", "json", "yaml",
  "lua", "bash", "markdown", "markdown_inline", "sql",
  "vim", "vimdoc", "query", "gitignore",
}

require("nvim-treesitter").install(parsers)

vim.api.nvim_create_autocmd("FileType", {
  pattern = parsers,
  callback = function()
    -- pcall: on first run parsers may still be downloading in the
    -- background when a matching buffer opens.
    pcall(vim.treesitter.start)
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})
