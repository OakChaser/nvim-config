return {
  "mikavilpas/yazi.nvim",
  keys = {
    {
      "<leader>e",
      "<cmd>Yazi<cr>",
      desc = "Open yazi at the current file",
    },
    {
      -- Open in the current working directory
      "<leader>r",
      "<cmd>Yazi cwd<cr>",
      desc = "Open yazi in nvim's working directory",
    },
    {
      "R",
      "<cmd>Yazi toggle<cr>",
      desc = "Resume the last yazi session",
    },
  },
  opts = {
    open_for_directories = true,
  },
  hooks = {
    yazi_closed = function(result)
      if result and result.cwd then vim.api.nvim_set_current_dir(result.cwd) end
    end,
  },
}
