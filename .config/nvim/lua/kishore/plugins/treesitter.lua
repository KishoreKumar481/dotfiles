return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		-- install parsers (replaces ensure_installed)
		require("nvim-treesitter").install({
			"lua",
			"javascript",
			"typescript",
			"tsx",
			"html",
			"css",
			"json",
			"bash",
			"python",
			"dart",
			"prisma",
		})

		-- enable highlighting and indentation (replaces highlight/indent)
		vim.api.nvim_create_autocmd("FileType", {
			callback = function(args)
				if pcall(vim.treesitter.start, args.buf) then
					vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end
			end,
		})
	end,
}
