vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.termguicolors = true
vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1

vim.opt.showcmd = true
vim.opt.breakindent = true
vim.opt.relativenumber = true
-- vim.opt.statuscolumn = "%s %l %r "
vim.opt.number = true
vim.opt.signcolumn = "yes"
vim.opt.wrap = false
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.ignorecase = true
vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 5
vim.opt.smartcase = true
vim.opt.showmode = false
vim.opt.mouse = "a"
vim.opt.cursorline = true
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.copyindent = true

-- Neovide options
if vim.g.neovide then
  vim.g.neovide_text_gamma = 0.8
  vim.g.neovide_text_contrast = 0.8
  vim.g.neovide_transparency = 0.9
  vim.g.neovide_hide_mouse_when_typing = true
  vim.g.neovide_cursor_vfx_mode = "torpedo"
  vim.g.neovide_scale_factor = 1.0
  vim.o.guifont = "FiraCode Nerd Font:h13"
end

local config_root = vim.fn.stdpath("config")
local machine_specific_config_path = config_root .. "/lua/machine_specific.lua"
if not vim.loop.fs_stat(machine_specific_config_path) then
  local config_file = io.open(machine_specific_config_path, "wb")
  local default_config_path = config_root .. "/defaults/_machine_specific_default.lua"
  local default_config_file = io.open(default_config_path, "rb")
  if default_config_file and config_file then
    local content = default_config_file:read("*all")
    config_file:write(content)
    io.close(default_config_file)
    io.close(config_file)
  end
end
require("machine_specific")

vim.api.nvim_create_user_command("ResetMachineSpec", function()
  local config_file = io.open(machine_specific_config_path, "wb")
  local default_config_path = config_root .. "/defaults/_machine_specific_default.lua"
  local default_config_file = io.open(default_config_path, "rb")
  if default_config_file and config_file then
    local content = default_config_file:read("*all")
    config_file:write(content)
    io.close(default_config_file)
    io.close(config_file)
    vim.notify("Reset `machine_specific.lua` succesefully")
  end
end, {})
