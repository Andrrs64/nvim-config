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

vim.api.nvim_create_user_command("LG", "te lazygit", {})

local autocmd = vim.api.nvim_create_autocmd

autocmd("TermOpen", {
  pattern = "*",
  callback = function()
    vim.cmd("startinsert")
  end
})
