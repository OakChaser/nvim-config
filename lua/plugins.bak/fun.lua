return {
	"Eandrju/cellular-automaton.nvim",
	keys = "<leader>F",
	config = function()
		vim.keymap.set("n", "<leader>F", "<cmd>CellularAutomaton make_it_rain<CR>")
	end,
}
