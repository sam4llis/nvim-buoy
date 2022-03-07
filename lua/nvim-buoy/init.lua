-- TODO: toggle doesnt work after quitting an open instance.
if vim.fn.has('nvim-0.6.0') ~= 1 then
  vim.api.nvim_err_writeln("The plugin 'nvim-buoy' requires Neovim 0.6.0.")
  vim.api.nvim_err_writeln("Please update your Neovim.")
  return
end

local M = {}
M.__index = M

--
-- @desc
--   Creates a new floating window instance.
-- @param opts: table
--   Window configuration options.
--   keys: percentage, winblend
-- @return table:
--   Metadata for the new window instance.
--   keys: buf, win, opts
--
M.new = function (self, opts)
  local self = setmetatable({}, M)

  self.buf  = nil
  self.win  = nil
  self.opts = require('nvim-buoy.utils').get_window_opts(opts)

  return self
end

--
-- @desc
--   Opens a new floating window buffer if the buffer doesn't exist. Otherwise,
--   the function opens a previously created floating window instance if it is
--   not visible.
--
M.open = function (self)
  local buf
  if self.buf and vim.api.nvim_buf_is_loaded(self.buf) then
    buf = self.buf
  else
    buf = vim.api.nvim_create_buf(false, true)
  end

  -- Create the floating window with specified buffer and options.
  self.win = vim.api.nvim_open_win(buf, true, self.opts)
  self.buf = buf
end

--
-- @desc
--   Closes a floating window instance.
-- @param force: bool
--   Will delete the floating window buffer if set to true, otherwise, it will
--   close/hide the buffer.
--
M.close = function (self, force)
  if not self.win then
    return
  end

  if vim.api.nvim_win_is_valid(self.win) then
    vim.api.nvim_win_close(self.win, false)
    self.win = nil
  end

  if force then
    if vim.api.nvim_buf_is_loaded(self.buf) then
      vim.api.nvim_buf_delete(self.buf, { force = true })
    end

    self.buf = nil
    self.win = nil
  end
end

--
-- @desc
--   Toggles a floating window buffer between visible and hidden.
-- @param force: bool
--   Will delete the floating window buffer if set to true, otherwise, it will
--   close/hide the buffer.
--
M.toggle = function (self, force)
  local force = force or nil

  if not self.win then
    self:open()
  else
    self:close(force)
  end
end

return M
