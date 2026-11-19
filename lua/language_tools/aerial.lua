return {
	"stevearc/aerial.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	keys = {
		{
			"<leader>a",
			"<cmd>AerialToggle!<CR>",
			desc = "Open or close aerial",
		},
	},
	opts = {
		on_attach = function(bufnr)
			vim.keymap.set("n", "<c-u>", "<cmd>AerialPrev<CR>", { buffer = bufnr })
			vim.keymap.set("n", "<c-d>", "<cmd>AerialNext<CR>", { buffer = bufnr })
		end,
		-- 区分「对外暴露」与「模块内部」的符号：给内部符号打上 scope，
		-- aerial 会用 AerialPrivate / AerialProtected 高亮组（默认链接到 Comment）
		-- 渲染它的名字，和公开符号在视觉上区分开。
		-- 各语言的判定规则见 lua/utils/aerial_visibility.lua
		post_parse_symbol = function(bufnr, item, ctx)
			local visibility = require("utils.aerial_visibility").get(bufnr, item, ctx)
			if visibility and visibility ~= "public" and not item.scope then item.scope = visibility end
		end,
	},
}
