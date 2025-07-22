return {
  "yioneko/nvim-vtsls",
  ft = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
  config = function(_, opts)
    require("vtsls").config(opts)
  end,
}
