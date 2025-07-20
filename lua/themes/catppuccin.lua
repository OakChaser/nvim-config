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
      cmp = true,
      gitsigns = true,
      nvimtree = true,
      treesitter = true,
      telescope = true,
      noice = true,
      notify = true,
      mini = {
        enabled = true,
        indentscope_color = "",
      },
      mason = true,
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
