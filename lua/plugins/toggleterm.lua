local terms = {}

function Toggle_term_cmd(opts)
  local num = vim.v.count > 0 and vim.v.count or 1
  -- if terminal doesn't exist yet, create it
  if not terms[opts.cmd] then terms[opts.cmd] = {} end
  if not terms[opts.cmd][num] then
    if not opts.count then opts.count = vim.tbl_count(terms) * 100 + num end
    opts.on_exit = function(...) terms[opts.cmd][num] = nil end
    terms[opts.cmd][num] = require("toggleterm.terminal").Terminal:new(opts)
  end
  -- toggle the terminal
  terms[opts.cmd][num]:toggle()
end

return {
  "akinsho/toggleterm.nvim",
  cmd = { "ToggleTerm", "TermExec" },
  keys = {
    { "<leader>tf", "<cmd>ToggleTerm direction=float name=Terminal<cr>", desc = "Open float terminal" },
    { "<leader>tt", "<cmd>terminal<cr>", desc = "Open terminal in new buffer" },
    {
      "<leader>tp",
      function() Toggle_term_cmd { hidden = true, cmd = "python", display_name = "Python" } end,
      desc = "Open python in terminal",
    },
    {
      "<leader>tn",
      function() Toggle_term_cmd { hidden = true, cmd = "node", display_name = "NodeJS" } end,
      desc = "Open node in terminal",
    },
    {
      "<leader>tr",
      function() Toggle_term_cmd { hidden = true, cmd = "evcxr", display_name = "evcxr repl" } end,
      desc = "Open evcxr(Rust) in terminal",
    },
    {
      "<leader>tb",
      function() Toggle_term_cmd { hidden = true, cmd = "btop", direction = "float", display_name = "Btop" } end,
      desc = "Open btop in terminal",
    },
    {
      "<leader>tl",
      function() Toggle_term_cmd { hidden = true, cmd = "lazygit", direction = "float", display_name = "LazyGit" } end,
      desc = "Open LazyGit in terminal",
    },
  },
  opts = {
    float_opts = {
      border = "rounded",
    },
  },
}
