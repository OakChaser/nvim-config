vim.api.nvim_create_autocmd("User", {
  pattern = "AlphaReady",
  callback = function()
    vim.o.showtabline = 0
  end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "AlphaClosed",
  callback = function()
    vim.o.showtabline = 2
  end,
})
return {
  "goolord/alpha-nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "akinsho/bufferline.nvim",
  },
  config = function()
    local dashboard = require("alpha.themes.dashboard")
    dashboard.section.header.val = {
      [[                                 .-----.        ]],
      [[      .----------------------.   | === |        ]],
      [[      |.-""""""""""""""""""-.|   |-----|        ]],
      [[      ||                    ||   | === |        ]],
      [[      ||       NEOVIM       ||   |-----|        ]],
      [[      ||                    ||   | === |        ]],
      [[      ||                    ||   |-----|        ]],
      [[      ||:wq                 ||   |:::::|        ]],
      [[      |'-..................-'|   |____o|        ]],
      [[      `"")----------------(""`   ___________    ]],
      [[     /::::::::::|  |::::::::::\  \ no mouse \   ]],
      [[    /:::========|  |==hjkl==:::\  \ required \  ]],
      [[   '""""""""""""'  '""""""""""""'  '""""""""""' ]],
    }
    dashboard.section.buttons.val = {
      dashboard.button("LDR S l", "  Last Session", "<leader>Sl"),
      dashboard.button("LDR r  ", "󰇥  Open Yazi", "<leader>r"),
      dashboard.button("LDR n  ", "  New File", "<leader>n"),
      dashboard.button("LDR f f", "  Find File", "<leader>ff"),
      dashboard.button("LDR f o", "  Recents", "<leader>fo"),
      dashboard.button("LDR f g", "  Find Word", "<leader>fg"),
      dashboard.button("LDR f '", "  Bookmarks", "<leader>f'"),
      dashboard.button("LDR q  ", "  Exit Neovim", "<leader>q"),
    }
    dashboard.section.footer.val = require("alpha.fortune")()
    require("alpha").setup(dashboard.config)
  end,
}
