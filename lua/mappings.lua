--
-- ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
-- ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
-- ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
-- ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
-- ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
-- ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
--
-- File: mappings.lua
-- Description: Key mapping configs
-- Author: Kien Nguyen-Tuan <kiennt2609@gmail.com>

-- <leader> is a space now
local map = vim.keymap.set
local lsp = vim.lsp.buf

-- Move around splits
-- map("n", "<leader>wh", "<C-w>h", { desc = "switch window left" })
-- map("n", "<leader>wj", "<C-w>j", { desc = "switch window right" })
-- map("n", "<leader>wk", "<C-w>k", { desc = "switch window up" })
-- map("n", "<leader>wl", "<C-w>l", { desc = "switch window down" })

-- Reload configuration without restart nvim
map("n", "<leader>r", ":source $MYVIMRC<CR>", { desc = "Reload configuration without restart nvim" })

-- Telescope
local builtin = require("telescope.builtin")
map("n", "<leader>ff", builtin.find_files, { desc = "Open Telescope to find files" })
map("n", "<leader>fg", builtin.live_grep, { desc = "Open Telescope to do live grep" })
map("n", "<leader>fb", builtin.buffers, { desc = "Open Telescope to list buffers" })
map("n", "<leader>fh", builtin.help_tags, { desc = "Open Telescope to show help" })
map("n", "<leader>fo", builtin.oldfiles, { desc = "Open Telescope to list recent files" })
map("n", "<leader>cm", builtin.git_commits, { desc = "Open Telescope to list git commits" })
map("n", "<leader>rf", builtin.lsp_references, { desc = "Open Telescope to list references" })

-- NvimTree
map("n", "<leader>n", ":NvimTreeToggle<CR>", { desc = "Toggle NvimTree sidebar" })    -- open/close
map("n", "<leader>nr", ":NvimTreeRefresh<CR>", { desc = "Refresh NvimTree" })         -- refresh
map("n", "<leader>nf", ":NvimTreeFindFile<CR>", { desc = "Search file in NvimTree" }) -- search file

-- LSP
map("n", "<leader>pf", function()
  require("plf").format { lsp_fallback = true }
end, { desc = "General Format file" })

map('n', '<leader>jd', lsp.definition, {})
map('n', '<leader>sd', lsp.hover, {})
map('n', '<leader>fc', lsp.code_action, {})
map('n', '<leader>rn', lsp.rename, {})
map('n', '<leader>se', vim.diagnostic.open_float, {})

-- global lsp mappings
map("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "LSP Diagnostic loclist" })

-- Comment
map("n", "mm", "gcc", { desc = "Toggle comment", remap = true })
map("v", "mm", "gc", { desc = "Toggle comment", remap = true })

-- Windows
map("n", "<F6>", "<cmd>vertical resize +5<CR>", { desc = "Resize window -vertical" })
map("n", "<F9>", "<cmd>vertical resize -5<CR>", { desc = "Resize window +vertical" })
map("n", "<F7>", "<cmd>horizontal resize +5<CR>", { desc = "Resize window -horizontal" })
map("n", "<F8>", "<cmd>horizontal resize -5<CR>", { desc = "Resize window +horizontal" })

-- Move lines
map("v", "J", "dp`[=`]`[V`]")
map("v", "K", "dkP`[=`]`[V`]")

-- Indent lines
map("v", "<", "<`[V`]")
map("v", ">", ">`[V`]")

-- Move view
-- map("n", "<C-d>", "<C-d>zz")
-- map("n", "<C-u>", "<C-u>zz")

-- Clipboard
map("x", "<leader>p", [["_dP"]])
map({ "n", "v" }, "<leader>y", [["+y]])
map("n", "<leader>Y", [["+Y]])
map({ "n", "v" }, "<leader>d", "\"_d")

-- Harpoon
local harpoon = require("harpoon")
map("n", "<leader>hr", function() harpoon:list():add() end)
map("n", "<leader>he", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

map("n", "<leader>ha", function() harpoon:list():select(1) end)
map("n", "<leader>hs", function() harpoon:list():select(2) end)
map("n", "<leader>hd", function() harpoon:list():select(3) end)
map("n", "<leader>hf", function() harpoon:list():select(4) end)

map("n", "<leader>hn", function() harpoon:list():next() end)
map("n", "<leader>hp", function() harpoon:list():prev() end)

-- Oil
map("n", "-", "<CMD>Oil<CR>", { desc = "open parent directory with oil"})

-- Terminal
map("t", "<Esc>", "<C-\\><C-n>")
map("n", "<leader>tr", "<cmd>split term://zsh<CR>")
map("n", "<leader>tv", "<cmd>vsplit term://zsh<CR>")

-- dap
local dap = require('dap')
map('n', '<leader>bp', function() dap.toggle_breakpoint() end)
map('n', '<leader>rd', function() dap.continue() end)
map('n', '<leader>so', function() dap.step_over() end)
map('n', '<leader>si', function() dap.step_into() end)

-- copilot
map('i', '<F12>', 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false
})
vim.g.copilot_no_tab_map = true

-- gp.nvim
map('n', '<leader>gpt', '<cmd>GpChatToggle<CR>')
map('n', '<leader>gpr', '<cmd>GpChatRespond<CR>')
map('n', '<leader>gpn', '<cmd>GpChatNew<CR>')
map('n', '<leader>gpd', '<cmd>GpChatDelete<CR>')
map('v', '<leader>gpp', ':GpChatPaste<CR>')

-- terminal command
map('n', '<F5>', function()
  local command = vim.fn.input("Command: ")
  if command == nil or command == "" then return end
  vim.cmd("te {" .. command .. "}")
end, { desc = "Run terminal command" })
