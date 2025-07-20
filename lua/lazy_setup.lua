require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "themes" },
    { import = "plugins" },
    require("lsp"),
    { import = "lsp_tools" },
  },
  install = { colorscheme = { "catppuccin" } },
})

vim.cmd.colorscheme("catppuccin")
