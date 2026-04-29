-- Get commit hash for current line
local function get_current_line_commit()
  local line = vim.fn.line(".")
  local file = vim.fn.expand("%")

  local cmd = string.format("git blame -L %d,%d --porcelain %s", line, line, file)
  local handle = io.popen(cmd)
  if not handle then return nil end

  local result = handle:read("*a")
  handle:close()

  local commit = result:match("^([0-9a-f]+)")
  return commit
end

-- Get GitHub repo URL
local function get_github_repo()
  local handle = io.popen("git remote get-url origin")
  if not handle then return nil end

  local url = handle:read("*a"):gsub("%s+", "")
  handle:close()

  -- Convert SSH → HTTPS if needed
  url = url:gsub("git@github.com:", "https://github.com/")
  url = url:gsub("%.git$", "")

  return url
end

-- Open PR search for commit
function OpenPRForCurrentLine()
  local commit = get_current_line_commit()
  if not commit then
    print("No commit found")
    return
  end

  local repo = get_github_repo()
  if not repo then
    print("Not a git repo")
    return
  end

  local pr_url = repo .. "/pulls?q=" .. commit

  -- Open in browser (cross-platform-ish)
  local open_cmd
  if vim.fn.has("mac") == 1 then
    open_cmd = "open"
  elseif vim.fn.has("unix") == 1 then
    open_cmd = "xdg-open"
  else
    open_cmd = "start"
  end

  os.execute(string.format("%s '%s' &", open_cmd, pr_url))
  print("Opening PRs for commit: " .. commit)
end

-- Open commit in browser
function OpenCommitForCurrentLine()
  local commit = get_current_line_commit()
  if not commit then
    print("No commit found")
    return
  end

  local repo = get_github_repo()
  if not repo then
    print("Not a git repo")
    return
  end

  local commit_url = repo .. "/commit/" .. commit

  -- Open in browser
  local open_cmd
  if vim.fn.has("mac") == 1 then
    open_cmd = "open"
  elseif vim.fn.has("unix") == 1 then
    open_cmd = "xdg-open"
  else
    open_cmd = "start"
  end

  os.execute(string.format("%s '%s' &", open_cmd, commit_url))
  print("Opening commit: " .. commit)
end

vim.keymap.set("n", "gC", OpenCommitForCurrentLine, { desc = "Open commit for current line" })
vim.keymap.set("n", "gP", OpenPRForCurrentLine, { desc = "Open PR for current line commit" })
