return {
	"akinsho/flutter-tools.nvim",
	lazy = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"stevearc/dressing.nvim",
	},
	config = function()
		require("flutter-tools").setup({
			ui = {
				border = "rounded",
			},
			decorations = {
				statusline = {
					app_version = true,
					device = true,
				},
			},
			lsp = {
				color = {
					enabled = true, -- enables flutter color preview
				},
			},
		})

		-- HOT RELOAD ON SAVE
		vim.api.nvim_create_autocmd("BufWritePost", {
			pattern = "*.dart",
			callback = function()
				vim.cmd("FlutterReload")
			end,
		})

		-- KEYMAPS
		vim.keymap.set("n", "<leader>ir", "<cmd>FlutterReload<cr>", { desc = "Flutter Hot Reload" })
		vim.keymap.set("n", "<leader>iR", "<cmd>FlutterRestart<cr>", { desc = "Flutter Hot Restart" })
		vim.keymap.set("n", "<leader>iq", "<cmd>FlutterQuit<cr>", { desc = "Flutter Quit" })
	end,
}
