return {
  "romgrk/barbar.nvim",
  dependencies = {
    "lewis6991/gitsigns.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  event = "UiEnter",
  opts = {
    insert_at_start = false,
    icons = {
      buffer_index = true,
      diagnostics = {
        [vim.diagnostic.severity.ERROR] = { enabled = true },
        [vim.diagnostic.severity.WARN] = { enabled = true },
        [vim.diagnostic.severity.INFO] = { enabled = true },
        [vim.diagnostic.severity.HINT] = { enabled = false },
      },
    },
  },
  keys = {
    {
      "<A-,>",
      "<Cmd>BufferPrevious<CR>",
    },
    {
      "<A-.>",
      "<Cmd>BufferNext<CR>",
    },
    { "<A-<>", "<Cmd>BufferMovePrevious<CR>" },
    { "<A->>", "<Cmd>BufferMoveNext<CR>" },
    { "<A-1>", "<Cmd>BufferGoto 1<CR>" },
    { "<A-2>", "<Cmd>BufferGoto 2<CR>" },
    { "<A-3>", "<Cmd>BufferGoto 3<CR>" },
    { "<A-4>", "<Cmd>BufferGoto 4<CR>" },
    { "<A-5>", "<Cmd>BufferGoto 5<CR>" },
    { "<A-6>", "<Cmd>BufferGoto 6<CR>" },
    { "<A-7>", "<Cmd>BufferGoto 7<CR>" },
    { "<A-8>", "<Cmd>BufferGoto 8<CR>" },
    { "<A-9>", "<Cmd>BufferGoto 9<CR>" },
    { "<A-0>", "<Cmd>BufferLast<CR>" },
    { "<A-p>", "<Cmd>BufferPin<CR>" },
    { "<C-w>", "<Cmd>BufferClose<CR>" },
    {
      "<leader>c",
      function()
        local bar = require("barbar")
        local alpha = require("alpha")
        local buffers = vim.api.nvim_list_bufs()
        local valid_buffers = 0
        for _, buf in ipairs(buffers) do
          if vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_get_option(buf, "buflisted") then
            valid_buffers = valid_buffers + 1
          end
        end
        if valid_buffers == 1 then
          vim.cmd("BufferClose")
          alpha.start()
        elseif valid_buffers == 0 then
          return
        else
          vim.cmd("BufferClose")
        end
      end,
      desc = "Close current buffer",
    },
    { "<C-p>", "<Cmd>BufferPick<CR>" },
    { "<C-s-p>", "<Cmd>BufferPickDelete<CR>" },
    { "<leader>bc", "<Cmd>BufferCloseAllButCurrentOrPinned<CR>", desc = "Close all but current or pinned" },
    { "<leader>bb", "<Cmd>BufferOrderByBufferNumber<CR>", desc = "Order by buffer number" },
    { "<leader>bn", "<Cmd>BufferOrderByName<CR>", desc = "Order by name" },
    { "<leader>bd", "<Cmd>BufferOrderByDirectory<CR>", desc = "Order by directory" },
    { "<leader>bl", "<Cmd>BufferOrderByLanguage<CR>", desc = "Order by language" },
    { "<leader>bw", "<Cmd>BufferOrderByWindowNumber<CR>", desc = "Order by window number" },
  },
  version = "^1.0.0",
}
