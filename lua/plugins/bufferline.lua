return {
  "akinsho/bufferline.nvim",
  version = "*",

  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "catppuccin/nvim",
  },
  config = function()
    require("bufferline").setup({
      options = {
        diagnostics = "nvim_lsp",
        numbers = "ordinal",
        indicator = {
          style = "none",
        },
        diagnostics_indicator = function(_, _, diagnostics_dict, _)
          return tostring((diagnostics_dict.error or 0) + (diagnostics_dict.warning or 0))
        end,
      },
      highlights = require("catppuccin.groups.integrations.bufferline").get({
        styles = { "bold" },
        custom = {
          all = {
            duplicate_selected = { fg = vim.g.my_colors.overlay },
            modified_selected = { fg = vim.g.my_colors.text },
            modified = { fg = vim.g.my_colors.overlay },
          },
        },
      }),
    })
  end,
}
