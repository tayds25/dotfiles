return {
    "folke/twilight.nvim",
    cmd = { "Twilight", "TwilightEnable", "TwilightDisable" },
    keys = {
        { "<leader>tw", "<cmd>Twilight<cr>", desc = "Toggle twilight (focus mode)" },
    },
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
    }
}