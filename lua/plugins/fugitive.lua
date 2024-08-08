return {
	'tpope/vim-fugitive',
	cmd = {"G", "Git"},
	lazy = true,
	keys = {
		{"<leader>gg", ":Git <cr>", desc = "Git Menu"},
		{"<leader>gp", ":Git pull <cr>", desc = "Git Pull"},
	},
}
