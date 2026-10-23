vim.api.nvim_create_user_command("ToggleWrap", function()
  vim.wo.wrap = not vim.wo.wrap
  local new_state = vim.wo.wrap and "ON" or "OFF"
  vim.notify("Line wrap: " .. new_state, vim.log.levels.INFO)
end, {})

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
  { "|", "<cmd>split<cr>", mode = { "n", "v" } },
  { "\\", "<cmd>vsplit<cr>", mode = { "n", "v" } },
  -- Others
  { "<Esc>", "<cmd>nohlsearch<CR>", desc = "Clear search", mode = "n" },
  { "<a-esc>", "<c-\\><c-n><c-w>q", mode = "t" },
  { "<c-esc>", "<c-\\><c-n>l", mode = "t" },
  { "`", "~", mode = "v" },
  { "p", "P", mode = "v" },
  { "<leader>w", "<cmd>w<cr>", desc = "Save", mode = { "n" } },
  { "<leader>q", "<cmd>q<cr>", desc = "Quit", mode = { "n" } },
  { "<leader>n", "<cmd>enew<cr>", desc = "New file", mode = { "n" } },
  { ";", ":", desc = "command", mode = { "n", "v" } },
  { "<leader>L", "<cmd>Lazy<cr>", mode = { "n", "v" } },
  { "<leader>uw", "<cmd>ToggleWrap<cr>", desc = "Toggle wrap", mode = { "v", "n" } },
  { ";", "", mode = "c" },
}

-- Colemak keeps HJKL at the same physical keys: h/n/e/i.
local colemak_nmappings = {
  -- Movements
  { "n", "j", mode = { "n", "v" } },
  { "e", "k", mode = { "n", "v" } },
  { "i", "l", mode = "n" },
  -- NOTE: nowait avoids Neovim's default visual/operator `in` mapping.
  { "i", "l", mode = "v", nowait = true },
  { "N", "5j", mode = { "n", "v" } },
  { "E", "5k", mode = { "n", "v" } },
  { "H", "0", mode = { "n", "v" } },
  { "I", "$", mode = "n" },
  { "I", "i", mode = "v" }, -- keep visual inner text objects available
  { "gl", "e", mode = { "n", "v" } },
  { "gL", "E", mode = { "n", "v" } },
  -- Displaced native actions
  { "u", "i", mode = "n" },
  { "U", "I", mode = "n" },
  { "l", "u", mode = "n" },
  { "k", "n", mode = "n" },
  { "K", "N", mode = "n" },
  -- Preserve g-commands affected by the n/e/i remaps
  { "gi", "gi", mode = { "n", "v" } },
  { "gI", "gI", mode = { "n", "v" } },
  { "gn", "gn", mode = { "n", "v" } },
  { "gN", "gN", mode = { "n", "v" } },
  { "ge", "ge", mode = { "n", "v" } },
  { "gE", "gE", mode = { "n", "v" } },
  { "gu", "gu", mode = { "n", "v" } },
  { "gU", "gU", mode = { "n", "v" } },
  -- Scroll
  { "<C-e>", "5<C-y>", mode = { "n", "v" } },
  { "<C-n>", "5<C-e>", mode = { "n", "v" } },
  -- Move lines
  { "<A-n>", "ddp" },
  { "<A-e>", "ddkP" },
  -- Window
  { "<C-w>n", "<C-w>j" },
  { "<C-w>e", "<C-w>k" },
  { "<C-w>i", "<C-w>l" },
  -- Others
  { "c,.", "c%" },
  { "<C-A>", "ggVG", mode = { "n", "v" } },
  { "<C-A>", "<esc>ggVG", mode = "i" },
  { "|", "<cmd>split<cr>", mode = { "n", "v" } },
  { "\\", "<cmd>vsplit<cr>", mode = { "n", "v" } },
  { "<Esc>", "<cmd>nohlsearch<CR>", desc = "Clear search", mode = "n" },
  { "<a-esc>", "<c-\\><c-n><c-w>q", mode = "t" },
  { "<c-esc>", "<c-\\><c-n>l", mode = "t" },
  { "`", "~", mode = "v" },
  { "p", "P", mode = "v" },
  { "<leader>w", "<cmd>w<cr>", desc = "Save", mode = { "n" } },
  { "<leader>q", "<cmd>q<cr>", desc = "Quit", mode = { "n" } },
  { "<leader>n", "<cmd>enew<cr>", desc = "New file", mode = { "n" } },
  { ";", ":", desc = "command", mode = { "n", "v" } },
  { "<leader>L", "<cmd>Lazy<cr>", mode = { "n", "v" } },
  { "<leader>uw", "<cmd>ToggleWrap<cr>", desc = "Toggle wrap", mode = { "v", "n" } },
  { ";", "", mode = "c" },
}

-- NOTE: Default mode is n,v,i
local neovide_mappings = {
  { "<F11>", "<cmd>let g:neovide_fullscreen = !g:neovide_fullscreen<CR>" },
  {
    "<d-=>",
    function() change_scale_factor(1.25) end,
  },
  {
    "<d-->",
    function() change_scale_factor(1 / 1.25) end,
  },
  {
    "<d-0>",
    function() vim.g.neovide_scale_factor = 1.0 end,
  },
}

local layouts = {
  qwerty = qwerty_nmappings,
  colemak = colemak_nmappings,
}

local function mapping_modes(mapping, fallback)
  if mapping.mode == nil then return fallback end
  if type(mapping.mode) == "string" then return { mapping.mode } end
  return mapping.mode
end

local function apply_mappings(nmappings)
  for _, mapping in ipairs(nmappings) do
    vim.keymap.set(mapping.mode or "n", mapping[1], mapping[2], {
      noremap = true,
      nowait = mapping.nowait or false,
      expr = mapping.expr or false,
      desc = mapping.desc or "",
    })
  end

  if vim.g.neovide then
    for _, mapping in ipairs(nmappings) do
      if mapping.mode == nil then
        vim.keymap.set({ "n", "v", "i" }, mapping[1], mapping[2], {
          noremap = true,
          nowait = mapping.nowait or false,
          expr = mapping.expr or false,
          desc = mapping.desc or "",
        })
      end
    end
  end
end

local function clear_mappings(nmappings)
  for _, mapping in ipairs(nmappings) do
    for _, mode in ipairs(mapping_modes(mapping, { "n", "v", "i" })) do
      pcall(vim.keymap.del, mode, mapping[1])
    end
  end
end

local function disable_conflicting_defaults()
  -- Neovim 0.12 maps `in` in visual mode to LSP/treesitter selection. It is a
  -- longer mapping than Colemak's `i` -> `l`, so `i` followed by `n` would
  -- trigger the built-in instead of moving right and down.
  pcall(vim.keymap.del, "x", "in")
end

local function set_layout(name)
  if not layouts[name] then
    vim.notify(("Unknown keyboard layout: %s"):format(name), vim.log.levels.ERROR)
    return
  end

  clear_mappings(qwerty_nmappings)
  clear_mappings(colemak_nmappings)
  vim.g.keyboard_layout = name
  apply_mappings(layouts[name])
  if name == "colemak" then disable_conflicting_defaults() end
  vim.api.nvim_exec_autocmds("User", { pattern = "KeyboardLayoutChanged" })
  vim.notify(("Keyboard layout: %s"):format(name), vim.log.levels.INFO)
end

local active_layout = vim.g.keyboard_layout or "colemak"
if not layouts[active_layout] then
  vim.notify(("Unknown keyboard layout: %s"):format(active_layout), vim.log.levels.WARN)
  active_layout = "colemak"
end
vim.g.keyboard_layout = active_layout

apply_mappings(layouts[active_layout])
if active_layout == "colemak" then disable_conflicting_defaults() end

vim.api.nvim_create_user_command("KeyboardLayout", function(opts)
  if opts.args == "" then
    vim.notify(("Keyboard layout: %s"):format(vim.g.keyboard_layout), vim.log.levels.INFO)
    return
  end
  set_layout(opts.args)
end, {
  nargs = "?",
  complete = function() return { "qwerty", "colemak" } end,
})
