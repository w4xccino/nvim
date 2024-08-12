return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason.nvim',
    'folke/neodev.nvim',
  },
  config = function()
    local on_attach = function (_, bufnr)
      vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'
      local opts = {buffer = bufnr}

      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    end
    require('neodev').setup()
    require('lspconfig').lua_ls.setup({
      on_attach = on_attach,
      settings = {
        Lua = {
          telemetry = { enable = false},
          workspace = { checkThirdParty = false },
        }
      }
    })
    require('lspconfig').intelephense.setup{}
    require('lspconfig').dockerls.setup{}
    require('lspconfig').docker_compose_language_service.setup{}
  end
}
