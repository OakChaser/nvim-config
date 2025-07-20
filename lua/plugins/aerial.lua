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
  },
}
