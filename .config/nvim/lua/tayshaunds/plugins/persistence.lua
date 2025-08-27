return {
  "folke/persistence.nvim",
  event = "BufReadPre",
  keys = {
    { "<leader>wr", function() require("persistence").load() end, desc = "Restore session for cwd" },
    { "<leader>ws", function() require("persistence").save() end, desc = "Save session for cwd" },
    { "<leader>wl", function() require("persistence").load({ last = true }) end, desc = "Restore last session" },
    { "<leader>wd", function() require("persistence").stop() end, desc = "Stop persistence for this session" },
  },
  config = function()
    local persistence = require("persistence")
    persistence.setup({
      dir = vim.fn.stdpath("state") .. "/sessions/",
      options = { "buffers", "curdir", "tabpages", "winsize" },
    })
  end,
}

