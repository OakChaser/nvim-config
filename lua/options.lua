vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.o.termguicolors = true
vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1

vim.o.showcmd = true
vim.o.breakindent = true
vim.o.relativenumber = true
vim.o.number = true
vim.o.wrap = false
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.ignorecase = true
vim.o.scrolloff = 5
vim.o.sidescrolloff = 5
vim.o.smartcase = true
vim.o.showmode = false
vim.o.mouse = "a"
vim.o.cursorline = true
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.copyindent = true
vim.o.signcolumn = "yes:2"
vim.opt.numberwidth = 1
vim.opt.statuscolumn = "%=%{v:virtnum < 1 ? (v:relnum ? v:relnum : v:lnum < 10 ? v:lnum . '  ' : v:lnum) : ''}%=%s"

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

local config_root = vim.fn.stdpath "config"
local machine_specific_config_path = config_root .. "/lua/machine_specific.lua"
if not vim.loop.fs_stat(machine_specific_config_path) then
  local config_file = io.open(machine_specific_config_path, "wb")
  local default_config_path = config_root .. "/defaults/_machine_specific_default.lua"
  local default_config_file = io.open(default_config_path, "rb")
  if default_config_file and config_file then
    local content = default_config_file:read "*all"
    config_file:write(content)
    io.close(default_config_file)
    io.close(config_file)
  end
end
require "machine_specific"

vim.api.nvim_create_user_command("ResetMachineSpec", function()
  local config_file = io.open(machine_specific_config_path, "wb")
  local default_config_path = config_root .. "/defaults/_machine_specific_default.lua"
  local default_config_file = io.open(default_config_path, "rb")
  if default_config_file and config_file then
    local content = default_config_file:read "*all"
    config_file:write(content)
    io.close(default_config_file)
    io.close(config_file)
    vim.notify "Reset `machine_specific.lua` succesefully"
  end
end, {})
