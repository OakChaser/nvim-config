return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<A-f>",
      function() require("conform").format { async = true, lsp_format = "fallback" } end,
      mode = { "i", "n", "v" },
      desc = "[F]ormat buffer",
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = {
      timeout_ms = 500,
      -- Prefer an external formatter; fall back to the LSP (clangd) if none
      lsp_format = "fallback",
    },
    formatters_by_ft = {
      lua = { "stylua" },
      -- C/C++: clang-format picks up style from .clang-format (via -style=file)
      c = { "clang_format" },
      cpp = { "clang_format" },
      objc = { "clang_format" },
      objcpp = { "clang_format" },
      cuda = { "clang_format" },
      python = { "ruff_format", "ruff_organize_imports" },
      -- Conform can also run multiple formatters sequentially
      --
      -- You can use 'stop_after_first' to run the first available formatter from the list
      javascript = { "prettierd", "prettier", stop_after_first = true },
      css = { "prettierd", "prettier", stop_after_first = true },
      less = { "prettierd", "prettier", stop_after_first = true },
      scss = { "prettierd", "prettier", stop_after_first = true },
      typescript = { "prettierd", "prettier", stop_after_first = true },
      vue = { "prettierd", "prettier", stop_after_first = true },
      json = { "prettierd", "prettier", stop_after_first = true },
      -- Markdown: prettier picks up ~/.prettierrc (printWidth 100, proseWrap always)
      markdown = { "prettierd", "prettier", stop_after_first = true },
      ["markdown.mdx"] = { "prettierd", "prettier", stop_after_first = true },
    },
  },
}
