return {
  {
    "dchinmay2/clangd_extensions.nvim",
    ft = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
    opts = {
      ast = {
        role_icons = {
          type = "🄣",
          declaration = "🄓",
          expression = "🄔",
          statement = ";",
          specifier = "🄢",
          ["template argument"] = "🆃",
        },
        kind_icons = {
          Compound = "🄲",
          Recovery = "🅁",
          TranslationUnit = "🅄",
          PackExpansion = "🄿",
          TemplateTypeParm = "🅃",
          TemplateTemplateParm = "🅃",
          TemplateParamObject = "🅃",
        },
        highlights = {
          detail = "Comment",
        },
      },
      memory_usage = {
        border = "rounded",
      },
      symbol_info = {
        border = "rounded",
      },
    },
    keys = {
      { "<leader>va", "<cmd>ClangdAST<cr>", desc = "Clangd: View AST" },
      { "<leader>vh", "<cmd>ClangdTypeHierarchy<cr>", desc = "Clangd: Type Hierarchy" },
      { "<leader>vs", "<cmd>ClangdSymbolInfo<cr>", desc = "Clangd: Symbol Info" },
      { "<leader>vm", "<cmd>ClangdMemoryUsage<cr>", desc = "Clangd: Memory Usage" },
      { "<leader>vx", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Clangd: Switch Source/Header" },
    },
  },
}