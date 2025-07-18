return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    {
      "rcarriga/nvim-notify",
      opts = {
        render = "compact",
        top_down = false,
        stages = "slide",
        on_open = vim.schedule_wrap(function()
          vim.api.nvim_exec_autocmds( -- emit our new User event
            "User",
            { pattern = "NotifyFloatOpened", modeline = false }
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
    },
  },
}
