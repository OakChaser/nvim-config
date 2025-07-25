vim.o.laststatus = 3
-- vim.o.showtabline = 2
vim.cmd [[au FileType * if index(['wipe', 'delete'], &bufhidden) >= 0 | set nobuflisted | endif]]
return {
  "rebelot/heirline.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local statuslines = require "plugins.heirline.statusline"
    -- TODO: TerminalStatusline, HelpPageStatusline,DAPStatusline, split into many files
    require("heirline").setup {
      statusline = { fallthrough = false, statuslines.terminal, statuslines.default },
      -- tabline = require("plugins.heirline.tabline"),
    }
  end,
}
