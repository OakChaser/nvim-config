require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "themes" },
    { import = "plugins" },
  },
  install = { colorscheme = { "catppuccin" } },
})

vim.cmd.colorscheme("catppuccin")
