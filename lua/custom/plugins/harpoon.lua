local M = {
  'theprimeagen/harpoon',
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
}

function M.config()
  local harpoon_mark = require 'harpoon.mark'
  local harpoon_ui = require 'harpoon.ui'

  vim.keymap.set('n', '<leader>ha', harpoon_mark.add_file, { desc = '[H]arpoon [A]dd' })
  vim.keymap.set('n', '<leader>hh', harpoon_ui.toggle_quick_menu, { desc = '[H]arpoon [H]ide' })

  vim.keymap.set('n', '<leader><leader>', function()
    harpoon_ui.nav_next()
  end, { desc = '[H]arpoon [N]ext' })
  vim.keymap.set('n', '<leader>h1', function()
    harpoon_ui.nav_file(1)
  end, { desc = '[H]arpoon [1]' })
  vim.keymap.set('n', '<leader>h2', function()
    harpoon_ui.nav_file(2)
  end, { desc = '[H]arpoon [2]' })
  vim.keymap.set('n', '<leader>h3', function()
    harpoon_ui.nav_file(3)
  end, { desc = '[H]arpoon [3]' })
  vim.keymap.set('n', '<leader>h4', function()
    harpoon_ui.nav_file(4)
  end, { desc = '[H]arpoon [4]' })
end

return M
