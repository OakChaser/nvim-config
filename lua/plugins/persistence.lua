return {
  "folke/persistence.nvim",
  event = "BufReadPre",
  opts = {
    need = 2,
  },
  keys = {
    {
      "<leader>Ss",
      function() require("persistence").select() end,
      desc = "Select a session to load",
    },
    {
      "<leader>Sl",
      function() require("persistence").load { last = true } end,
      desc = "Load the last session",
    },
    {
      "<leader>Sc",
      function() require("persistence").load() end,
      desc = "Load the session for the current directory",
    },
    {
      "<leader>Sd",
      function() require("persistence").stop() end,
      desc = "Stop persistence",
    },
  },
}
