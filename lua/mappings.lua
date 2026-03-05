local map = vim.keymap.set

-- Clear search highlight
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Telescope
local builtin = require("telescope.builtin")
map("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
map("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
map("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
map("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
map("n", "<leader>fo", builtin.oldfiles, { desc = "Recent files" })
map("n", "<leader>rf", builtin.lsp_references, { desc = "Open Telescope to list references" })
map("n", "<leader>fs", "<CMD>AutoSession search<CR>", { desc = "Pick session" })

-- LSP
local lsp = vim.lsp.buf
map('n', '<leader>jd', lsp.definition, {})
map('n', '<leader>sd', lsp.hover, {})
map('n', '<leader>fc', lsp.code_action, {})
map('n', '<leader>rn', lsp.rename, {})
map('n', '<leader>se', vim.diagnostic.open_float, {})

-- floating terminals
local term = require("terminal")
map('n', '<C-a><C-t>', term.tmux_popup)
vim.api.nvim_create_user_command("LG", function(_) term.lazygit() end, {})

-- Oil
map("n", "-", "<cmd>Oil<CR>", { desc = "Open file explorer" })

-- Easy align
map("x", "ga", "<Plug>(EasyAlign)")
map("n", "ga", "<Plug>(EasyAlign)")

-- Harpoon
local harpoon = require("harpoon")
harpoon:setup()

map("n", "<leader>hr", function() harpoon:list():add() end)
map("n", "<leader>he", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

map("n", "<leader>1", function() harpoon:list():select(1) end)
map("n", "<leader>2", function() harpoon:list():select(2) end)
map("n", "<leader>3", function() harpoon:list():select(3) end)
map("n", "<leader>3", function() harpoon:list():select(3) end)
