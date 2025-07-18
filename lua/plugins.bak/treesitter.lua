-- Customize Treesitter

---@type LazySpec
return {
	"nvim-treesitter/nvim-treesitter",
	opts = {
		ensure_installed = {
			"lua",
			"html",
			"go",
			"css",
			"json",
			"php",
			"rust",
			"vue",
			"javascript",
			"typescript",
			"toml",
			"yaml",
			"ini",
			"scss",
			"gitcommit",
			"gitignore",
			"sql",
			"vim",
			"python",
			-- add more arguments for adding more treesitter parsers
		},
	},
}
