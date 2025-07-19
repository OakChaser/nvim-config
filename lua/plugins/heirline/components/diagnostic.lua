local conditions = require("heirline.conditions")
local utils = require("heirline.utils")
local colors = vim.g.my_colors
return {
  condition = conditions.has_diagnostics,
  static = {
    error_icon = " ",
    warn_icon = " ",
    info_icon = " ",
    hint_icon = " ",
  },

  init = function(self)
    self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
    self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
  end,

  update = { "DiagnosticChanged", "BufEnter" },
  on_click = {
    callback = function()
      vim.cmd("Telescope diagnostics")
    end,
    name = "heirline_diagnostic_list",
  },

  {
    provider = " ",
    hl = { fg = colors.surface, bg = utils.get_highlight("StatusLine").bg },
  },
  {
    provider = " ",
    hl = { bg = colors.surface },
  },
  {
    provider = function(self)
      return self.errors > 0 and (self.error_icon .. self.errors .. " ")
    end,
    hl = { fg = colors.red, bg = colors.surface },
  },
  {
    provider = function(self)
      return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
    end,
    hl = { fg = colors.yellow, bg = colors.surface },
  },
  {
    provider = function(self)
      return self.info > 0 and (self.info_icon .. self.info .. " ")
    end,
    hl = { fg = colors.light_blue, bg = colors.surface },
  },
  {
    provider = function(self)
      return self.hints > 0 and (self.hint_icon .. self.hints .. " ")
    end,
    hl = { fg = colors.cyan, bg = colors.surface },
  },
  {
    provider = "",
    hl = { fg = colors.surface, bg = utils.get_highlight("StatusLine").bg },
  },
}
