return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    dashboard = {
      preset = {
        header = [[
⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣿⣶⣄⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⢀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣦⣄⣀⡀⣠⣾⡇⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀
⠀⠀⠀⠀⢀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠿⢿⣿⣿⡇⠀⠀⠀⠀
⠀⣶⣿⣦⣜⣿⣿⣿⡟⠻⣿⣿⣿⣿⣿⣿⣿⡿⢿⡏⣴⣺⣦⣙⣿⣷⣄⠀⠀⠀
⠀⣯⡇⣻⣿⣿⣿⣿⣷⣾⣿⣬⣥⣭⣽⣿⣿⣧⣼⡇⣯⣇⣹⣿⣿⣿⣿⣧⠀⠀
⠀⠹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠸⣿⣿⣿⣿⣿⣿⣿⣷⠀
]],
      },
      -- Settings to control layout
      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 1 },
        { section = "startup" },
      },
    },
    input = {
      enabled = true,
      border = "rounded",
      title_pos = "center",
    },
    picker = {
      enabled = true,
      keys = {
        -- Primary navigation
        ["<C-j>"] = { "move_down", mode = { "i" } },
        ["<C-k>"] = { "move_up", mode = { "i" } },
        ["<Down>"] = { "move_down", mode = { "i", "n" } },
        ["<Up>"] = { "move_up", mode = { "i", "n" } },

        -- Selection
        ["<C-v>"] = { "select_vsplit", mode = { "i", "n" } },
        ["<C-s>"] = { "select_split", mode = { "i", "n" } },
        ["<C-t>"] = { "select_tab", mode = { "i", "n" } },
        ["<Esc>"] = { "close", mode = { "i", "n" } },
      },
      win = {
        input = {
          border = "rounded",
        },
      },
    },
    rename = {
      enabled = true,
    },
  },
  keys = {
    { "<leader>ff", function() require("snacks").picker.smart() end, desc = "Find files in cwd" },
    { "<leader>fr", function() require("snacks").picker.recent() end, desc = "Recent files" },
    { "<leader>fs", function() require("snacks").picker.grep() end, desc = "Find string in cwd" },
    { "<leader>fc", function() require("snacks").picker.grep_word() end, desc = "Find string under cursor in cwd" },
  },
  config = function(_, opts)
    local snacks = require("snacks")
    snacks.setup(opts)

    -- Defer highlight setup to avoid startup delay
    vim.defer_fn(function()
      vim.cmd([[
        highlight SnacksDashboardHeader guifg=#a7c080
        highlight SnacksDashboardKey guifg=#7fbbb3
        highlight SnacksDashboardDesc guifg=#d3c6aa
        highlight SnacksDashboardIcon guifg=#dbbc7f
        highlight SnacksDashboardTitle guifg=#e67e80
        highlight SnacksDashboardFooter guifg=#859289
        highlight SnacksDashboardSpecial guifg=#d699b6

        highlight SnacksInputBorder guifg=#a7c080
        highlight SnacksInputTitle guifg=#d3c6aa guibg=#3c4841
        highlight SnacksInputNormal guifg=#d3c6aa guibg=#272e33
        highlight SnacksInputPrompt guifg=#7fbbb3

        highlight SnacksPickerNormal guifg=#d3c6aa guibg=#272e33
        highlight SnacksPickerBorder guifg=#a7c080
        highlight SnacksPickerTitle guifg=#a7c080 guibg=#3c4841
        highlight SnacksPickerPrompt guifg=#7fbbb3
        highlight SnacksPickerSelected guifg=#272e33 guibg=#a7c080
        highlight SnacksPickerMatch guifg=#dbbc7f gui=bold
      ]])
    end, 10) -- Small delay to not block startup
  end,
}
