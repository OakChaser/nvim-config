vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc, mode)
      mode = mode or "n"
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
    end
    map("grn", vim.lsp.buf.rename, "[R]ename")
    map("grs", require("telescope").extensions.aerial.aerial, "LSP Symbols")
    map("gra", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })
    map("grr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
    map("gri", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
    map("grd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
    map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
    map("gO", require("telescope.builtin").lsp_document_symbols, "Open Document Symbols")
    map("grw", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Open Workspace Symbols")
    map("grt", require("telescope.builtin").lsp_type_definitions, "[G]oto [T]ype Definition")
    map("grh", vim.lsp.buf.hover, "Hover")
    -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
    ---@param client vim.lsp.Client
    ---@param method vim.lsp.protocol.Method
    ---@param bufnr? integer some lsp support methods only in specific files
    ---@return boolean
    local function client_supports_method(client, method, bufnr) return client:supports_method(method, bufnr) end

    -- The following two autocommands are used to highlight references of the
    -- word under your cursor when your cursor rests there for a little while.
    --    See `:help CursorHold` for information about when this is executed
    --
    -- When you move your cursor, the highlights will be cleared (the second autocommand).
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if
      client
      and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf)
    then
      local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd("LspDetach", {
        group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds {
            group = "kickstart-lsp-highlight",
            buffer = event2.buf,
          }
        end,
      })
    end

    -- The following code creates a keymap to toggle inlay hints in your
    -- code, if the language server you are using supports them
    --
    -- This may be unwanted, since they displace some of your code
    if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
      vim.lsp.inlay_hint.enable(true) -- Default is enabled
      vim.keymap.set("n", "<leader>uh", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
        if vim.lsp.inlay_hint.is_enabled { bufnr = event.buf } then
          vim.notify("Inlay hints: " .. "ON")
        else
          vim.notify("Inlay hints: " .. "OFF")
        end
      end, { desc = "Toggle Inlay Hints" })
    end
  end,
})

-- Diagnostic Config
-- See :help vim.diagnostic.Opts
vim.diagnostic.config {
  severity_sort = true,
  float = { border = "rounded", source = "if_many" },
  underline = { severity = vim.diagnostic.severity.ERROR },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.INFO] = " ",
      [vim.diagnostic.severity.HINT] = " ",
    },
  },
  virtual_text = {
    source = "if_many",
    spacing = 2,
    format = function(diagnostic)
      local diagnostic_message = {
        [vim.diagnostic.severity.ERROR] = diagnostic.message,
        [vim.diagnostic.severity.WARN] = diagnostic.message,
        [vim.diagnostic.severity.INFO] = diagnostic.message,
        [vim.diagnostic.severity.HINT] = diagnostic.message,
      }
      return diagnostic_message[diagnostic.severity]
    end,
  },
}

vim.keymap.set(
  "n",
  "[h",
  function() vim.diagnostic.jump { severity = vim.diagnostic.severity.HINT, count = -1 } end,
  { desc = "Previous hint" }
)
vim.keymap.set(
  "n",
  "]h",
  function() vim.diagnostic.jump { severity = vim.diagnostic.severity.HINT, count = 1 } end,
  { desc = "Next hint" }
)
vim.keymap.set(
  "n",
  "[i",
  function() vim.diagnostic.jump { severity = vim.diagnostic.severity.INFO, count = -1 } end,
  { desc = "Previous info" }
)
vim.keymap.set(
  "n",
  "]i",
  function() vim.diagnostic.jump { severity = vim.diagnostic.severity.INFO, count = 1 } end,
  { desc = "Next info" }
)
vim.keymap.set(
  "n",
  "[w",
  function() vim.diagnostic.jump { severity = vim.diagnostic.severity.WARN, count = -1 } end,
  { desc = "Previous warning" }
)
vim.keymap.set(
  "n",
  "]w",
  function() vim.diagnostic.jump { severity = vim.diagnostic.severity.WARN, count = 1 } end,
  { desc = "Next warning" }
)
vim.keymap.set(
  "n",
  "[e",
  function() vim.diagnostic.jump { severity = vim.diagnostic.severity.ERROR, count = -1 } end,
  { desc = "Previous error" }
)
vim.keymap.set(
  "n",
  "]e",
  function() vim.diagnostic.jump { severity = vim.diagnostic.severity.ERROR, count = 1 } end,
  { desc = "Next error" }
)

vim.api.nvim_create_autocmd("CursorHold", {
  pattern = "*",
  callback = function()
    vim.diagnostic.open_float(nil, {
      focusable = false,
      close_events = { "CursorMoved", "CursorMovedI", "BufHidden", "InsertCharPre" },
      border = "rounded",
      scope = "cursor",
    })
  end,
})

return {
  {
    "j-hui/fidget.nvim",
    event = "VeryLazy",
    opts = {
      notification = {
        window = {
          border = "rounded",
        },
      },
    },
  },
  {
    "mason-org/mason.nvim",
    event = "VeryLazy",
    keys = {
      {
        "<leader>M",
        "<cmd>Mason<cr>",
        desc = "Open Mason",
      },
    },
    opts = {
      ui = {
        icons = {
          package_installed = "●",
          package_pending = "○",
          package_uninstalled = "○",
        },
      },
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    event = "VeryLazy",
  },
  {
    "mason-org/mason-lspconfig.nvim",
    event = "VeryLazy",
    config = function()
      require("mason").setup {}

      vim.lsp.config("*", {
        capabilities = require("blink.cmp").get_lsp_capabilities(),
      })

      require("mason-lspconfig").setup {
        automatic_enable = {
          "lua_ls",
          "basedpyright",
          "ruff",
        },
      }

      local language_servers = {
        "lua_ls",
        "rust_analyzer",
        "vue_ls",
        "vtsls",
        "html",
        "cssls",
        "emmet_ls",
        "eslint",
        "basedpyright",
        "ruff",
        "clangd",
        "cmake-language-server",
        "slint-lsp",
        -- Haskell: HLS is managed by ghcup, not mason (`ghcup install hls`).
        -- Its wrapper ships per-GHC bindists, so let ghcup own it.
      }
      local formatting_tools = {
        "stylua",
        "prettier",
        "prettierd",
        "clang-format",
      }
      local dap = {
        "codelldb",
        "debugpy",
        "haskell-debug-adapter",
      }
      local ensure_installed = vim.list_extend({}, language_servers)
      ensure_installed = vim.list_extend(ensure_installed, formatting_tools)
      ensure_installed = vim.list_extend(ensure_installed, dap)
      require("mason-tool-installer").setup {
        ensure_installed = ensure_installed,
        run_on_start = false,
        start_delay = 0,
      }
      vim.cmd "MasonToolsUpdate"
    end,
  },
  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    dependencies = {
      "mason-org/mason.nvim",
    },
    config = function()
      vim.lsp.config("vtsls", require "lspconfig_overrides.vtsls")
      vim.lsp.config("html", require "lspconfig_overrides.html")
      vim.lsp.config("cssls", require "lspconfig_overrides.cssls")
      vim.lsp.config("basedpyright", require "lspconfig_overrides.basedpyright")
      vim.lsp.config("clangd", require "lspconfig_overrides.clangd")
      vim.lsp.config("cmake", require "lspconfig_overrides.cmake")
      vim.lsp.enable {
        "vtsls",
        "vue_ls",
        "html",
        "cssls",
        "clangd",
        "cmake",
        "slint_lsp",
        "hls",
      }
    end,
  },
}
