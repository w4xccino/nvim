return {
	'nvim-treesitter/nvim-treesitter',
	dependencies = {
		'nvim-treesitter/nvim-treesitter-textobjects',
    'nvim-treesitter/nvim-treesitter-context',
	},
	build = ':TSUpdate',
	event = 'VeryLazy',
	main = "nvim-treesitter.configs",
	opts = {
		ensure_installed = {
			'lua',
			'php',
      'php_only',
      'blade',
			'luadoc',
			'html',
		},
		highlight = {
			enable = true,
		},
		indent = {
			enable = true,
		},
		textobjects = {
			select = {
				enable = true,
				lookahead = true,
				keymaps = {
					["af"] = "@function.outer",
					["if"] = "@function.inner",
					["ac"] = "@conditional.outer",
					["ic"] = "@conditional.inner",
					["al"] = "@loop.outer",
					["il"] = "@loop.inner",
				}
			},
		},
	},
  config = function (_, opts)
		local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
		parser_config.blade = {
			install_info = {
				url = "https://github.com/EmranMR/tree-sitter-blade",
				files = {"src/parser.c"},
				branch = "main",
        generate_requires_npm = true,
        requires_generate_from_grammar = true,
			},
			filetype = "blade"
		}
		-- -- Set the *.blade.php file to be filetype of blade 
		-- vim.cmd([[
		-- 	augroup BladeFiltypeRelated
		-- 	  au BufNewFile,BufRead *.blade.php set ft=blade
		-- 	augroup END
		-- ]])

    vim.filetype.add({
      pattern = {
        ['.*%.blade%.php'] = 'blade',
      }
    })
    require('treesitter-context').setup()
    require('nvim-treesitter.configs').setup(opts)
  end
}
