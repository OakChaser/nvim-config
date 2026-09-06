local dap = require "dap"
local utils = require "dap.utils"

dap.adapters.python = function(callback)
  local python = vim.fn.exepath "python3"
  local ok, registry = pcall(require, "mason-registry")
  if ok and registry.is_installed "debugpy" then
    local debugpy_path = registry.get_package("debugpy"):get_install_path()
    python = debugpy_path .. "/venv/bin/python"
  end
  callback {
    type = "executable",
    command = python,
    args = { "-m", "debugpy.adapter" },
  }
end

dap.configurations.python = {
  {
    type = "python",
    request = "launch",
    name = "Launch file",
    program = "${file}",
    args = function()
      local args_string = vim.fn.input "Arguments: "
      if utils.splitstr and vim.fn.has "nvim-0.10" == 1 then return utils.splitstr(args_string) end
      return vim.split(args_string, " +")
    end,
    console = "integratedTerminal",
    cwd = vim.fn.getcwd(),
  },
}