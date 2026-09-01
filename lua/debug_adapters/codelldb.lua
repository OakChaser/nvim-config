local dap = require "dap"

dap.adapters.codelldb = {
  type = "executable",
  command = "codelldb",
}
dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function() return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file") end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
  },
}
dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function() return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file") end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
  },
  {
    name = "Conic Launcher Dev",
    type = "codelldb",
    request = "launch",

    cwd = "${workspaceFolder}/core",

    program = function()
      vim.fn.system {
        "cargo",
        "build",
        "--manifest-path",
        vim.fn.getcwd() .. "/core/Cargo.toml",
      }
      local exe = vim.fn.getcwd() .. "/target/debug/conic-launcher"
      return exe
    end,

    stopOnEntry = false,
  },
}

dap.adapters.lldb = dap.adapters.codelldb
