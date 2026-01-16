require("kishore.core.options")
require("kishore.core.keymaps")

vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
	pattern = "*",
	command = "silent! write",
})
