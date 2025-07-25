local conditions = require "heirline.conditions"
local utils = require "heirline.utils"
local colors = vim.g.my_colors
return {
  condition = conditions.is_git_repo,
  on_click = {
    callback = function()
      Toggle_term_cmd { hidden = true, cmd = "lazygit", direction = "float", display_name = "LazyGit" }
    end,
    name = "heirline_open_lazygit",
  },

  init = function(self)
    self.status_dict = vim.b.gitsigns_status_dict
    self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
  end,
  {
    provider = "",
    hl = { fg = colors.subtext, bg = utils.get_highlight("StatusLine").bg },
  },
  {
    provider = "  ",
    hl = { fg = colors.base, bg = colors.subtext, bold = true },
  },
  {
    provider = "",
    hl = { fg = colors.subtext, bg = colors.surface },
  },
  {
    provider = function(self) return " " .. self.status_dict.head end,
    hl = { fg = colors.subtext, bg = colors.surface },
  },
  {
    provider = "",
    hl = { fg = colors.surface, bg = utils.get_highlight("StatusLine").bg },
  },
}
