local M = {}

M.merge_tables = function(t1, t2)
    if type(t1) ~= "table" or type(t2) ~= "table" then
        return
    end
    for k, v in pairs(t2) do
        t1[k] = v
    end
end

M.get_buffer_parent_dir = function()
    local buf_path = vim.api.nvim_buf_get_name(0)
    return vim.fs.dirname(buf_path)
end

M.get_visual_selection = function()
    local mode = vim.fn.mode()
    if mode ~= "v" and mode ~= "V" and mode ~= "\22" then
        return ""
    end

    local start_pos = vim.fn.getpos("v")
    local end_pos   = vim.api.nvim_win_get_cursor(0)

    local start_line, start_col = start_pos[2]-1, start_pos[3]-1
    local end_line, end_col     = end_pos[1]-1,   end_pos[2]+1

    -- swap if backwards selection
    if start_line > end_line or (start_line == end_line and start_col > end_col) then
        start_line, end_line = end_line, start_line
        start_col, end_col = end_col, start_col
    end

    local lines = vim.api.nvim_buf_get_text(0, start_line, start_col, end_line,
                                            end_col, {})
    return table.concat(lines, "\n")
end

M.go_to_selection = function()
    local selection = M.get_visual_selection()
    local first_char = string.sub(selection, 1, 1)
    if first_char == '/' or first_char == '~' then
        vim.cmd.edit(selection)
        return
    end

    local parent = M.get_buffer_parent_dir()
    vim.cmd.edit(parent.."/"..selection)
end

return M
