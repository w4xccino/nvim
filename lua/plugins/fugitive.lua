return {
	'tpope/vim-fugitive',
	cmd = {"G", "Git"},
	lazy = true,
	keys = {
		{"<leader>gg", ":Git <cr>", desc = "Git Menu"},
		{"<leader>gl", ":Git pull <cr>", desc = "Git Pull"},
		{"<leader>gp", ":Git push origin HEAD <cr>", desc = "Git Push"},
	},
}
