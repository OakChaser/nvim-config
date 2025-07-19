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

local function ViMode()
  local utils = require("heirline.utils")
  local colors = vim.g.my_colors

  local ViModeText = {
    init = function(self)
      self.mode = vim.fn.mode(1) -- :h mode()
    end,
    static = {
      mode_names = {
        n = "NOR",
        no = "NOR",
        nov = "NOR",
        noV = "NOR",
        ["no\22"] = "NOR",
        niI = "NOR",
        niR = "NOR",
        niV = "NOR",
        nt = "NOR",
        v = "VIS",
        vs = "VIS",
        V = "V-L",
        Vs = "V-L",
        ["\22"] = "V-B",
        ["\22s"] = "V-B",
        i = "INS",
        ic = "INS",
        ix = "INS",
        c = "CMD",
        t = "TER",
      },
    },
    provider = function(self)
      return " %2(" .. self.mode_names[self.mode] .. "%) "
    end,
    hl = function(self)
      local mode = self.mode:sub(1, 1) -- get only the first mode character
      return { fg = colors.base, bg = colors[mode_colors[mode]], bold = true }
    end,
    update = {
      "ModeChanged",
      pattern = "*:*",
      callback = vim.schedule_wrap(function()
        vim.cmd("redrawstatus")
      end),
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
      callback = vim.schedule_wrap(function()
        vim.cmd("redrawstatus")
      end),
    },
  }
  local ViModeIcon = {
    init = function(self)
      self.mode = vim.fn.mode(1)
    end,
    provider = "  ",
    hl = function(self)
      local mode = self.mode:sub(1, 1)
      return { fg = colors[mode_colors[mode]], bg = colors.surface }
    end,
    update = {
      "ModeChanged",
      pattern = "*:*",
      callback = vim.schedule_wrap(function()
        vim.cmd("redrawstatus")
      end),
    },
  }
  local ViModeRightDelimiter = {
    init = function(self)
      self.mode = vim.fn.mode(1)
    end,
    provider = "",
    hl = function()
      return { fg = colors.surface, bg = utils.get_highlight("StatusLine").bg }
    end,
    update = {
      "ModeChanged",
      pattern = "*:*",
      callback = vim.schedule_wrap(function()
        vim.cmd("redrawstatus")
      end),
    },
  }
  return { on_click = {
    callback = function()
      vim.cmd("Telescope keymaps")
    end,
    name = "heirline_keymaps_list",
  }, ViModeLeftDelimiter, ViModeText, ViModeIcon, ViModeRightDelimiter }
end

local function Git()
  local conditions = require("heirline.conditions")
  local utils = require("heirline.utils")
  local colors = vim.g.my_colors
  return {
    condition = conditions.is_git_repo,
    on_click = {
      callback = function()
        toggle_term_cmd({ hidden = true, cmd = "lazygit", direction = "float", display_name = "LazyGit" })
      end,
      name = "heirline_open_lazygit",
    },

    init = function(self)
      self.status_dict = vim.b.gitsigns_status_dict
      self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
    end,
    {
      provider = " ",
      hl = { fg = colors.subtext, bg = utils.get_highlight("StatusLine").bg },
    },
    {
      provider = "  ",
      hl = { fg = utils.get_highlight("StatusLine").bg, bg = colors.subtext, bold = true },
    },
    {
      provider = "",
      hl = { fg = colors.subtext, bg = colors.surface },
    },
    {
      provider = function(self)
        return " " .. self.status_dict.head
      end,
      hl = { fg = colors.subtext, bg = colors.surface },
    },
    {
      provider = "",
      hl = { fg = colors.surface, bg = utils.get_highlight("StatusLine").bg },
    },
  }
end

local function LspDiagnostic()
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
end

local function LSPActive()
  local conditions = require("heirline.conditions")
  local utils = require("heirline.utils")
  local colors = vim.g.my_colors
  return {

    {
      provider = " ",
      hl = { fg = colors.surface, bg = utils.get_highlight("StatusLine").bg },
    },
    {
      provider = function()
        local names = {}
        for _, server in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
          table.insert(names, server.name)
        end
        return table.concat(names, " ")
      end,
      hl = { fg = colors.subtext, bg = colors.surface },
    },
    {
      provider = " ",
      hl = { fg = colors.subtext, bg = colors.surface },
    },
    {
      provider = " ",
      hl = { fg = utils.get_highlight("StatusLine").bg, bg = colors.subtext, bold = true },
    },
    {
      provider = "",
      hl = { fg = colors.subtext, bg = utils.get_highlight("StatusLine").bg },
    },

    condition = conditions.lsp_attached,
    update = { "LspAttach", "LspDetach" },
    on_click = {
      callback = function()
        vim.cmd("LspInfo")
      end,
      name = "heirline_open_lspinfo",
    },
  }
end

local function WorkDir()
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
end
local function Notify()
  local utils = require("heirline.utils")
  local colors = vim.g.my_colors
  return {
    init = function(self)
      self.notify_count = #require("notify").history()
      self.mode = vim.fn.mode(1) -- :h mode()
    end,
    {
      provider = " ",
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
            (args.event == "User" and (args.match == "NotifyFloatOpened" or args.match == "NotifyFloatClosed")) or (args.event == "ModeChanged" and args.match:match(".*:.*"))
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
            (args.event == "User" and args.match == "NotifyFloatOpened") or (args.event == "ModeChanged" and args.match:match(".*:.*"))
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
            (args.event == "User" and args.match == "NotifyFloatOpened") or (args.event == "ModeChanged" and args.match:match(".*:.*"))
          then
            vim.cmd.redrawstatus() -- redraw on update
          end
        end),
      },
      hl = function(self)
        local mode = self.mode:sub(1, 1)
        return { fg = utils.get_highlight("StatusLine").bg, bg = colors[mode_colors[mode]] }
      end,
    },
    {
      provider = "",
      update = {
        "ModeChanged",
        callback = vim.schedule_wrap(function(_, args)
          if -- update on user UpdateTime event and mode change
            (args.event == "User" and args.match == "NotifyFloatOpened") or (args.event == "ModeChanged" and args.match:match(".*:.*"))
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
end
return {
  "rebelot/heirline.nvim",
  event = "UiEnter",
  config = function()
    local utils = require("heirline.utils")
    -- use vim.notify(#require("notify").history()) get count of notify
    local DefaultStatusLine = {
      hl = {
        bg = utils.get_highlight("StatusLine").bg,
        fg = utils.get_highlight("StatusLine").fg,
      },
      ViMode(),
      Git(),
      LspDiagnostic(),
      {
        provider = "      ",
      },
      {
        provider = "%=",
      },
      LSPActive(),
      WorkDir(),
      Notify(),
      -- TODO: Add debugger info
    }
    -- TODO: TerminalStatusline, HelpPageStatusline,DAPStatusline, split into many files
    require("heirline").setup({
      statusline = DefaultStatusLine,
    })
  end,
}
