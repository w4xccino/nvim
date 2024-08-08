return {
	'nvim-treesitter/nvim-treesitter',
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	build = ':TSUpdate',
	event = 'VeryLazy',
	main = "nvim-treesitter.configs",
	opts = {
		ensure_installed = {
			'lua',
			'php',
			'luadoc',
		},
		highlight = {
			enable = true,
		},
		indent = {
			enabled = true,
		},
		textobjects = {
			select = {
				enabled = true,
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
}
