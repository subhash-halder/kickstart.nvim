local function excapeSearchText(searchText)
  return string.gsub(searchText, '([/%]])', '\\%1')
end

local function searchVisualSelection()
  local mode = vim.fn.mode()

  if mode == 'v' or mode == 'V' then
    vim.cmd 'normal "sy'
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'n', true)
    local selectionText = excapeSearchText(vim.fn.getreg 's')
    vim.api.nvim_feedkeys(':%s/' .. selectionText, 'n', true)
  end
end

local function git_diff_current_line()
  local current_file = vim.fn.expand '%:p'
  local current_line = vim.api.nvim_win_get_cursor(0)[1]
  local git_diff_cmd = "git log -L '" .. '/' .. vim.fn.getline('.'):gsub("[()/.%+-*?[^$]'" .. '"', '\\%1') .. '/,+1:' .. current_file .. "'"
  print(git_diff_cmd)

  local git_diff_output = vim.fn.systemlist(git_diff_cmd)

  local bufnr = vim.api.nvim_create_buf(false, true)
  local win_id = vim.api.nvim_open_win(bufnr, true, { relative = 'cursor', width = 80, height = 50, col = 0, row = 0, style = 'minimal', border = 'single' })

  vim.api.nvim_buf_set_lines(bufnr, 0, -1, true, git_diff_output)
  vim.api.nvim_buf_set_option(bufnr, 'filetype', 'diff')
end

return { escapeSearchText = excapeSearchText, searchVisualSelection = searchVisualSelection, git_diff_current_line = git_diff_current_line }
