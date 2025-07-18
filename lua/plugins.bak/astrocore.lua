-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
--Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing
---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 256, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics_mode = 3, -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = true, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        scrolloff = 3,
        sidescrolloff = 3,
        signcolumn = "yes", -- sets vim.opt.signcolumn to yes
        wrap = false, -- sets vim.opt.wrap
        showcmd = true,
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {
        -- second key is the lefthand side of the map

        -- setting a mapping to false will disable it
        -- ["<C-S>"] = false,
        ["`"] = { "~" },

        -- Qwerty Keymaps
        ["<C-K>"] = { "5<C-y>" },
        ["<C-J>"] = { "5<C-e>" },
        ["<A-j>"] = { "ddp" }, -- NOTE: You need add "xterm*metaSendsEscape: true" to ~/.Xdefaults and run "xrdb -l ~/.Xdefaults"
        ["<A-k>"] = { "ddkP" },
        ["j"] = { [[v:count?'j':'gj']], desc = "" },
        ["k"] = { [[v:count?'k':'gk']], desc = "" },
        ["J"] = { "5j", desc = "" },
        ["K"] = { "5k", desc = "" },
        ["H"] = { "0" },
        ["L"] = { "$" },
        ["c,."] = { "c%" },
        ["<C-A>"] = { "ggVG" },
        ["<A-o>"] = { "o<esc>k$" },
        -- Windows
        ["<leader>w"] = { desc = "Window Move" },
        ["<leader>wk"] = { "<C-w>k" },
        ["<leader>wj"] = { "<C-w>j" },
        ["<leader>wh"] = { "<C-w>h" },
        ["<leader>wl"] = { "<C-w>l" },
        ["<up>"] = { "<cmd>res -1<CR>" },
        ["<down>"] = { "<cmd>res +1<CR>" },
        ["<left>"] = { "<cmd>vertical resize+1<CR>" },
        ["<right>"] = { "<cmd>vertical resize-1<CR>" },
        -- Others
        ["<Leader>k"] = { "K" },

        -- Colemak Keymaps
        -- Movement
        -- ["u"] = { "k" },
        -- ["e"] = { "j" },
        -- ["n"] = { "h" },
        -- ["i"] = { "l" },
        -- ["U"] = { "5k" },
        -- ["E"] = { "5j" },
        -- ["N"] = { "0" },
        -- ["I"] = { "$" },
        -- ["h"] = { "e" },
        -- ["<C-U>"] = { "5<C-y>" },
        -- ["<C-E>"] = { "5<C-e>" },
        -- ["ci"] = { "cl" },
        -- ["cn"] = { "ch" },
        -- ["ck"] = { "ci" },
        -- ["c,."] = { "c%" },
        -- ["yh"] = { "ye" },
        -- Actions
        -- ["l"] = { "u" },
        -- ["k"] = { "i" },
        -- ["K"] = { "I" },

        -- Others
        -- ["<C-A>"] = { "ggVG" },
        -- ["J"] = { "K" },
      },
      t = {
        ["<a-esc>"] = { "<c-\\><c-n><c-w>q" },
        ["<c-esc>"] = { "<c-\\><c-n>l" },
      },
      v = {
        ["`"] = { "~" },
        ["p"] = { "P" },

        -- Qwerty Keymaps
        ["J"] = { "5j" },
        ["K"] = { "5k" },
        ["H"] = { "0" },
        ["L"] = { "$" },
        ["<C-J>"] = { "5<C-y>" },
        ["<C-K>"] = { "5<C-e>" },
        -- Actions
        ["<C-A>"] = { "<ESC> ggVG" },

        -- Colemak Keymaps
        -- Movement
        -- ["u"] = { "k" },
        -- ["e"] = { "j" },
        -- ["n"] = { "h" },
        -- ["i"] = { "l" },
        -- ["U"] = { "5k" },
        -- ["E"] = { "5j" },
        -- ["N"] = { "0" },
        -- ["I"] = { "$" },
        -- ["h"] = { "e" },
        -- ["<C-U>"] = { "5<C-y>" },
        -- ["<C-E>"] = { "5<C-e>" },
        -- Actions
        -- ["k"] = { "i" },
        -- ["K"] = { "I" },
        -- ["<C-A>"] = { "<ESC>ggVG" },
      },
      i = {
        ["<c-y>"] = { "<ESC>A {}<ESC>i<CR><ESC>ko" },
        ["<c-v>"] = { "<ESC>pa" },

        -- Qwerty Keymaps
        ["<c-h>"] = { "<esc>I" },
        ["<c-l>"] = { "<esc>A" },
        ["<C-K>"] = { "<esc>5<C-y>a" },
        ["<C-J>"] = { "<esc>5<C-e>a" },

        -- Colemak Keymaps
        -- ["<c-n>"] = { "<ESC>A" },
        -- ["<c-i>"] = { "<ESC>I" },
      },
    },
  },
}
