return {
  "petertriho/nvim-scrollbar",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "kevinhwang91/nvim-hlslens",
    "lewis6991/gitsigns.nvim",
  },
  config = function()
    local group = vim.api.nvim_create_augroup("scrollbar_set_git_colors", {})
    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = "*",
      callback = function()
        vim.cmd([[
	  hi! ScrollbarGitAdd guifg=#a6e3a1
	  hi! ScrollbarGitAddHandle guifg=#a6e3a1
	  hi! ScrollbarGitChange guifg=#f9e2af
	  hi! ScrollbarGitChangeHandle guifg=#f9e2af
	  hi! ScrollbarGitDelete guifg=#f38ba8
	  hi! ScrollbarGitDeleteHandle guifg=#f38ba8 ]])
      end,
      group = group,
    })
    require("scrollbar.handlers.search").setup({})
    require("scrollbar.handlers.gitsigns").setup()
    require("scrollbar").setup({
      show = true,
      excluded_buftypes = {
        "prompt",
        "nofile",
        "cmp_menu",
      },
      handle = {
        text = " ",
        color = "#6c7086",
        hide_if_all_visible = true,
      },
      marks = {
        Search = { color = "yellow" },
        Misc = { color = "purple" },
      },
      handlers = {
        cursor = true,
        diagnostic = true,
        gitsigns = true,
        handle = true,
        search = true,
      },
    })
  end,
}
