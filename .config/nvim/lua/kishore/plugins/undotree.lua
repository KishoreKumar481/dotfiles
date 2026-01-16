return {
	"mbbill/undotree",
	config = function()
		vim.opt.undofile = true
		vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir"
		vim.keymap.set("n", "<leader>u", function()
			vim.cmd.UndotreeToggle()
			vim.cmd.UndotreeFocus()
		end, { desc = "open undotree" })
	end,
}
