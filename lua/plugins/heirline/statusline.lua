local utils = require "heirline.utils"
local conditions = require "heirline.conditions"
local components = require "plugins.heirline.components"

local Space = {
  provider = " ",
}
local Align = {
  provider = "%=",
}

local function flexible_component_builder(component, flexible)
  return {
    flexible = flexible,
    component,
    {
      provider = "",
    },
  }
end

local M = {}

M.terminal = {
  condition = function()
    return conditions.buffer_matches { buftype = { "terminal" } } or vim.bo.filetype == "toggleterm"
  end,
  hl = {
    bg = utils.get_highlight("StatusLine").bg,
    fg = utils.get_highlight("StatusLine").fg,
  },
  components.vimode,
  Space,
  components.terminalname,
  Space,
  Align,
  components.notify,
}

M.default = {
  hl = {
    bg = utils.get_highlight("StatusLine").bg,
    fg = utils.get_highlight("StatusLine").fg,
  },
  flexible_component_builder(components.vimode, 100),
  Space,
  flexible_component_builder(components.git, 45),
  Space,
  flexible_component_builder(components.diagnostic, 50),
  Space,
  Align,
  Space,
  flexible_component_builder(components.lspactive, 30),
  Space,
  flexible_component_builder(components.workdir, 60),
  Space,
  flexible_component_builder(components.notify, 70),
  -- TODO: Add debugger info
}

return M
