return {
  "folke/todo-comments.nvim",
  event = { "BufRead", "BufNewFile" },
  opts = {},
  keys = {
    {
      "<leader>ft",
      function()
        require("snacks").picker.todo_comments()
      end,
      desc = "Find todo comments with Snacks picker"
    },
    {
      "]t",
      function()
        require("todo-comments").jump_next()
      end,
      desc = "Next todo comment"
    },
    {
      "[t",
      function()
        require("todo-comments").jump_prev()
      end,
      desc = "Previous todo comment"
    },
  },
}
