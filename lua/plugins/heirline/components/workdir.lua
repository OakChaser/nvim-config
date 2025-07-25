local utils = require "heirline.utils"
local conditions = require "heirline.conditions"
local colors = vim.g.my_colors
local path = {
  init = function(self)
    local cwd = vim.fn.getcwd(0)
    self.cwd = vim.fn.fnamemodify(cwd, ":~")
  end,
  {
    provider = function(self)
      if not conditions.width_percent_below(#self.cwd, 0.85) then
        return ""
      elseif not conditions.width_percent_below(#self.cwd, 0.45) then
        return vim.fn.fnamemodify(self.cwd, ":t")
      elseif not conditions.width_percent_below(#self.cwd, 0.2) then
        return vim.fn.pathshorten(self.cwd)
      else
        return self.cwd
      end
    end,
    hl = { fg = colors.subtext, bg = colors.surface },
  },
}
return {
  {
    provider = "",
    hl = { fg = colors.surface, bg = utils.get_highlight("StatusLine").bg },
  },
  path,
  {
    provider = " ",
    hl = { fg = colors.subtext, bg = colors.surface },
  },
  {
    provider = "  ",
    hl = { fg = colors.base, bg = colors.subtext, bold = true },
  },
  {
    provider = "",
    hl = { fg = colors.subtext, bg = utils.get_highlight("StatusLine").bg },
  },
  on_click = {
    callback = function() vim.cmd "Yazi cwd" end,
    name = "heirline_open_yazi",
  },
}
