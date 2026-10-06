return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.config").setup({
			highlight = { enable = true },
			indent = { enable = true },
			ensure_installed = {
				"lua",
				"javascript",
				"typescript",
				"html",
				"css",
				"json",
				"bash",
				"python",
				"dart",
			},
		})
	end,
}
