return {
  {
    "shellRaining/hlchunk.nvim",
    event = "VeryLazy",
    opts = {
      chunk = {
        enable = true,
        use_treesitter = true,
        style = {
          { fg = require("catppuccin.palettes").get_palette().subtext0 },
          { fg = require("catppuccin.palettes").get_palette().red },
        },
        duration = 40,
        delay = 0,
      },
      indent = {
        enable = false,
        chars = { "│", "¦", "┆", "┊" },
        use_treesitter = false,
      },
      blank = {
        enable = false,
      },
      line_num = {
        enable = true,
        use_treesitter = true,
      },
    },
  },
}
