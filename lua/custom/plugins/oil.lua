local M = {
  "stevearc/oil.nvim",
  opts = {},
  lazy = false
}

function M.config()
  vim.keymap.set('n', '<leader>eo', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
  require('oil').setup()
end

return M
