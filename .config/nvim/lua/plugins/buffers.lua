---@class TidyBuffersUI
---@field win_id number
---@field bufnr number
---@field bufnr_original number
local TidyBuffersUI = {}

local function _get_buffers()
  local buffers = {}
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    local is_loaded = vim.api.nvim_buf_is_loaded(buf)
    local name = vim.api.nvim_buf_get_name(buf)
    -- TODO: Add relative path for better context
    if is_loaded and name ~= "" then
      table.insert(buffers, buf)
    end
  end
  return buffers
end

local function _populate_buffer_list(bufnr)
  local lines = {}
  local buffers = _get_buffers()
  for _, buf_id in ipairs(buffers) do
    local buf_name = vim.api.nvim_buf_get_name(buf_id)
    table.insert(lines, buf_id .. ": " .. vim.fn.fnamemodify(buf_name, ":t"))
  end
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
end

function TidyBuffersUI:open_popup()
  TidyBuffersUI.bufnr_original = vim.api.nvim_get_current_buf()

  local toggle_opts = {
    title = "Open Files",
    title_pos = "left",
    border = "single",
    ui_max_width = 50,
    ui_width_ratio = 0.62569,
  }

  local win = vim.api.nvim_list_uis()
  local height = 8
  local width = toggle_opts.ui_fallback_width

  if #win > 0 then
    -- no ackshual reason for 0.62569, just looks complicated, and i want
    -- to make my boss think i am smart
    width = math.floor(win[1].width * toggle_opts.ui_width_ratio)
  end

  if toggle_opts.ui_max_width and width > toggle_opts.ui_max_width then
    width = toggle_opts.ui_max_width
  end

  local bufnr = vim.api.nvim_create_buf(false, true)
  local popup_opts = {
    relative = "editor",
    title = toggle_opts.title or "Harpoon",
    title_pos = toggle_opts.title_pos or "left",
    row = math.floor(((vim.o.lines - height) / 2) - 1),
    col = math.floor((vim.o.columns - width) / 2),
    width = width,
    height = height,
    style = "minimal",
    border = toggle_opts.border or "single",
  }

  -- Set buffer content
  _populate_buffer_list(bufnr)

  -- Create popup window
  local win_id = vim.api.nvim_open_win(bufnr, true, popup_opts)
  if win_id == 0 then
    error("Failed to create window")
  end

  -- Set keymaps for buffer actions
  vim.keymap.set("n", "q", TidyBuffersUI.close_popup, { noremap = true, silent = true, buffer = bufnr })
  vim.keymap.set("n", "<C-c>", TidyBuffersUI.close_popup, { noremap = true, silent = true, buffer = bufnr })
  vim.keymap.set("n", "d", TidyBuffersUI.remove_buffer, { noremap = true, silent = true, buffer = bufnr })
  vim.keymap.set("n", "<CR>", TidyBuffersUI.goto_buffer, { noremap = true, silent = true, buffer = bufnr })

  -- Store the window and buffer IDs
  TidyBuffersUI.bufnr = bufnr
  TidyBuffersUI.win_id = win_id
end

-- Function to close the popup window
function TidyBuffersUI:close_popup()
  if TidyBuffersUI.win_id then
    vim.api.nvim_win_close(TidyBuffersUI.win_id, true)
    vim.api.nvim_buf_delete(TidyBuffersUI.bufnr, { force = true })
    TidyBuffersUI.win_id = nil
    TidyBuffersUI.bufnr = nil
  end
end

-- Function to remove the buffer from the list and close it
function TidyBuffersUI:remove_buffer()
  local cursor_pos = vim.api.nvim_win_get_cursor(TidyBuffersUI.win_id)
  local line = vim.api.nvim_buf_get_lines(TidyBuffersUI.bufnr, cursor_pos[1] - 1, cursor_pos[1], false)[1]
  local bufnr = tonumber(line:match("^%d+"))

  if bufnr == TidyBuffersUI.bufnr_original then
    print("Cannot delete current buffer")
    return
  end

  if bufnr then
    vim.api.nvim_buf_delete(bufnr, { force = true })

    -- Refresh the popup
    _populate_buffer_list(TidyBuffersUI.bufnr)
  end
end

function TidyBuffersUI:goto_buffer()
  local cursor_pos = vim.api.nvim_win_get_cursor(TidyBuffersUI.win_id)
  local line = vim.api.nvim_buf_get_lines(TidyBuffersUI.bufnr, cursor_pos[1] - 1, cursor_pos[1], false)[1]
  local bufnr = tonumber(line:match("^%d+"))

  if bufnr then
    TidyBuffersUI:close_popup()
    vim.api.nvim_set_current_buf(bufnr)
  end
end

-- vim.keymap.set("n", "<leader>bv", TidyBuffersUI.open_popup, { noremap = true, silent = true })

-- return BufferListUI
return {}
