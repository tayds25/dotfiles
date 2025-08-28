return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = { "BufReadPost", "BufNewFile", "BufWritePre" }, -- Load when actually editing files
  config = function()
    local lazy_status = require("lazy.status")

    -- formatter for filename
    local function short_path(name)
      local parent = vim.fn.fnamemodify(name, ":h:t") -- parent folder
      local fname = vim.fn.fnamemodify(name, ":t")    -- file name
      if parent ~= "" then
        return parent .. "/" .. fname
      else
        return fname
      end
    end

    require("lualine").setup({
      options = {
        theme = "everforest",
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
        disabled_filetypes = {
          statusline = { "NvimTree", "SnacksPicker", "snacks_dashboard" },
        },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = {
          {
            "filename",
            path = 1, -- relative path (but we override display below)
            fmt = short_path,
          },
        },
        lualine_x = {
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            color = { fg = "#ff9e64" },
          },
          "encoding",
          "fileformat",
          "filetype",
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    })
  end,
}
