
local _float_term = function(cmd)
    local buf = vim.api.nvim_create_buf(false, true)

    local width  = math.floor(vim.o.columns * 0.8)
    local height = math.floor(vim.o.lines   * 0.8)

    local win = vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        width    = width,
        height   = height,
        col      = math.floor((vim.o.columns - width)  / 2),
        row      = math.floor((vim.o.lines   - height) / 2),
        anchor   = "NW",
        style    = "minimal",
        border   = "rounded",
    })

    vim.api.nvim_set_option_value(
        "winhighlight", "Normal:Normal,NormalFloat:Normal,FloatBorder:Normal", { win = win }
    )

    vim.fn.jobstart(cmd, {
        term = true,
        on_exit = function()
            if vim.api.nvim_win_is_valid(win) then
                vim.api.nvim_win_close(win, true)
            end
            if vim.api.nvim_buf_is_valid(buf) then
                vim.api.nvim_buf_delete(buf, { force = true })
            end
        end,
    })

    vim.cmd("startinsert")
end

local _tmux_popup = function()
    _float_term("tmux new-session -As popup")
end

return {
    float_term = _float_term,
    tmux_popup = _tmux_popup,
}
