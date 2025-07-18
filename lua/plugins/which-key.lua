return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    delay = 200,
    icons = {
      mappings = true,
    },
    spec = {
      { "<leader>f", group = "[F]ind in telescope" },
      { "<leader>t", group = "[T]oggleTerm" },
      { "<leader>b", group = "[B]uffer" },
    },
  },
}
