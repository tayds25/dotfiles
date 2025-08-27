return {
  "nvim-tree/nvim-tree.lua",
  dependencies = "nvim-tree/nvim-web-devicons",
  cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeFocus", "NvimTreeFindFile", "NvimTreeCollapse" },
  keys = {
    { "<leader>ee", "<cmd>NvimTreeToggle<CR>", desc = "Toggle file explorer" },
    { "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", desc = "Toggle file explorer on current file" },
    { "<leader>ec", "<cmd>NvimTreeCollapse<CR>", desc = "Collapse file explorer" },
    { "<leader>er", "<cmd>NvimTreeRefresh<CR>", desc = "Refresh file explorer" },
  },
  config = function()
    local nvimtree = require("nvim-tree")

    -- recommended settings from nvim-tree documentation
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    nvimtree.setup({
      view = {
        width = 35,
        relativenumber = true,
      },
      -- change folder arrow icons
      renderer = {
        indent_markers = {
          enable = true,
        },
        icons = {
          glyphs = {
            folder = {
              arrow_closed = "", -- arrow when folder is closed
              arrow_open = "", -- arrow when folder is open
            },
          },
        },
      },
      -- disable window_picker for explorer to work well with window splits
      actions = {
        open_file = {
          window_picker = {
            enable = false,
          },
        },
      },
      filters = {
        custom = { ".DS_Store" },
      },
      git = {
        ignore = false,
      },
    })

    -- which-key grouped mappings
      local wk = require("which-key")
      wk.add({
        { "<leader>e", group = "📁 Explorer" },

        { "<leader>ee", "<cmd>NvimTreeToggle<CR>", desc = "Toggle file explorer" },
        { "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", desc = "Toggle file explorer on current file" },
        { "<leader>ec", "<cmd>NvimTreeCollapse<CR>", desc = "Collapse file explorer" },
        { "<leader>er", "<cmd>NvimTreeRefresh<CR>", desc = "Refresh file explorer" },
      })
    end
}
