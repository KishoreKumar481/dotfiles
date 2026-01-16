return {
	"CRAG666/code_runner.nvim",
	config = function()
		require("code_runner").setup({
			filetype = {
				javascript = 'cd "$dir" && node "$fileName"',
				typescript = 'cd "$dir" && tsx "$fileName"',
				python = 'cd "$dir" && python3 "$fileName"',
				c = 'cd "$dir" && gcc "$fileName" -o "$fileNameWithoutExt" && "./$fileNameWithoutExt"',
				cpp = 'cd "$dir" && g++ "$fileName" -o "$fileNameWithoutExt" && "./$fileNameWithoutExt"',
				java = 'cd "$dir" && javac "$fileName" && java "$fileNameWithoutExt"',
				sh = 'cd "$dir" && bash "$fileName"',
				rust = 'cd "$dir" && cargo run',
				go = 'cd "$dir" && go run "$fileName"',
			},
		})
	end,
	keys = {
		{ "<leader>rr", ":RunCode<CR>", desc = "Run current file" },
		{ "<leader>rf", ":RunFile<CR>", desc = "Run file" },
		{ "<leader>rt", ":RunClose<CR>", desc = "Terminate run" },
	},
}
