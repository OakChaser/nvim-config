vim.api.nvim_create_user_command("ToggleWrap", function()
  vim.wo.wrap = not vim.wo.wrap
  local new_state = vim.wo.wrap and "ON" or "OFF"
  vim.notify("Line wrap: " .. new_state, vim.log.levels.INFO)
end, {})

local function quit()
  local bufs = vim.fn.getbufinfo({ buflisted = 1 })
  local protect_buf = vim.api.nvim_create_buf(true, false)
  for _, buf in ipairs(bufs) do
    if protect_buf ~= buf then
      require("mini.bufremove").delete(buf.bufnr)
    end
  end
  if vim.fn.getbufinfo({ buflisted = 1 }) and vim.fn.getbufinfo(protect_buf) then
    vim.cmd("q!")
  end
end

local qwerty_nmappings = {
  -- Movements
  { "<C-k>", "5<C-y>", mode = { "n", "v" } },
  { "<C-j>", "5<C-e>", mode = { "n", "v" } },
  { "<A-j>", "ddp" }, -- NOTE: You need add "xterm*metaSendsEscape: true" to ~/.Xdefaults and run "xrdb -l ~/.Xdefaults"
  { "<A-k>", "ddkP" },
  -- { "j", [[v:count?'j':'gj']], expr = true },
  -- { "k", [[v:count?'k':'gk']], expr = true },
  { "J", "5j", mode = { "n", "v" } },
  { "K", "5k", mode = { "n", "v" } },
  { "H", "0", mode = { "n", "v" } },
  { "L", "$", mode = { "n", "v" } },
  { "c,.", "c%" },
  { "<C-A>", "ggVG", mode = { "n", "v" } },
  { "<C-A>", "<esc>ggVG", mode = "i" },
  { "<A-o>", "o<esc>k$" },
  -- Window
  { "<c-s-k>", "<C-w>k" },
  { "<c-s-j>", "<C-w>j" },
  { "<c-s-h>", "<C-w>h" },
  { "<c-s-l>", "<C-w>l" },
  { "<c-h>", "<C-w>h" },
  { "<c-l>", "<C-w>l" },
  -- { "<up>", "<cmd>res -1<CR>" },
  -- { "<down>", "<cmd>res +1<CR>" },
  -- { "<left>", "<cmd>vertical resize+1<CR>" },
  -- { "<right>", "<cmd>vertical resize-1<CR>" },
  { "|", "<cmd>split<cr>" },
  { "\\", "<cmd>vsplit<cr>" },
  -- Others
  { "<Esc>", "<cmd>nohlsearch<CR>", desc = "Clear search" },
  { "<a-esc>", "<c-\\><c-n><c-w>q", mode = "t" },
  { "<c-esc>", "<c-\\><c-n>l", mode = "t" },
  { "`", "~", mode = "v" },
  { "p", "P", mode = "v" },
  { "<leader>w", "<cmd>w<cr>", desc = "Save" },
  {
    "<leader>q",
    quit,
    desc = "Quit",
  },
  {
    "<c-q>",
    "<cmd>q!<cr>",
    desc = "Force Quit",
  },
  { "<C-s>", "<cmd>w<cr>", desc = "Save", mode = { "n", "v", "i" } },
  { "<leader>n", "<cmd>enew<cr>", desc = "New file" },
  { ";", ":", desc = "command", mode = { "n", "v" } },
  { "<leader>L", "<cmd>Lazy<cr>", mode = { "n", "v" } },
  { "<leader>uw", "<cmd>ToggleWrap<cr>", mode = { "v", "n" }, desc = "Toggle wrap" },
  { ";", "", mode = "c" },
}
-- NOTE: Default mode is n,v,i
local neovide_mappings = {
  { "<F11>", "<cmd>let g:neovide_fullscreen = !g:neovide_fullscreen<CR>" },
  {
    "<c-=>",
    function()
      change_scale_factor(1.25)
    end,
  },
  {
    "<c-->",
    function()
      change_scale_factor(1 / 1.25)
    end,
  },
  {
    "<c-0>",
    function()
      vim.g.neovide_scale_factor = 1.0
    end,
  },
}

local nmappings = qwerty_nmappings
for _, mapping in ipairs(nmappings) do
  vim.keymap.set(
    mapping.mode or "n",
    mapping[1],
    mapping[2],
    { noremap = true, expr = mapping.expr or false, desc = mapping.desc or "" }
  )
end
if vim.g.neovide then
  for _, mapping in ipairs(nmappings) do
    vim.keymap.set(
      mapping.mode or { "n", "v", "i" },
      mapping[1],
      mapping[2],
      { noremap = true, expr = mapping.expr or false, desc = mapping.desc or "" }
    )
  end
end
