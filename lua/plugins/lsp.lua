--[[
  LSP stack:
    mason.nvim            — installs LSP server binaries (the "gestor de LSP")
    mason-lspconfig.nvim   — bridges Mason-installed servers to vim.lsp.enable()
    nvim-lspconfig         — ready-made server definitions (cmd/filetypes/root_markers)
  https://github.com/mason-org/mason.nvim
  https://github.com/mason-org/mason-lspconfig.nvim
  https://github.com/neovim/nvim-lspconfig
  Docs: `:h vim.lsp`, `:h mason.nvim`, `:Mason` to browse/install manually.

  Neovim 0.11+ already ships default LSP keymaps once a server attaches,
  no need to redeclare them: grn (rename), gra (code action), grr
  (references), gri (goto implementation), grt (type definition), gO
  (document symbols), K (hover), ]d / [d (next/prev diagnostic).

  `gd`/`gD` are NOT part of that default set (Neovim leaves them as
  plain Vim's built-in local/global declaration search, so it doesn't
  silently override them everywhere) — mapped below, but only
  buffer-local once a client actually attaches, so files with no LSP
  keep Vim's native gd/gD.

  PHP/Laravel tip: `composer require --dev barryvdh/laravel-ide-helper`
  generates `_ide_helper.php` + model docblocks inside the project —
  intelephense indexes it automatically, no extra LSP config needed.
--]]
vim.pack.add({
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
}, { confirm = false })

require("mason").setup()

vim.lsp.config("intelephense", {
  settings = {
    intelephense = {
      files = { maxSize = 5000000 }, -- Laravel vendor/ trees can be large
    },
  },
})

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = { globals = { "vim" } },
      workspace = {
        checkThirdParty = false,
        library = { vim.env.VIMRUNTIME },
      },
      telemetry = { enable = false },
    },
  },
})

require("mason-lspconfig").setup({
  ensure_installed = { "intelephense", "lua_ls" },
  automatic_enable = true, -- calls vim.lsp.enable() for every installed server
})

local map = vim.keymap.set
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })

vim.api.nvim_create_autocmd("LspAttach", {
  desc = "Buffer-local gd/gD once a *capable* LSP client attaches",
  callback = function(ev)
    -- Guard needed because copilot.lua registers itself as an LSP
    -- client on virtually every buffer (that's how it offers ghost-text
    -- suggestions everywhere) but doesn't implement definition/
    -- references — without this check, gd/gD would get shadowed with a
    -- no-op even in plain-text files with no real language server.
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not client then
      return
    end

    local o = { buffer = ev.buf }
    if client:supports_method("textDocument/definition") then
      map("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", o, { desc = "Go to definition" }))
    end
    -- "gD" here means "where is this used", i.e. references (same as
    -- the default grr) — not Vim/LSP's usual "declaration" meaning.
    if client:supports_method("textDocument/references") then
      map("n", "gD", vim.lsp.buf.references, vim.tbl_extend("force", o, { desc = "Go to references (usages)" }))
    end
  end,
})
