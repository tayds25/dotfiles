return {
  {
    "nvim-lua/plenary.nvim", -- lua functions that many plugins use
    lazy = true, -- Only load when needed by other plugins
  },
  {
    'mrjones2014/smart-splits.nvim', -- directional navigation and resizing of Neovim + terminal multiplexer splits
    lazy = true,
    keys = {
      -- Window navigation
      { "<C-h>", function() require("smart-splits").move_cursor_left() end, desc = "Move to left split" },
      { "<C-j>", function() require("smart-splits").move_cursor_down() end, desc = "Move to below split" },
      { "<C-k>", function() require("smart-splits").move_cursor_up() end, desc = "Move to above split" },
      { "<C-l>", function() require("smart-splits").move_cursor_right() end, desc = "Move to right split" },

      -- Window resizing
      { "<A-h>", function() require("smart-splits").resize_left() end, desc = "Resize split left" },
      { "<A-j>", function() require("smart-splits").resize_down() end, desc = "Resize split down" },
      { "<A-k>", function() require("smart-splits").resize_up() end, desc = "Resize split up" },
      { "<A-l>", function() require("smart-splits").resize_right() end, desc = "Resize split right" },

      -- Window swapping
      { "<leader><leader>h", function() require("smart-splits").swap_buf_left() end, desc = "Swap buffer left" },
      { "<leader><leader>j", function() require("smart-splits").swap_buf_down() end, desc = "Swap buffer down" },
      { "<leader><leader>k", function() require("smart-splits").swap_buf_up() end, desc = "Swap buffer up" },
      { "<leader><leader>l", function() require("smart-splits").swap_buf_right() end, desc = "Swap buffer right" },
    },
  },
}
