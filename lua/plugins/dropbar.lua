return {
  "Bekaboo/dropbar.nvim",
  event = { "BufReadPre", "BufNewFile" },
  keys = {
    { "<leader>;", function() require("dropbar.api").pick() end, desc = "Pick symbols in winbar" },
    { "[;", function() require("dropbar.api").goto_context_start() end, desc = "Go to start of current context" },
    { "];", function() require("dropbar.api").select_next_context() end, desc = "Select next context" },
  },
  opts = {
    bar = {
      enable = function(buf, win, _)
        -- vim.notify(vim.bo[buf].ft, vim.log.levels.WARN)
        if
          not vim.api.nvim_buf_is_valid(buf)
          or not vim.api.nvim_win_is_valid(win)
          or vim.fn.win_gettype(win) ~= ""
          or vim.wo[win].winbar ~= ""
          or vim.bo[buf].ft == "help"
        then
          return false
        end

        local stat = vim.uv.fs_stat(vim.api.nvim_buf_get_name(buf))
        if stat and stat.size > 1024 * 1024 then return false end

        return vim.bo[buf].ft == "markdown"
          or pcall(vim.treesitter.get_parser, buf)
          or not vim.tbl_isempty(vim.lsp.get_clients {
            bufnr = buf,
            method = "textDocument/documentSymbol",
          })
      end,
    },
  },
}
