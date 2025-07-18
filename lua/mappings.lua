local qwerty_nmappings = {
  -- Movements
  { "<C-k>", "5<C-y>", mode = { "n", "v" } },
  { "<C-j>", "5<C-e>", mode = { "n", "v" } },
  { "<A-j>", "ddp" }, -- NOTE: You need add "xterm*metaSendsEscape: true" to ~/.Xdefaults and run "xrdb -l ~/.Xdefaults"
  { "<A-k>", "ddkP" },
  { "j", [[v:count?'j':'gj']], expr = true },
  { "k", [[v:count?'k':'gk']], expr = true },
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
  { "<up>", "<cmd>res -1<CR>" },
  { "<down>", "<cmd>res +1<CR>" },
  { "<left>", "<cmd>vertical resize+1<CR>" },
  { "<right>", "<cmd>vertical resize-1<CR>" },
  { "|", "<cmd>split<cr>" },
  { "\\", "<cmd>vsplit<cr>" },
  -- Others
  { "<Esc>", "<cmd>nohlsearch<CR>", desc = "Clear search" },
  { "<Leader>k", "K" },
  { "<a-esc>", "<c-\\><c-n><c-w>q", mode = "t" },
  { "<c-esc>", "<c-\\><c-n>l", mode = "t" },
  { "`", "~", mode = "v" },
  { "p", "P", mode = "v" },
  { "<leader>w", "<cmd>w<cr>", desc = "Save" },
  { "<leader>q", "<cmd>q<cr>", desc = "Quit" },
  { "<C-s>", "<cmd>w<cr>", desc = "Save", mode = { "n", "v", "i" } },
  { "<leader>n", "<cmd>enew<cr>", desc = "New file" },
  { ";", ":", desc = "command", mode = { "n", "v" } },
  { "<leader>L", "<cmd>Lazy<cr>", mode = { "n", "v" } },
}

local nmappings = qwerty_nmappings
for _, mapping in ipairs(nmappings) do
  vim.keymap.set(mapping.mode or "n", mapping[1], mapping[2], { noremap = true, expr = mapping.expr or false, desc = mapping.desc or "" })
end
