return {
  type = "python",
  request = "launch",
  name = "file:args (cwd)",
  program = "${file}",
  args = function()
    local args_string = vim.fn.input "Arguments: "
    local utils = require "dap.utils"
    if utils.splitstr and vim.fn.has "nvim-0.10" == 1 then return utils.splitstr(args_string) end
    return vim.split(args_string, " +")
  end,
  console = "integratedTerminal",
  cwd = vim.fn.getcwd(),
}
