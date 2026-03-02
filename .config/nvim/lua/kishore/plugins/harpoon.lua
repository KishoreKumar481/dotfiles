return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")

		-- Harpoon group
		vim.keymap.set("n", "<leader>jk", function()
			harpoon:list():add()
		end, { desc = "Harpoon add file" })

		vim.keymap.set("n", "<leader>jj", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, { desc = "Harpoon menu" })

		-- Quick jumps (these are usually free)
		vim.keymap.set("n", "<M-a>", function()
			harpoon:list():select(1)
		end, { desc = "Harpoon file 1" })
		vim.keymap.set("n", "<M-s>", function()
			harpoon:list():select(2)
		end, { desc = "Harpoon file 2" })
		vim.keymap.set("n", "<M-d>", function()
			harpoon:list():select(3)
		end, { desc = "Harpoon file 3" })
		vim.keymap.set("n", "<M-f>", function()
			harpoon:list():select(4)
		end, { desc = "Harpoon file 4" })
		vim.keymap.set("n", "<M-g>", function()
			harpoon:list():select(5)
		end, { desc = "Harpoon file 5" })
		vim.keymap.set("n", "<M-h>", function()
			harpoon:list():select(6)
		end, { desc = "Harpoon file 6" })

		vim.keymap.set("n", "<M-h>", function()
			harpoon:list():prev()
		end, { desc = "Harpoon previous file" })

		vim.keymap.set("n", "<M-l>", function()
			harpoon:list():next()
		end, { desc = "Harpoon next file" })
	end,
}
