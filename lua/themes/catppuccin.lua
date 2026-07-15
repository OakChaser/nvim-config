vim.g.terminal_color_0 = "#45475a"
vim.g.terminal_color_1 = "#f38ba8"
vim.g.terminal_color_2 = "#a6e3a1"
vim.g.terminal_color_3 = "#f9e2af"
vim.g.terminal_color_4 = "#89b4fa"
vim.g.terminal_color_5 = "#f5c2e7"
vim.g.terminal_color_6 = "#94e2d5"
vim.g.terminal_color_7 = "#bac2de"

vim.g.terminal_color_8 = "#585b70"
vim.g.terminal_color_9 = "#f38ba8"
vim.g.terminal_color_10 = "#a6e3a1"
vim.g.terminal_color_11 = "#f9e2af"
vim.g.terminal_color_12 = "#89b4fa"
vim.g.terminal_color_13 = "#f5c2e7"
vim.g.terminal_color_14 = "#94e2d5"
vim.g.terminal_color_15 = "#a6adc8"

return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  opts = {
    transparent_background = vim.g.no_guibg and not vim.g.neovide, -- disables setting the background color.
    show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
    term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
    dim_inactive = {
      enabled = false, -- dims the background color of inactive window
      shade = "dark",
      percentage = 0.15, -- percentage of the shade to apply to the inactive window
    },
    no_italic = true,
    styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
      comments = {}, -- Change the style of comments
      conditionals = {},
      loops = {},
      functions = {},
      keywords = {},
      strings = {},
      variables = {},
      numbers = {},
      booleans = {},
      properties = {},
      types = {},
      operators = {},
      -- miscs = {}, -- Uncomment to turn off hard-coded styles
    },
    integrations = {
      alpha = false,
      barbar = true,
      cmp = false,
      fidget = true,
      gitgraph = true,
      gitsigns = true,
      grug_far = true,
      mason = true,
      mini = {
        enabled = true,
        indentscope_color = "",
      },
      noice = true,
      notify = true,
      nvimtree = false,
      treesitter = true,
      telescope = true,
      which_key = true,
    },
    config = function()
      local palette = require("catppuccin.palettes").get_palette()
      vim.g.my_colors = {
        red = palette.red,
        orange = palette.peach,
        yellow = palette.yellow,
        green = palette.green,
        cyan = palette.teal,
        light_blue = palette.sky,
        blue = palette.blue,
        purple = palette.mauve,
        pink = palette.pink,
        base = palette.base,
        subtext = palette.subtext1,
        overlay = palette.overlay1,
        surface = palette.surface1,
        lavender = palette.lavender,
        text = palette.text,
      }
    end,
  },
}
