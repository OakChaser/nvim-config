return {
  {
    "geg2102/nvim-python-repl",
    ft = "python",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    keys = {
      {
        "<leader>R",
        function() require("nvim-python-repl").open_repl() end,
        desc = "Open Python REPL",
      },
      {
        "<leader>rs",
        function() require("nvim-python-repl").send_statement_definition() end,
        desc = "Send statement/definition to REPL",
      },
      {
        "<leader>rv",
        function() require("nvim-python-repl").send_visual_to_repl() end,
        mode = "v",
        desc = "Send visual selection to REPL",
      },
      {
        "<leader>rb",
        function() require("nvim-python-repl").send_buffer_to_repl() end,
        desc = "Send buffer to REPL",
      },
    },
    opts = {
      execute_on_send = false,
      vsplit = false,
      spawn_command = { python = "python3" },
    },
  },
}