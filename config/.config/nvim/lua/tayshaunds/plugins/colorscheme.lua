return {
  {
    "sainnhe/everforest",
    priority = 1000, -- load before other plugins
    lazy = false, -- Must load immediately for colorscheme
    init = function()
      -- Set options before plugin loads for faster startup
      vim.g.everforest_background = "hard"
      vim.g.everforest_transparent_background = 1
    end,
    config = function()
      -- apply colorscheme
      vim.cmd("colorscheme everforest")

      -- Defer transparency highlights to avoid startup delay
      vim.defer_fn(function()
        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
        vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
        vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
        vim.api.nvim_set_hl(0, "FoldColumn", { bg = "none" })
        vim.api.nvim_set_hl(0, "VertSplit", { bg = "none" })
      end, 0)
    end,
  },
}
