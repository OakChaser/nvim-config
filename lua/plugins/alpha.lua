vim.api.nvim_create_autocmd("User", {
  pattern = "AlphaReady",
  callback = function()
    vim.o.showtabline = 0
    vim.o.laststatus = 0
  end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "AlphaClosed",
  callback = function()
    vim.o.showtabline = 2
    vim.o.laststatus = 3
  end,
})
return {
  "goolord/alpha-nvim",
  dependencies = {
    "luukvbaal/statuscol.nvim",
  },
  config = function()
    local dashboard = require "alpha.themes.dashboard"
    local function movement_keys() return vim.g.keyboard_layout == "qwerty" and "hjkl" or "hnei" end
    local function movement_line() return [[    /:::========|  |==]] .. movement_keys() .. [[==:::\  \ required \   ]] end
    dashboard.section.header.val = {

      -- ▖ ▖▄▖▄▖▖▖▄▖▖  ▖
      -- ▛▖▌▙▖▌▌▌▌▐ ▛▖▞▌
      -- ▌▝▌▙▖▙▌▚▘▟▖▌▝ ▌
      --
      -- ╔╗╔╔═╗╔═╗╦  ╦╦╔╦╗
      -- ║║║║╣ ║ ║╚╗╔╝║║║║
      -- ╝╚╝╚═╝╚═╝ ╚╝ ╩╩ ╩

      [[      .-----------------------.   .-----.        ]],
      [[      |.-"""""""""""""""""""-.|   | === |        ]],
      [[      ||  ╔╗╔╔═╗╔═╗╦  ╦╦╔╦╗  ||   |-----|        ]],
      [[      ||  ║║║║╣ ║ ║╚╗╔╝║║║║  ||   | === |        ]],
      [[      ||  ╝╚╝╚═╝╚═╝ ╚╝ ╩╩ ╩  ||   |-----|        ]],
      [[      || Help poor children  ||   | === |        ]],
      [[      ||     in Uganda!      ||   |-----|        ]],
      [[      ||:wq                  ||   |:::::|        ]],
      [[      |'-...................-'|   |____o|        ]],
      [[      `"")-----------------(""`  ___________     ]],
      [[     /::::::::::|  |::::::::::\  \ no mouse \    ]],
      movement_line(),
      [[   '""""""""""""'  '""""""""""""'  '""""""""""'  ]],
    }
    vim.api.nvim_create_autocmd("User", {
      group = vim.api.nvim_create_augroup("alpha-keyboard-layout", { clear = true }),
      pattern = "KeyboardLayoutChanged",
      callback = function()
        local header = dashboard.section.header.val
        header[#header - 1] = movement_line()
        pcall(function() require("alpha").redraw() end)
      end,
    })
    dashboard.section.header.opts.hl = "DashboardHead"
    vim.api.nvim_set_hl(0, "DashboardHead", { fg = vim.g.my_colors.lavender })
    dashboard.section.buttons.val = {
      dashboard.button("LDR S c", "  Select session", "<leader>Ss"),
      dashboard.button("LDR S c", "  Last Session in Current Directory", "<leader>Sc"),
      dashboard.button("LDR r  ", "󰇥  Open Yazi", "<leader>r"),
      dashboard.button("LDR n  ", "  New File", "<leader>n"),
      dashboard.button("LDR f f", "  Find File", "<leader>ff"),
      dashboard.button("LDR f o", "  Recents", "<leader>fo"),
      dashboard.button("LDR f g", "  Find Word", "<leader>fg"),
      dashboard.button("LDR f '", "  Bookmarks", "<leader>f'"),
      dashboard.button("LDR q  ", "  Exit Neovim", "<leader>q"),
    }
    for _, button in ipairs(dashboard.section.buttons.val) do
      button.opts.hl = "AlphaDashboardButtons"
      button.opts.hl_shortcut = "AlphaDashboardShortcut"
    end
    vim.api.nvim_set_hl(0, "AlphaDashboardButtons", { fg = vim.g.my_colors.text })
    vim.api.nvim_set_hl(0, "AlphaDashboardShortcut", { fg = vim.g.my_colors.lavender })
    dashboard.section.footer.val = require "alpha.fortune"()
    dashboard.section.footer.opts.hl = "AlphaDashboardFooter"
    vim.api.nvim_set_hl(0, "AlphaDashboardFooter", { fg = vim.g.my_colors.overlay })
    require("alpha").setup(dashboard.config)
  end,
}
