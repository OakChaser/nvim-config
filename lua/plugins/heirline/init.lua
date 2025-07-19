vim.o.laststatus = 3

return {
  "rebelot/heirline.nvim",
  event = "UiEnter",
  config = function()
    local utils = require("heirline.utils")
    local statuslines = require("plugins.heirline.statusline")
    -- TODO: TerminalStatusline, HelpPageStatusline,DAPStatusline, split into many files
    require("heirline").setup({
      statusline = { fallthrough = false, statuslines.terminal, statuslines.default },
    })
  end,
}
