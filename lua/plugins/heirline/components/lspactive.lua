local conditions = require("heirline.conditions")
local utils = require("heirline.utils")
local colors = vim.g.my_colors
return {
  {
    provider = "",
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
    hl = { fg = colors.base, bg = colors.subtext, bold = true },
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
