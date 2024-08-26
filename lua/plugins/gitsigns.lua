return {
    'lewis6991/gitsigns.nvim',
    lazy = false,
    config = true,
    keys = {
        {'<leader>gb', ':Gitsigns toggle_current_line_blame <cr>', desc = "Git Blame"}
    },
}
