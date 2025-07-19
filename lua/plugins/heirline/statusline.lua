local utils = require("heirline.utils")
local components = require("plugins.heirline.components")
local M = {}
M.default = {
  hl = {
    bg = utils.get_highlight("StatusLine").bg,
    fg = utils.get_highlight("StatusLine").fg,
  },
  components.vimode,
  components.git,
  components.diagnostic,
  {
    provider = "      ",
  },
  {
    provider = "%=",
  },
  components.lspactive,
  components.workdir,
  components.notify,
  -- TODO: Add debugger info
}

return M
