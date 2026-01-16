-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps
---------------------

-- use kj to exit insert mode
keymap.set("i", "kj", "<Esc>", { noremap = true, silent = true, desc = "Exit insert mode with kj" })

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- increment / decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- tabs
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Next tab" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Previous tab" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })

-- move seleted lines up and down
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- when up and down center the page
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")

-- pastes without overwriting clipboard
keymap.set("x", "<leader>p", '"_dP', { noremap = true, silent = true })

---------------------
-- Live Server toggle
---------------------

keymap.set("n", "<leader>ls", function()
	-- check if live-server is running
	local handle = io.popen("pgrep -f live-server")
	local result = handle:read("*a")
	handle:close()

	-- current file info
	local filename = vim.fn.expand("%:t")

	-- default URL
	local url = "http://127.0.0.1:8080/"

	-- open current HTML file directly
	if filename:match("%.html?$") then
		url = url .. filename
	end

	if result == "" then
		-- start server
		vim.fn.jobstart({ "/home/kishore/.local/bin/live-server" }, { detach = true })

		-- open browser
		vim.fn.jobstart({ "brave-browser", "--new-window", url }, { detach = true })

		vim.notify("Live Server STARTED → " .. url, vim.log.levels.INFO)
	else
		-- stop server
		vim.fn.jobstart({ "pkill", "-f", "live-server" }, { detach = true })
		vim.notify("Live Server STOPPED", vim.log.levels.WARN)
	end
end, { desc = "Toggle Live Server (Open Current File)" })

------------------------------------
-- Select word & rename everywhere
------------------------------------

keymap.set("v", "<leader>re", function()
	-- yank visual selection
	vim.cmd('normal! "vy')

	local old = vim.fn.getreg('"')
	old = vim.fn.escape(old, "\\/.*$^~[]")

	-- ask for new name
	local new = vim.fn.input("Rename to: ")
	if new == "" then
		return
	end

	-- replace everywhere with confirmation
	vim.cmd("%s/\\<" .. old .. "\\>/" .. new .. "/gc")
end, { desc = "Rename selected word everywhere" })
