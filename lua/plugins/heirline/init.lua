return {
  "rebelot/heirline.nvim",
  event = "UiEnter",
  config = function()
    local utils = require("heirline.utils")
    local Statusline = require("plugins.heirline.statusline")
    -- TODO: TerminalStatusline, HelpPageStatusline,DAPStatusline, split into many files
    require("heirline").setup({
      statusline = Statusline.default,
    })
  end,
}
