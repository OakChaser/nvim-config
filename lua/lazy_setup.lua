local spec = {
  -- import your plugins
  { import = "themes" },
  { import = "plugins" },
}
if vim.g.enable_lsp then
  table.insert(spec, { import = "language_tools" })
  table.insert(spec, require("lsp"))
end

require("lazy").setup({
  spec = spec,
  install = { colorscheme = { "catppuccin" } },
})

vim.cmd.colorscheme("catppuccin")
