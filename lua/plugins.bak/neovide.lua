if not vim.g.neovide then
	return {} -- do nothing if not in a Neovide session
end

local change_scale_factor = function(delta)
	vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
end

return {
	"AstroNvim/astrocore",
	---@type AstroCoreOpts
	opts = {
		options = {
			g = {
				neovide_text_gamma = 0.8,
				neovide_text_contrast = 0.8,
				neovide_transparency = 0.9,
				neovide_hide_mouse_when_typing = true,
				neovide_cursor_vfx_mode = "torpedo",
				neovide_scale_factor = 1.0,
			},
			o = {
				guifont = "FiraCode Nerd Font:h14",
			},
		},
		mappings = {
			n = {
				["<F11>"] = { "<cmd>let g:neovide_fullscreen = !g:neovide_fullscreen<CR>" },
				["<c-=>"] = function()
					change_scale_factor(1.25)
				end,
				["<c-->"] = function()
					change_scale_factor(1 / 1.25)
				end,
				["<c-0>"] = function()
					vim.g.neovide_scale_factor = 1.0
				end,
			},
			v = {
				["<F11>"] = { "<cmd>let g:neovide_fullscreen = !g:neovide_fullscreen<CR>" },
				["<c-=>"] = function()
					change_scale_factor(1.25)
				end,
				["<c-->"] = function()
					change_scale_factor(1 / 1.25)
				end,
				["<c-0>"] = function()
					vim.g.neovide_scale_factor = 1.0
				end,
			},
			i = {
				["<F11>"] = { "<cmd>let g:neovide_fullscreen = !g:neovide_fullscreen<CR>" },
				["<c-=>"] = function()
					change_scale_factor(1.25)
				end,
				["<c-->"] = function()
					change_scale_factor(1 / 1.25)
				end,
				["<c-0>"] = function()
					vim.g.neovide_scale_factor = 1.0
				end,
			},
		},
	},
}
