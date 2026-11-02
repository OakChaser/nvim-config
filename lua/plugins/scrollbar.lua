return {
  "petertriho/nvim-scrollbar",
  branch = "refactor/v2",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    exclude = {
      buftypes = { prompt = true, nofile = true },
      filetypes = { cmp_menu = true },
    },
    providers = {
      search = false,
      gitsigns = false,
    },
    marks = {
      Search = { highlight = { fg = "yellow" } },
      Misc = { highlight = { fg = "purple" } },
    },
    scrollbar = {
      show = true,
      thumb = {
        text = " ",
        hide_if_all_visible = true,
        highlight = { bg = "#6c7086" },
      },
    },
  },
}
