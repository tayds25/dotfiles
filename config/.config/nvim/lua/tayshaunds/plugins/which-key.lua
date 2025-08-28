return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
  end,
  opts = {
    preset = "helix",
    icons = {
      rules = false, -- disable automatic icon rules
      mappings = false, -- disable mapping icons to only show our custom ones
    },
  },
  config = function(_, opts)
    local wk = require("which-key")

    -- Modify opts to remove height limit for helix preset
    opts.win = opts.win or {}
    opts.win.height = opts.win.height or {}
    opts.win.height.max = math.huge

    wk.setup(opts)

    -- Register core keymap groups
    wk.add({
      { "<leader>s", group = "🪟 Splits" },
      { "<leader>t", group = "📑 Tabs" },
      { "<leader>f", group = "🔍 Find" },
      { "<leader>e", group = "🌳 Explorer" },
      { "<leader>w", group = "💾 Sessions" },
      { "<leader>x", group = "🚨 Trouble" },
      { "<leader>h", group = "🔧 Git" },
    })

    -- Apply custom styling after setup to preserve preset behavior
    vim.cmd([[
      highlight WhichKeyFloat guibg=NONE
      highlight WhichKeyBorder guifg=#3C4841
      highlight WhichKeyTitle guifg=#d3c6aa guibg=NONE
      highlight WhichKeyNormal guifg=#d3c6aa guibg=NONE
      highlight WhichKeyGroup guifg=#9DA9A0
      highlight WhichKeyDesc guifg=#d3c6aa
      highlight WhichKeySeparator guifg=#859289
      highlight WhichKey guifg=#A7C080
    ]])
  end,
}