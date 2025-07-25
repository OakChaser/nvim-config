return {
  "petertriho/nvim-scrollbar",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    show = true,
    excluded_buftypes = {
      "prompt",
      "nofile",
      "cmp_menu",
    },
    handle = {
      text = " ",
      color = "#6c7086",
      hide_if_all_visible = true,
    },
    marks = {
      Search = { color = "yellow" },
      Misc = { color = "purple" },
    },
    handlers = {
      cursor = true,
      diagnostic = true,
      gitsigns = false,
      handle = true,
      search = false,
    },
  },
}
