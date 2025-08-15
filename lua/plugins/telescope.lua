return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "nvim-telescope/telescope-ui-select.nvim",
  },
  keys = {
    { "<leader>ff", function() require("telescope.builtin").find_files() end, desc = "Find files" },
    { "<leader>fk", function() require("telescope.builtin").keymaps() end, desc = "Find keymaps" },
    { "<leader>fs", function() require("telescope.builtin").builtin() end, desc = "Find select telescope" },
    { "<leader>fg", function() require("telescope.builtin").live_grep() end, desc = "Find by grep" },
    { "<leader>fw", function() require("telescope.builtin").grep_string() end, desc = "Find current word" },
    { "<leader>fd", function() require("telescope.builtin").diagnostics() end, desc = "Find diagnostics" },
    { "<leader>fo", function() require("telescope.builtin").oldfiles() end, desc = "Find recent files" },
    { "<leader>fb", function() require("telescope.builtin").buffers() end, desc = "Find buffers" },
    { "<leader>fh", function() require("telescope.builtin").help_tags() end, desc = "Find help tags" },
    { "<leader>f'", function() require("telescope.builtin").marks() end, desc = "Find marks" },
    { "<leader>fn", "<cmd>Telescope notify<cr>", desc = "Find notifications" },
    { "<leader>fm", function() require("telescope.builtin").man_pages() end, desc = "Find man pages" },
    { "<leader><cr>", "<cmd>:Telescope resume<cr>", desc = "Find man pages" },
    {
      "<leader>fe",
      function() require("telescope.builtin").find_files { cwd = vim.fn.stdpath "config" } end,
      desc = "Find N[e]ovim files",
    },
  },
  opts = function()
    require("telescope").load_extension "ui-select"
    return {
      defaults = {
        mappings = {
          i = {
            ["<esc>"] = require("telescope.actions").close,
            ["<C-u>"] = false,
          },
        },
      },
      pickers = {
        buffers = {
          mappings = {
            i = {
              ["<c-d>"] = require("telescope.actions").delete_buffer + require("telescope.actions").move_to_top,
            },
          },
        },
      },
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown(),
        },
      },
    }
  end,
}
