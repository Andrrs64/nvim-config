local cwd = vim.fn.getcwd()

local loadedBuildCommandTable = vim.empty_dict()
local tableLocation = "/.nvimbc"

local logging = false

local function loadBuildCommands()
  local path = cwd .. tableLocation
  local file = io.open(path, "r")

  if file then
    local contents = file:read("*a")
    loadedBuildCommandTable = vim.json.decode(contents)
    io.close(file)

    if logging == true then
      for _, k in pairs(loadedBuildCommandTable) do
        print("Loaded command: " .. k[1])
      end
    end
    return
  end
  if logging == true then
    print("Could not find file: " .. path)
  end
end

local function runBuildCommand(command)
  if command == nil then return end

  vim.cmd("split")
  vim.cmd("te {" .. command .. "}")
end

vim.api.nvim_create_user_command('Bc', function()
  for i, k in pairs(loadedBuildCommandTable) do
    print(i .. ": " .. k[1])
  end

  local index = tonumber(vim.fn.input("Choose option: "))
  if index == nil then return end
  local command = loadedBuildCommandTable[index][2]

  runBuildCommand(command)
end, {})

vim.api.nvim_create_user_command('BcLoad', function()
  loadBuildCommands()
end, {})

local function setup(opts)
  if opts.tableLocation ~= nil then
    tableLocation = opts.tableLocation
  end

  if opts.logging ~= nil then
    logging = opts.logging
  end

  loadBuildCommands()
end

return {
  setup = setup,
  loadBuildCommands = loadBuildCommands,
  runBuildCommand = runBuildCommand
}
