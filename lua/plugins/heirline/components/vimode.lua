local utils = require "heirline.utils"
local colors = vim.g.my_colors

local mode_colors = {
  n = "lavender",
  i = "green",
  v = "purple",
  V = "purple",
  ["\22"] = "purple",
  c = "cyan",
  s = "purple",
  S = "purple",
  ["\19"] = "purple",
  R = "yellow",
  r = "yellow",
  ["!"] = "blue",
  t = "pink",
}

local ViModeText = {
  init = function(self)
    self.mode = vim.fn.mode(1) -- :h mode()
  end,
  static = {
    mode_names = {
      n = "NOR",
      no = "N-?",
      nov = "N-?",
      noV = "N-?",
      ["no\22"] = "N-?",
      niI = "NiI",
      niR = "NiR",
      niV = "NiV",
      nt = "N-T",
      v = "V-C",
      vs = "VCS",
      V = "V-L",
      Vs = "VLS",
      ["\22"] = "V-B",
      ["\22s"] = "VBS",
      s = "SEL",
      S = "S-L",
      ["\19"] = "S-B",
      i = "INS",
      ic = "I-C",
      ix = "I-X",
      R = "REP",
      Rc = "R-c",
      Rx = "R-x",
      Rv = "R-v",
      Rvc = "Rvc",
      Rvx = "Rvx",
      c = "CMD",
      cv = "Ex ",
      r = "...",
      rm = "M..",
      ["r?"] = " ? ",
      ["!"] = " ! ",
      t = "TER",
    },
  },
  provider = function(self) return " %2(" .. self.mode_names[self.mode] .. "%) " end,
  hl = function(self)
    local mode = self.mode:sub(1, 1) -- get only the first mode character
    return { fg = colors.base, bg = colors[mode_colors[mode]], bold = true }
  end,
  update = {
    "ModeChanged",
    pattern = "*:*",
    callback = vim.schedule_wrap(function() vim.cmd "redrawstatus" end),
  },
}
local ViModeLeftDelimiter = {
  init = function(self)
    self.mode = vim.fn.mode(1) -- :h mode()
  end,
  provider = "",
  hl = function(self)
    local mode = self.mode:sub(1, 1) -- get only the first mode character
    return { fg = colors[mode_colors[mode]], bg = utils.get_highlight("StatusLine").bg }
  end,
  update = {
    "ModeChanged",
    pattern = "*:*",
    callback = vim.schedule_wrap(function() vim.cmd "redrawstatus" end),
  },
}
local ViModeIcon = {
  init = function(self) self.mode = vim.fn.mode(1) end,
  provider = "  ",
  hl = function(self)
    local mode = self.mode:sub(1, 1)
    return { fg = colors[mode_colors[mode]], bg = colors.surface }
  end,
  update = {
    "ModeChanged",
    pattern = "*:*",
    callback = vim.schedule_wrap(function() vim.cmd "redrawstatus" end),
  },
}
local ViModeRightDelimiter = {
  init = function(self) self.mode = vim.fn.mode(1) end,
  provider = "",
  hl = function() return { fg = colors.surface, bg = utils.get_highlight("StatusLine").bg } end,
  update = {
    "ModeChanged",
    pattern = "*:*",
    callback = vim.schedule_wrap(function() vim.cmd "redrawstatus" end),
  },
}
return {
  on_click = {
    callback = function() vim.cmd "Telescope keymaps" end,
    name = "heirline_keymaps_list",
  },
  ViModeLeftDelimiter,
  ViModeText,
  ViModeIcon,
  ViModeRightDelimiter,
}
