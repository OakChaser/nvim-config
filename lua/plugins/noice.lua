return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    {
      "rcarriga/nvim-notify",
      opts = {
        timeout = 200,
        fps = 60,
        render = "compact",
        top_down = false,
        stages = "slide",
        on_open = vim.schedule_wrap(function()
          vim.api.nvim_exec_autocmds( -- emit our new User event
            "User",
            { pattern = "NotifyFloatOpened", modeline = false }
          )
        end),
        on_close = vim.schedule_wrap(function()
          vim.api.nvim_exec_autocmds( -- emit our new User event
            "User",
            { pattern = "NotifyFloatClosed", modeline = false }
          )
        end),
      },
    },
  },
  opts = {
    lsp = {
      progress = {
        enabled = false,
        view = "cmdline",
      },
    },
    presets = {
      long_message_to_split = true,
      lsp_doc_border = true,
    },
  },
}
