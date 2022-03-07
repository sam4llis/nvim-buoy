local M = {}
M.default_opts = { percentage = 0.7, winblend=15 }

--
-- Function that gets the default options for a floating window. Default
-- options are overwritten if the user supplies this function with their own
-- options.
-- @param opts table | nil: user window configuration options.
--   keys: percentage, winblend. TODO
-- @return table: window options overwritten with user window options.
--   keys: percentage, winblend. TODO
--
M.get_opts = function (opts)
  local opts = opts or {}

  for k, v in pairs(M.default_opts) do
    if opts[k] == nil then
      opts[k] = v
    end
  end

  return opts
end

--
-- Function that calculates sane dimensions for floating windows, given any
-- options from M.default_opts()
-- @param opts table | nil: user window configuration options.
--   keys: percentage, winblend. TODO
-- @return table: sane dimensions and options for floating windows, accounting
-- for user specifications.
--   keys: relative, row, col, width, height, style, border.
--
M.get_window_opts = function (opts)
  local opts = M.get_opts(opts, M.default_opts)

  local width = math.floor(vim.o.columns * opts.percentage)
  local height = math.floor(vim.o.lines * opts.percentage)

  local top = math.floor(((vim.o.lines - height) / 2) - 1)
  local left = math.floor((vim.o.columns - width) / 2)

  local window_opts = {
    relative = 'editor',
    row = top,
    col = left,
    width = width,
    height = height,
    style = 'minimal',
    border = {
      { ' ', 'NormalFloat' },
      { ' ', 'NormalFloat' },
      { ' ', 'NormalFloat' },
      { ' ', 'NormalFloat' },
      { ' ', 'NormalFloat' },
      { ' ', 'NormalFloat' },
      { ' ', 'NormalFloat' },
      { ' ', 'NormalFloat' },
    },
  }

  return window_opts
end

return M
