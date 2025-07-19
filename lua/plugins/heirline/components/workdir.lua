local utils = require("heirline.utils")
local colors = vim.g.my_colors
local path = {
  init = function(self)
    local cwd = vim.fn.getcwd(0)
    self.cwd = vim.fn.fnamemodify(cwd, ":~")
  end,
  flexible = 1,
  {
    -- evaluates to the full-lenth path
    provider = function(self)
      return self.cwd
    end,
    hl = { fg = colors.subtext, bg = colors.surface },
  },
  {
    -- evaluates to the shortened path
    provider = function(self)
      return vim.fn.pathshorten(self.cwd)
    end,
    hl = { fg = colors.subtext, bg = colors.surface },
  },
  {
    -- evaluates to "", hiding the component
    provider = function(self)
      return vim.fn.fnamemodify(self.cwd, ":t")
    end,
    hl = { fg = colors.subtext, bg = colors.surface },
  },
}
return {
  {
    provider = " ",
    hl = { fg = colors.surface, bg = utils.get_highlight("StatusLine").bg },
  },
  path,
  {
    provider = " ",
    hl = { fg = colors.subtext, bg = colors.surface },
  },
  {
    provider = "  ",
    hl = { fg = utils.get_highlight("StatusLine").bg, bg = colors.subtext, bold = true },
  },
  {
    provider = "",
    hl = { fg = colors.subtext, bg = utils.get_highlight("StatusLine").bg },
  },
  on_click = {
    callback = function()
      vim.cmd("Yazi cwd")
    end,
    name = "heirline_open_yazi",
  },
}
