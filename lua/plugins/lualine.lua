return {
	'nvim-lualine/lualine.nvim',
	lazy = false,
	priority = 900,
	opts = {
		options = {
			theme = 'auto',
			globalstatus = true,
		},
		sections = {
			lualine_c = {
				{
					'filename',
					file_status = true,
					path = 1, 
				},
			}
		},
		inactive_winbar = {
			lualine_c = {
				'filename',
			}
		},
	},
	dependencies = { 'nvim-tree/nvim-web-devicons' }
}
