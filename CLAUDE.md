# Neovim config (~/.config/nvim)

Neovim >= 0.12 config using the **native `vim.pack`** package manager (no
lazy.nvim/packer.nvim). One file per plugin under `lua/plugins/`: each
file documents itself (header comment), installs itself
(`vim.pack.add`), configures itself (`setup()`), and owns its keybinds
(`vim.keymap.set` calls in the same file). See `README.md` for the full
keybind cheatsheet and `vim.pack` usage (`update`/`del`/`get`).

## Conventions to follow when adding/editing plugins

- New plugin = new file in `lua/plugins/`, added to the require list in
  `lua/plugins/init.lua`.
- `vim.pack.add(..., { confirm = false })` — install prompts are
  disabled on purpose so each file stays self-contained without piling
  up confirmation popups; updates still go through the interactive
  `vim.pack.update()` diff buffer (that's unaffected by `confirm`).
- Leader is `<space>`. The user prefers descriptive two/three-key
  mnemonic chords under a leader prefix (e.g. `<leader>op` for "open
  panel") over bare single-letter bindings like `<leader>e` — got
  corrected once already, keep using chords for new panel/feature
  toggles.
- which-key groups are registered in `lua/plugins/whichkey.lua`
  (`<leader>f/b/g/l/c/o`) — add a new group entry there when introducing
  a new leader prefix.

## Non-obvious environment gotchas (found by actually running the config, not from docs)

- **nvim-treesitter (`main` branch)** compiles parsers by shelling out
  to the real `tree-sitter` CLI, not a bundled compiler. Requires
  `brew install tree-sitter-cli` on macOS (the `tree-sitter` formula
  alone only installs the library, not the CLI) — without it, parser
  installs fail with `ENOENT: tree-sitter`.
- **blink.cmp v2** requires the separate package `saghen/blink.lib` (own
  `vim.pack.add` entry in `lua/plugins/completion.lua`) — omitting it
  throws `module 'blink.lib' not found` at startup.
- **neo-tree.nvim** must be pinned to `version = "v3.x"` — `main` tracks
  unreleased work.
- **telescope's default sorter** treats the whole typed query (including
  spaces) as one ordered subsequence, so a query like "job model" won't
  match `app/Models/Job.php` (wrong order, no literal space in the
  path). Fixed by adding `telescope-fzf-native.nvim`, which ANDs
  space-separated words and matches each anywhere in any order.
  `vim.pack.Spec` has no declarative `build` field (unlike lazy.nvim),
  so it's compiled via a `PackChanged` autocmd running `make` — see
  `lua/plugins/telescope.lua` and `:h vim.pack-examples`. Needs `make` +
  a C compiler (Xcode Command Line Tools on macOS).
- **image.nvim** ships no telescope integration; `lua/plugins/image.lua`
  overrides `require('telescope.config').values.buffer_previewer_maker`
  directly (must load *after* telescope.lua). Backend is `"kitty"` —
  works in iTerm2 because iTerm2 >= 3.5.6 speaks the Kitty graphics
  protocol (confirmed working: this machine is on iTerm 3.6.5).
  Processor is `"magick_cli"` (shells out to the `magick` CLI via
  `brew install imagemagick`) instead of the default LuaRocks-based
  `magick` binding, to avoid needing luarocks.
- **copilot.lua registers itself as an LSP client on nearly every
  buffer** (how it offers suggestions everywhere) but implements none of
  the real navigation methods. Any `LspAttach` autocmd that sets
  keymaps unconditionally (e.g. `gd`/`gD` in `lua/plugins/lsp.lua`) must
  gate on `client:supports_method(...)`, or it'll shadow those keys with
  a no-op even in plain-text files that have no real language server.
- **lualine theme name** for catppuccin is `"catppuccin-<flavour>"`
  (e.g. `catppuccin-mocha`), not plain `"catppuccin"` — lualine ships no
  built-in catppuccin theme itself; catppuccin.nvim provides it under
  that per-flavour name via its own `lua/lualine/themes/` path.
- Fuzzy matcher for blink.cmp is set to `implementation = "lua"`
  deliberately (zero-dependency, no Rust toolchain or prebuilt-binary
  download needed) — a conscious stability tradeoff over
  `prefer_rust_with_warning`.

## Stack summary

- Colorscheme: catppuccin (mocha)
- Completion: blink.cmp (default keymap preset, lua fuzzy)
- LSP: mason.nvim + mason-lspconfig (`automatic_enable = true`) +
  nvim-lspconfig -> `intelephense` (PHP) + `lua_ls`
- PHP/Laravel: `laravel.nvim` (pickers via telescope), `vim-blade` for
  Blade syntax, Telescope ignores `vendor/`, `node_modules/`,
  `storage/`, `bootstrap/cache/`
- File tree: neo-tree.nvim (`<leader>op`)
- Git: gitsigns.nvim (hunk stage/reset/preview/line-blame,
  `<leader>g[s/r/p/b]`; `<leader>gB` full blame split, filetype
  `gitsigns-blame`, closes with q/Esc via the generic "close utility
  windows" autocmd in core/autocmds.lua)
  + neogit (Magit-style status/stage/commit/branches, `<leader>gg`,
  default keymaps unchanged: `s`/`u`/`c`/`b`)
- Buffers: `<leader>bb` (and `<leader>fb`, kept as an alias) — Telescope
  buffer picker, no separate bufferline/tabs plugin added
- Images: image.nvim renders real image previews in Telescope's file
  finder (png/jpg/jpeg/heic/avif/gif/webp/bmp)
- Navigation: `gd` definition / `gD` references (LSP, capability-gated,
  see gotcha above), `<leader>bn`/`<leader>bp` next/prev buffer (native
  `:bnext`/`:bprevious`, plain `core/keymaps.lua`)
- Copilot: `zbirenbaum/copilot.lua` installed — **auth still pending**,
  user needs to run `:Copilot auth` themselves (needs their own GitHub
  login + an active Copilot subscription)
- Indentation: 4 spaces default (PSR-12), native `.editorconfig` support
  left on so per-repo overrides just work
- Gutter: `numberwidth = 2`, `signcolumn = "number"` (merged into number
  column) — user explicitly wanted this more compact than Neovim's
  defaults

## Verifying changes

This config has no test suite; changes are verified by actually running
it: `nvim --headless "+qa"` after edits catches load-time Lua errors and
triggers `vim.pack` installs, and opening a real file of the relevant
filetype (`nvim --headless somefile.php -c "..."`) is how the LSP/
treesitter/keybind issues above were actually caught — reading the docs
alone missed all of them.
