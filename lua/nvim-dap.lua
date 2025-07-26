return {
  {
    "mfussenegger/nvim-dap",
    keys = {
      { "<f5>", function() require("dap").continue() end, desc = "DAP: Start/Continue" },
      { "<f17>", function() require("dap").terminate() end, desc = "DAP: Stop" },
      {
        "<f21>",
        function()
          vim.ui.input({ prompt = "Condition: " }, function(condition)
            if condition then require("dap").set_breakpoint(condition) end
          end)
        end,
        desc = "DAP: Condition breakpoint",
      },
      { "<f29>", function() require("dap").restart_frame() end, desc = "DAP: Restart" },
      { "<f6>", function() require("dap").pause() end, desc = "DAP: Pause" },
      { "<f9>", function() require("dap").toggle_breakpoint() end, desc = "DAP: Toggle breakpoint" },
      { "<f10>", function() require("dap").step_over() end, desc = "DAP: Step over" },
      { "<f11>", function() require("dap").step_into() end, desc = "DAP: Step into" },
      { "<f23>", function() require("dap").step_out() end, desc = "DAP: Step out" },
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "DAP: Toggle breakpoint (F9)" },
      { "<leader>dB", function() require("dap").clear_breakpoints() end, desc = "DAP: Clear breakpoints" },
      { "<leader>dc", function() require("dap").continue() end, desc = "DAP: Start/Continue (F5)" },
      {
        "<leader>dC",
        function()
          vim.ui.input({ prompt = "Condition: " }, function(condition)
            if condition then require("dap").set_breakpoint(condition) end
          end)
        end,
        desc = "DAP: Condition breakpoint (S-F9)",
      },
      { "<leader>di", function() require("dap").step_into() end, desc = "DAP: Step into (F11)" },
      { "<leader>do", function() require("dap").step_over() end, desc = "DAP: Step over (F10)" },
      { "<leader>dO", function() require("dap").step_out() end, desc = "DAP: Step out (S-F11)" },
      { "<leader>dq", function() require("dap").close() end, desc = "DAP: Close session" },
      { "<leader>dQ", function() require("dap").close() end, desc = "DAP: Terminate session (S-F5)" },
      { "<leader>dp", function() require("dap").pause() end, desc = "DAP: Pause (F6)" },
      { "<leader>dr", function() require("dap").restart_frame() end, desc = "DAP: Restart (C-F5)" },
      { "<leader>dR", function() require("dap").repl.toggle() end, desc = "DAP: Open or close REPL" },
      { "<leader>ds", function() require("dap").run_to_cursor() end, desc = "DAP: Run to cursor" },
    },
    config = function() require "debug_adapters.codelldb" end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text",
    },
    keys = {
      { "<leader>du", function() require("dapui").toggle() end, desc = "DAP: Open or close UI" },
      {
        "<leader>dh",
        function() require("dap.ui.widgets").hover() end,
        desc = "DAP: Hover",
      },
      {
        "<leader>de",
        function()
          vim.ui.input({ prompt = "Expression: " }, function(expr)
            if expr then require("dapui").eval(expr, { enter = true }) end
          end)
        end,
        desc = "Evaluate Input",
        mode = "n",
      },
      {
        "<leader>de",
        function() require("dapui").eval() end,
        desc = "Evaluate Input",
        mode = "v",
      },
    },
    opts = {
      layouts = {
        {
          position = "left",
          size = 0.2,
          elements = {
            { id = "stacks", size = 0.2 },
            { id = "scopes", size = 0.5 },
            { id = "breakpoints", size = 0.15 },
            { id = "watches", size = 0.15 },
          },
        },
        {
          position = "bottom",
          size = 0.2,
          elements = {
            { id = "repl", size = 0.3 },
            { id = "console", size = 0.7 },
          },
        },
      },
    },
    config = function(_, opts)
      local dap, dapui = require "dap", require "dapui"
      dap.listeners.before.attach.dapui_config = function() dapui.open() end
      dap.listeners.before.launch.dapui_config = function() dapui.open() end
      dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
      dap.listeners.before.event_exited.dapui_config = function() dapui.close() end
      dapui.setup(opts)
    end,
  },
}
