return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "nvim-telescope/telescope-ui-select.nvim",
  },
  keys = {
    { "<leader>ff", require("telescope.builtin").find_files, desc = "Find files" },
    { "<leader>fk", require("telescope.builtin").keymaps, desc = "Find keymaps" },
    { "<leader>fs", require("telescope.builtin").builtin, desc = "Find select telescope" },
    { "<leader>fg", require("telescope.builtin").live_grep, desc = "Find by grep" },
    { "<leader>fw", require("telescope.builtin").grep_string, desc = "Find current word" },
    { "<leader>fd", require("telescope.builtin").diagnostics, desc = "Find diagnostics" },
    { "<leader>fo", require("telescope.builtin").oldfiles, desc = "Find recent files" },
    { "<leader>fb", require("telescope.builtin").buffers, desc = "Find buffers" },
    { "<leader>fh", require("telescope.builtin").help_tags, desc = "Find help tags" },
    { "<leader>f'", require("telescope.builtin").marks, desc = "Find marks" },
    { "<leader>fn", "<cmd>Telescope notify<cr>", desc = "Find notifications" },
    { "<leader>fm", require("telescope.builtin").man_pages, desc = "Find man pages" },
    {
      "<leader>fe",
      function()
        require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })
      end,
      desc = "Find N[e]ovim files",
    },
  },
  opts = {
    defaults = {
      buffer_previewer_maker = function(filepath, bufnr, opts)
        filepath = vim.fn.expand(filepath)
        require("plenary.job")
          :new({
            command = "file",
            args = { "--mime-type", "-b", filepath },
            on_exit = function(j)
              local mime_type = vim.split(j:result()[1], "/")[1]
              if mime_type == "text" then
                require("telescope.previewers").buffer_previewer_maker(filepath, bufnr, opts)
              else
                -- maybe we want to write something to the buffer here
                vim.schedule(function()
                  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "BINARY" })
                end)
              end
            end,
          })
          :sync()
      end,
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
    init = function()
      require("telescope").load_extension("ui-select")
    end,
  },
}
