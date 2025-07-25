local utils = require "heirline.utils"
local colors = vim.g.my_colors

local function get_terminal_program()
  if vim.b.term_title and vim.b.term_title ~= "" then return vim.b.term_title end
  local pid = vim.fn.getpid()
  local cmd = string.format("ps -o comm= -p %d", pid)
  local handle = io.popen(cmd)
  local result = ""
  if handle then
    result = handle:read("*a"):gsub("\n", "")
    handle:close()
  end
  return result ~= "" and result or "terminal"
end

-- return {
--   {
--     provider = "",
--     hl = { fg = colors.subtext, bg = utils.get_highlight("StatusLine").bg },
--   },
--   {
--     provider = "  ",
--     hl = { fg = utils.get_highlight("StatusLine").bg, bg = colors.subtext },
--   },
--   {
--     provider = " ",
--     hl = { fg = colors.subtext, bg = colors.surface },
--   },
--   {
--     provider = function()
--       return get_terminal_program()
--     end,
--     hl = { fg = colors.subtext, bg = colors.surface },
--   },
--   {
--     provider = "",
--     hl = { fg = colors.surface, bg = utils.get_highlight("StatusLine").bg },
--   },
-- }
return {
  provider = function()
    local max_width = vim.o.columns - 24
    local content = get_terminal_program()
    if #content > max_width then content = content:sub(1, max_width - 1) .. "…" end
    return " " .. content
  end,
  on_click = {
    callback = function() print(get_terminal_program()) end,
    name = "heirline_show_terminal_name",
  },
  hl = { fg = colors.lavender },
}
