local M = {}

M.vimode = require "plugins.heirline.components.vimode"
M.git = require "plugins.heirline.components.git"
M.diagnostic = require "plugins.heirline.components.diagnostic"
M.lspactive = require "plugins.heirline.components.lspactive"
M.workdir = require "plugins.heirline.components.workdir"
M.notify = require "plugins.heirline.components.notify"
M.terminalname = require "plugins.heirline.components.terminalnames"

return M
