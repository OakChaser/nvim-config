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
local utils = require("heirline.utils")
local colors = vim.g.my_colors
return {
  init = function(self)
    self.notify_count = #require("notify").history()
    self.mode = vim.fn.mode(1) -- :h mode()
  end,
  {
    provider = "",
    hl = { fg = colors.surface, bg = utils.get_highlight("StatusLine").bg },
  },
  {
    provider = function()
      return " " .. #require("notify").history() .. " "
    end,
    update = {
      "User",
      "ModeChanged",
      callback = vim.schedule_wrap(function(_, args)
        if -- update on user UpdateTime event and mode change
          (args.event == "User" and (args.match == "NotifyFloatOpened" or args.match == "NotifyFloatClosed"))
          or (args.event == "ModeChanged" and args.match:match(".*:.*"))
        then
          vim.cmd.redrawstatus() -- redraw on update
        end
      end),
    },
    hl = function(self)
      local mode = self.mode:sub(1, 1)
      return { fg = colors[mode_colors[mode]], bg = colors.surface }
    end,
  },
  {
    provider = "",
    update = {
      "ModeChanged",
      callback = vim.schedule_wrap(function(_, args)
        if -- update on user UpdateTime event and mode change
          (args.event == "User" and args.match == "NotifyFloatOpened")
          or (args.event == "ModeChanged" and args.match:match(".*:.*"))
        then
          vim.cmd.redrawstatus() -- redraw on update
        end
      end),
    },
    hl = function(self)
      local mode = self.mode:sub(1, 1)
      return { fg = colors[mode_colors[mode]], bg = colors.surface }
    end,
  },
  {
    provider = "  ",
    update = {
      "ModeChanged",
      callback = vim.schedule_wrap(function(_, args)
        if -- update on user UpdateTime event and mode change
          (args.event == "User" and args.match == "NotifyFloatOpened")
          or (args.event == "ModeChanged" and args.match:match(".*:.*"))
        then
          vim.cmd.redrawstatus() -- redraw on update
        end
      end),
    },
    hl = function(self)
      local mode = self.mode:sub(1, 1)
      return { fg = colors.base, bg = colors[mode_colors[mode]] }
    end,
  },
  {
    provider = "",
    update = {
      "ModeChanged",
      callback = vim.schedule_wrap(function(_, args)
        if -- update on user UpdateTime event and mode change
          (args.event == "User" and args.match == "NotifyFloatOpened")
          or (args.event == "ModeChanged" and args.match:match(".*:.*"))
        then
          vim.cmd.redrawstatus() -- redraw on update
        end
      end),
    },
    hl = function(self)
      local mode = self.mode:sub(1, 1)
      return { fg = colors[mode_colors[mode]], bg = utils.get_highlight("StatusLine").bg }
    end,
  },
  on_click = {
    callback = function()
      vim.cmd("Telescope notify")
    end,
    name = "heirline_notify_list",
  },
}
