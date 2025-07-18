return {
	"romgrk/barbar.nvim",
	dependencies = {
		"lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
		"nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
		{
			"AstroNvim/astrocore",
			opts = {
				options = { opt = { showtabline = 2 } },
				mappings = {
					n = {
						["<Leader>b"] = { desc = "Buffers" },
						["<A-1>"] = "<cmd>BufferGoto 1<CR>",
						["<A-2>"] = "<cmd>BufferGoto 2<CR>",
						["<A-3>"] = "<cmd>BufferGoto 3<CR>",
						["<A-4>"] = "<cmd>BufferGoto 4<CR>",
						["<A-5>"] = "<cmd>BufferGoto 5<CR>",
						["<A-6>"] = "<cmd>BufferGoto 6<CR>",
						["<A-7>"] = "<cmd>BufferGoto 7<CR>",
						["<A-8>"] = "<cmd>BufferGoto 8<CR>",
						["<A-9>"] = "<cmd>BufferGoto 9<CR>",
						["<A-0>"] = "<cmd>BufferLast<CR>",
						["<leader>bp"] = "<cmd>BufferPin<CR>",
						["<leader>bb"] = "<cmd>BufferPick<CR>",
						["<Leader>c"] = {
							function()
								local bufs = vim.fn.getbufinfo({ buflisted = 1 })
								require("astrocore.buffer").close(0)
								if require("astrocore").is_available("alpha-nvim") and not bufs[2] then
									require("alpha").start()
								end
							end,
							desc = "Close buffer",
						},
						["<leader>bc"] = "<cmd>BufferCloseAllButCurrentOrPinned<CR>",
						["[b"] = "<cmd>BufferPrevious<CR>",
						["]b"] = "<cmd>BufferNext<CR>",
						["."] = false,
						[",b"] = "<cmd>BufferMovePrevious<CR>",
						[".b"] = "<cmd>BufferMoveNext<CR>",
						["<leader>bsi"] = "<cmd>BufferOrderByBufferNumber<CR>",
						["<leader>bsn"] = "<cmd>BufferOrderByName<CR>",
						["<leader>bsp"] = "<cmd>BufferOrderByDirectory<CR>",
						["<leader>bsl"] = "<cmd>BufferOrderByLanguage<CR>",
						["<leader>bsw"] = "<cmd>BufferOrderByWindowNumber<CR>",
					},
				},
			},
		},
	},
	init = function()
		vim.g.barbar_auto_setup = false
	end,
	opts = {
		icons = {
			buffer_index = true,
			diagnostics = {
				[vim.diagnostic.severity.ERROR] = { enabled = true },
				[vim.diagnostic.severity.WARN] = { enabled = true },
				[vim.diagnostic.severity.INFO] = { enabled = true },
				[vim.diagnostic.severity.HINT] = { enabled = false },
			},
		},
	},
}
