return {
	"folke/tokyonight.nvim",
	priority = 1000,
	config = function()
		local transparent = false -- set to true if you would like to enable transparency

		local bg = "#000000"
		local bg_dark = "#000000"
		local bg_highlight = "#143652"
		local bg_search = "#0A64AC"
		local bg_visual = "#275378"
		local fg = "#CBE0F0"
		local fg_dark = "#B4D0E9"
		local fg_gutter = "#627E97"
		local border = "#547998"

		require("tokyonight").setup({
			style = "night",
			transparent = transparent,
			styles = {
				sidebars = transparent and "transparent" or "dark",
				floats = transparent and "transparent" or "dark",
			},
			on_colors = function(colors)
				colors.bg = bg
				colors.bg_dark = transparent and colors.none or bg_dark
				colors.bg_float = transparent and colors.none or bg_dark
				colors.bg_highlight = bg_highlight
				colors.bg_popup = bg_dark
				colors.bg_search = bg_search
				colors.bg_sidebar = transparent and colors.none or bg_dark
				colors.bg_statusline = transparent and colors.none or bg_dark
				colors.bg_visual = bg_visual
				colors.border = border
				colors.fg = fg
				colors.fg_dark = fg_dark
				colors.fg_float = fg
				colors.fg_gutter = fg_gutter
				colors.fg_sidebar = fg_dark
			end,
			on_highlights = function(hl, c)
				hl.NvimTreeNormal = { bg = "#000000" }
				hl.NvimTreeNormalNC = { bg = "#000000" }
				hl.NvimTreeEndOfBuffer = { bg = "#000000" }
				hl.NvimTreeVertSplit = { bg = "#000000", fg = "#000000" }
				hl.NvimTreeWinSeparator = { bg = "#000000", fg = "#000000" }
				hl.CursorLine = { bg = "#1a1a1a" }
			end,
		})

		vim.cmd("colorscheme tokyonight")
	end,
}
