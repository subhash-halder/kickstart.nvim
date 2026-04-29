-- Copy relative file path
function CopyRelativePath()
  local path = vim.fn.expand '%'
  vim.fn.setreg('+', path) -- copy to system clipboard
  print('Copied relative path: ' .. path)
end

-- Copy absolute file path
function CopyAbsolutePath()
  local path = vim.fn.expand '%:p'
  vim.fn.setreg('+', path)
  print('Copied absolute path: ' .. path)
end
