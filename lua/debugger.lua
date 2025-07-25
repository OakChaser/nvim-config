return {
  {
    "mfussenegger/nvim-dap",
    keys = function()
      return {
        { "<f5>", require("dap").continue, desc = "DAP: Start/Continue" },
        { "<f17>", require("dap").terminate, desc = "DAP: Stop" },
        {
          "<f21>",
          function()
            vim.ui.input({ prompt = "Condition: " }, function(condition)
              if condition then
                require("dap").set_breakpoint(condition)
              end
            end)
          end,
          desc = "DAP: Condition breakpoint",
        },
        { "<f29>", require("dap").restart_frame, desc = "DAP: Restart" },
        { "<f6>", require("dap").pause, desc = "DAP: Pause" },
        { "<f9>", require("dap").toggle_breakpoint, desc = "DAP: Toggle breakpoint" },
        { "<f10>", require("dap").step_over, desc = "DAP: Step over" },
        { "<f11>", require("dap").step_into, desc = "DAP: Step into" },
        { "<f23>", require("dap").step_out, desc = "DAP: Step out" },
        { "<leader>db", require("dap").toggle_breakpoint, desc = "DAP: Toggle breakpoint (F9)" },
        { "<leader>dB", require("dap").clear_breakpoints, desc = "DAP: Clear breakpoints" },
        { "<leader>dc", require("dap").continue, desc = "DAP: Start/Continue (F5)" },
        {
          "<leader>dC",
          function()
            vim.ui.input({ prompt = "Condition: " }, function(condition)
              if condition then
                require("dap").set_breakpoint(condition)
              end
            end)
          end,
          desc = "DAP: Condition breakpoint (S-F9)",
        },
        { "<leader>di", require("dap").step_into, desc = "DAP: Step into (F11)" },
        { "<leader>do", require("dap").step_over, desc = "DAP: Step over (F10)" },
        { "<leader>dO", require("dap").step_out, desc = "DAP: Step out (S-F11)" },
        { "<leader>dq", require("dap").close, desc = "DAP: Close session" },
        { "<leader>dQ", require("dap").close, desc = "DAP: Terminate session (S-F5)" },
        { "<leader>dp", require("dap").pause, desc = "DAP: Pause (F6)" },
        { "<leader>dr", require("dap").restart_frame, desc = "DAP: Restart (C-F5)" },
        { "<leader>dR", require("dap").repl.toggle, desc = "DAP: Open or close REPL" },
        { "<leader>ds", require("dap").run_to_cursor, desc = "DAP: Run to cursor" },
      }
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    keys = function()
      return {
        { "<leader>du", require("dapui").toggle, desc = "DAP: Open or close UI" },
        { "<leader>dh", require("dap.ui.widgets").hover, desc = "DAP: Hover" },
        {
          "<leader>de",
          function()
            vim.ui.input({ prompt = "Expression: " }, function(expr)
              if expr then
                require("dapui").eval(expr, { enter = true })
              end
            end)
          end,
          desc = "Evaluate Input",
          mode = "n",
        },
        { "<leader>de", require("dapui").eval, desc = "Evaluate Input", mode = "v" },
      }
    end,
    config = function()
      local dap, dapui = require("dap"), require("dapui")
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end,
  },
}
