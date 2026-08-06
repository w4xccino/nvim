--[[
  blink.cmp — completion menu (LSP, buffer, path, snippets).
  https://github.com/saghen/blink.cmp
  Docs: https://cmp.saghen.dev

  Using the pure-Lua fuzzy matcher (`fuzzy.implementation = "lua"`) on
  purpose: zero extra dependencies, no Rust toolchain or prebuilt-binary
  download required. Switch to "prefer_rust_with_warning" later if you
  want a faster matcher and have curl+git (or Rust) available.
--]]
vim.pack.add({
  { src = "https://github.com/saghen/blink.cmp" },
  { src = "https://github.com/saghen/blink.lib" }, -- required runtime dep since blink.cmp v2
}, { confirm = false })

require("blink.cmp").setup({
  keymap = { preset = "default" }, -- <C-y> accept, <C-n>/<C-p> select, <C-space> docs
  completion = {
    documentation = { auto_show = true },
  },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },
  fuzzy = {
    implementation = "lua",
  },
})
