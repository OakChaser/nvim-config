if not vim.g.enable_codeium then
  return {}
end

return {
  "Exafunction/windsurf.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  event = { "InsertEnter" },
  opts = {},
  config = function()
    require("codeium").setup({
      enable_cmp_source = false,
      virtual_text = {
        enabled = true,
        filetypes = {
          lua = true,
        },
      },
      key_bindings = {
        accept = "<c-tab>",
      },
    })
  end,
}
