local opts = {
    buildCommand = nil,
    buildFolder = nil,
    applicationName = nil
}

local _read_opt_file = function()
    local path = vim.fn.getcwd() .. "/.adaprc"
    local file = io.open(path)

    if file then
        local contents = file:read("*a")
        opts = vim.json.decode(contents)
        io.close(file)

        return true
    else
        return false
    end
end

local _get_executable_path = function()
    _read_opt_file()
    if string.sub(opts.buildFolder, 1, 1) == '/' then
        return opts.buildFolder .. "/" .. opts.applicationName
    else
        return vim.fn.getcwd() .. '/' .. opts.buildFolder .. '/' .. opts.applicationName
    end
end

local start_debugger = function()
    print("Starting debugger...")
    _read_opt_file()

    if opts.buildCommand ~= 0 then
        local cmd = {}

        for str in string.gmatch(opts.buildCommand, '%S+') do
            table.insert(cmd, str)
        end
        local buildRes = vim.system(cmd):wait()

        if buildRes.code == 0 then
            require("dap").continue()
        else
            local stderr_lines = {}
            for line in buildRes.stderr:gmatch("[^\n]+") do
                table.insert(stderr_lines, line)
            end

            vim.cmd('new')
            vim.bo.buftype = 'nofile'
            vim.bo.bufhidden = 'wipe'
            vim.bo.swapfile = false
            vim.bo.modifiable = true

            vim.api.nvim_buf_set_lines(0, 0, -1, false, stderr_lines)
            vim.api.nvim_buf_set_name(0, "Build error")
            return
        end
    end
end


local setup = function()
    local dap = require "dap"
    local ui = require "dapui"

    dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
            command = "codelldb",
            args = { "--port", "${port}" },
        },
    }

    dap.configurations.c = {
        {
            name = "Launch",
            type = "codelldb",
            request = "launch",
            program = _get_executable_path,
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
        }
    }

    dap.configurations.zig = {
        {
            name = "Launch",
            type = "codelldb",
            request = "launch",
            program = _get_executable_path,
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
        }
    }

    dap.configurations.odin = {
        {
            name = "Launch",
            type = "codelldb",
            request = "launch",
            program = _get_executable_path,
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
        }
    }

    ui.setup()
    vim.api.nvim_create_user_command('DAPUIOpen', function ()
      ui.open()
    end, {})
    vim.api.nvim_create_user_command('DAPUIClose', function ()
      ui.close()
    end, {})

    vim.keymap.set('n', '<leader>dr', start_debugger)

    vim.keymap.set("n", "<leader>bp", dap.toggle_breakpoint)
    vim.keymap.set('n', '<leader>dc', dap.continue)
    vim.keymap.set('n', '<leader>so', dap.step_over)
    vim.keymap.set('n', '<leader>si', dap.step_into)
end

return { setup = setup, start_debugger = start_debugger }
