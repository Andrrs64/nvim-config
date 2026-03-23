local map = vim.keymap.set

-- Clear search highlight
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Paste from os clipboard in insert mode
map("i", "<C-v>", '<ESC>"+pa')

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
vim.api.nvim_create_user_command("T",   function(_) term.tmux_popup()          end, {})
vim.api.nvim_create_user_command("ST",  function(_) term.float_term("$SHELL")  end, {})
vim.api.nvim_create_user_command("LG",  function(_) term.float_term("lazygit") end, {})
vim.api.nvim_create_user_command("Top", function(_) term.float_term("btop")    end, {})

-- Notes
local notes = require("dirnotes")
vim.api.nvim_create_user_command("Notes", function(_) notes.open_dir(true) end, {})

-- Oil
map("n", "-", "<cmd>Oil<CR>", { desc = "Open file explorer" })

-- Easy align
map("x", "ga", "<Plug>(EasyAlign)")
map("n", "ga", "<Plug>(EasyAlign)")

-- LuaSnip
local ls = require('luasnip')
map({"i", "s"}, "<C-Tab>",   function() ls.jump(1)  end)
map({"i", "s"}, "<S-Tab>", function() ls.jump(-1) end)

-- Harpoon
local harpoon = require("harpoon")
harpoon:setup()

map("n", "<leader>hr", function() harpoon:list():add() end)
map("n", "<leader>he", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

map("n", "<leader>1", function() harpoon:list():select(1) end)
map("n", "<leader>2", function() harpoon:list():select(2) end)
map("n", "<leader>3", function() harpoon:list():select(3) end)
map("n", "<leader>3", function() harpoon:list():select(3) end)

map("n", "<C-z>", "<nop>")
