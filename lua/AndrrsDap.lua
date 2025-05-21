local buildOptionsLoaded = false
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

local _start_debugger = function()
    if buildOptionsLoaded == false then
        buildOptionsLoaded = _read_opt_file()
        if buildOptionsLoaded == false then
            return
        end
    end

      vim.cmd("split | te cd " .. opts.buildFolder .. " && " .. opts.buildCommand)
      if string.sub(opts.buildFolder, 1, 1) == '/' then
          return opts.buildFolder .. "/" .. opts.applicationName
      else
          return vim.fn.getcwd() .. '/' .. opts.buildFolder .. '/' .. opts.applicationName
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
            program = _start_debugger,
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

    vim.keymap.set("n", "<leader>bp", dap.toggle_breakpoint)
    vim.keymap.set('n', '<leader>rd', dap.continue)
    vim.keymap.set('n', '<leader>so', dap.step_over)
    vim.keymap.set('n', '<leader>si', dap.step_into)
end

return { setup = setup }
