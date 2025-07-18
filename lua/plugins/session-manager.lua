return {
  "Shatur/neovim-session-manager",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    {
      "<leader>Ss",
      "<cmd>SessionManager load_session<cr>",
    },
    {
      "<leader>Sl",
      "<cmd>SessionManager load_last_session<cr>",
    },
    {
      "<leader>Sc",
      "<cmd>SessionManager load_current_dir_session<cr>",
    },
    {
      "<leader>Sg",
      "<cmd>SessionManager load_git_session<cr>",
    },
    {
      "<leader>Sw",
      "<cmd>SessionManager save_current_session<cr>",
    },
    {
      "<leader>Sd",
      "<cmd>SessionManager delete_session<cr>",
    },
    {
      "<leader>Sd",
      "<cmd>SessionManager delete_current_dir_session<cr>",
    },
  },
}
