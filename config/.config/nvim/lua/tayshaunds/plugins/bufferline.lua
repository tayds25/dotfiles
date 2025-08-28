return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  version = "*",
  event = { "BufReadPost", "BufNewFile", "BufWritePre" }, -- Load when actually editing files
  opts = {
    options = {
      mode = "tabs",
      -- Hide on dashboard
      always_show_bufferline = false,
      offsets = {
        {
          filetype = "snacks_dashboard",
          text = "",
          highlight = "Directory",
          text_align = "center"
        }
      }
    },
  },
}
