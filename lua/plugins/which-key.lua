return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = function()
    return {
      delay = 200,
      icons = {
        mappings = true,
      },
      spec = {
        { "<leader>a", icon = "󱔁 " },
        { "<leader>;", icon = "󱔁 " },
        { "<leader>L", icon = "󰒲 ", desc = "Open Lazy" },
        { "<leader>f", group = "[F]ind in telescope" },
        { "<leader>t", group = "[T]oggleTerm", icon = " " },
        { "<leader>b", group = "[B]uffer", icon = "󰈔" },
        { "<leader>w", icon = "󰈔" },
        { "<leader>e", icon = { icon = "󰇥", color = "yellow" } },
        { "<leader>r", icon = { icon = "󰇥", color = "yellow" } },
        { "<leader>c", icon = { icon = "", color = "red" } },
        { "<leader>F", group = "Cellular automaton", icon = { icon = " ", color = "yellow" } },
        { "<leader>u", group = "UI", icon = { icon = " ", color = "yellow" } },
        { "<leader>S", group = "Session manager" },
        { "gr", group = "LSP" },
      },
    }
  end,
}
