vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

opt.number = true
opt.relativenumber = true

opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.smartindent = true

opt.cursorline = true
opt.signcolumn = "yes"

opt.ignorecase = true
opt.smartcase = true

opt.splitbelow = true
opt.splitright = true

opt.undofile = true

opt.termguicolors = true

opt.mouse = "a"

opt.clipboard = "unnamedplus"

opt.updatetime = 250
opt.colorcolumn = '100'

vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- neovide
if vim.g.neovide then
    vim.g.neovide_scroll_animation_length = 0.1
    vim.g.neovide_cursor_animation_length = 0.05
    vim.g.neovide_opacity                 = 0.9
    vim.g.neovide_normal_opacity          = 0.9
    vim.g.neovide_window_blurred          = true
end
