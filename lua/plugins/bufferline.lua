local function is_pinned(element)
  return require("bufferline.groups")._is_pinned(element)
end

return {
  "akinsho/bufferline.nvim",
  version = "*",
  event = { "BufReadPre", "BufNewFile" },

  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "catppuccin/nvim",
    "kazhala/close-buffers.nvim",
    { "echasnovski/mini.bufremove", version = "*", opts = {
      silent = true,
    } },
  },
  keys = {
    {
      "<leader>c",
      function()
        local bufs = vim.fn.getbufinfo({ buflisted = 1 })
        if not bufs[2] then
          if not bufs[1] then
            vim.cmd("q!")
          end
          require("alpha").start()
          require("mini.bufremove").delete(bufs[1].bufnr)
        else
          require("mini.bufremove").delete()
        end
      end,
      desc = "Close current buffer",
    },
    {
      "<leader>bc",
      function()
        local bufs = require("bufferline").get_elements().elements
        local current = vim.api.nvim_get_current_buf()
        for _, element in ipairs(bufs) do
          if not is_pinned(element) and element.id ~= current then
            require("mini.bufremove").delete(element.id)
          end
        end
      end,
      desc = "Close other buffers but pinned",
    },
    {
      "<a-1>",
      "<cmd>BufferLineGoToBuffer 1<cr>",
    },
    {
      "<a-2>",
      "<cmd>BufferLineGoToBuffer 2<cr>",
    },
    {
      "<a-3>",
      "<cmd>BufferLineGoToBuffer 3<cr>",
    },
    {
      "<a-4>",
      "<cmd>BufferLineGoToBuffer 4<cr>",
    },
    {
      "<a-5>",
      "<cmd>BufferLineGoToBuffer 5<cr>",
    },
    {
      "<a-6>",
      "<cmd>BufferLineGoToBuffer 6<cr>",
    },
    {
      "<a-7>",
      "<cmd>BufferLineGoToBuffer 7<cr>",
    },
    {
      "<a-8>",
      "<cmd>BufferLineGoToBuffer 8<cr>",
    },
    {
      "<a-9>",
      "<cmd>BufferLineGoToBuffer 9<cr>",
    },
    {
      "]b",
      "<cmd>BufferLineCycleNext<cr>",
      desc = "Next buffer",
    },
    {
      "[b",
      "<cmd>BufferLineCyclePrev<cr>",
      desc = "Previous buffer",
    },
    {
      "<c-p>",
      "<cmd>BufferLinePick<cr>",
      desc = "Pick buffer",
    },
    {
      "<c-s-p>",
      "<cmd>BufferLinePickClose<cr>",
      desc = "Pick buffer close",
    },
    {
      "<leader>bd",
      "<cmd>BufferLineSortByDirectory<cr>",
      desc = "Sort by directory",
    },
    {
      "<leader>bd",
      "<cmd>BufferLineSortByRelativeDirectory<cr>",
      desc = "Sort by relative directory",
    },
    {
      "<leader>bd",
      "<cmd>BufferLineSortByExtension<cr>",
      desc = "Sort by extension",
    },
    {
      "<leader>bd",
      "<cmd>BufferLineSortByTabs<cr>",
      desc = "Sort by tabs",
    },
    {
      "<leader>bp",
      "<cmd>BufferLineTogglePin<cr>",
      desc = "Toggle pin",
    },
  },
  config = function()
    require("bufferline").setup({
      options = {
        diagnostics = "nvim_lsp",
        numbers = "ordinal",
        indicator = {
          style = "icon",
        },
        diagnostics_indicator = function(_, _, diagnostics_dict, _)
          local number = (diagnostics_dict.error or 0) + (diagnostics_dict.warning or 0)
          if number == 0 then
            return ""
          end
          return tostring(number)
        end,
        groups = {
          items = {
            require("bufferline.groups").builtin.pinned:with({ icon = " 󰐃" }),
          },
        },
      },
      highlights = require("catppuccin.groups.integrations.bufferline").get({
        styles = { "bold" },
        custom = {
          all = {
            indicator_visible = { fg = vim.g.my_colors.lavender },
            indicator_selected = { fg = vim.g.my_colors.lavender },
            warning = { fg = vim.g.my_colors.orange },
            warning_visible = { fg = vim.g.my_colors.orange },
            warning_selected = { fg = vim.g.my_colors.orange },
            warning_diagnostic = { fg = vim.g.my_colors.orange },
            warning_diagnostic_visible = { fg = vim.g.my_colors.orange },
            warning_diagnostic_selected = { fg = vim.g.my_colors.orange },
            duplicate_selected = { fg = vim.g.my_colors.overlay },
            modified_selected = { fg = vim.g.my_colors.text },
            modified = { fg = vim.g.my_colors.overlay },
            modified_visible = { fg = vim.g.my_colors.overlay },
          },
        },
      }),
    })
  end,
}
