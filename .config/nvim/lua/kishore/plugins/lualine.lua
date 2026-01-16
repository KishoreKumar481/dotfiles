return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")
		local lazy_status = require("lazy.status")

		-- =========================
		-- COLOR PALETTE (BLACK THEME)
		-- =========================
		local colors = {
			blue = "#65D1FF", -- tokyo blue-grey
			green = "#3EFFDC",
			violet = "#BB9AF7",
			yellow = "#E0AF68",
			red = "#F7768E",
			fg = "#CBE0F0", -- main text
			bg = "#000000", -- PURE BLACK
			dim = "#627E97", -- dim text
			git = "#7AA2F7",
			file = "#7F9CCB",
		}

		-- =========================
		-- CUSTOM LUALINE THEME
		-- =========================
		local my_lualine_theme = {
			normal = {
				a = { bg = colors.blue, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			insert = {
				a = { bg = colors.green, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			visual = {
				a = { bg = colors.violet, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			command = {
				a = { bg = colors.yellow, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			replace = {
				a = { bg = colors.red, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			inactive = {
				a = { bg = colors.bg, fg = colors.dim, gui = "bold" },
				b = { bg = colors.bg, fg = colors.dim },
				c = { bg = colors.bg, fg = colors.dim },
			},
		}

		-- =========================
		-- LUALINE SETUP
		-- =========================
		lualine.setup({
			options = {
				theme = my_lualine_theme,
				section_separators = { left = "", right = "" },
				component_separators = { left = "", right = "" },
				globalstatus = true,
				disabled_filetypes = {},
			},

			sections = {
				lualine_a = { "mode" },
				lualine_b = {
					{
						"branch",
						icon = "",
						color = { fg = colors.yellow, gui = "bold" },
					},
				},
				lualine_c = {
					{
						"filename",
						path = 1,
						color = { fg = colors.git, gui = "bold" },
					},
				},
				lualine_x = {
					{
						lazy_status.updates,
						cond = lazy_status.has_updates,
						color = { fg = colors.yellow },
					},
				},
				lualine_y = {
					{
						"progress",
						color = { fg = colors.git, gui = "bold" },
					},
				},
				lualine_z = { "location" },
			},

			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {
					{
						"filename",
						path = 1,
						color = { fg = colors.yellow, gui = "bold" },
					},
				},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
		})
	end,
}
