vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.o.autoindent = true
vim.o.smartindent = true

vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.smarttab = true
vim.o.expandtab = true

vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true

-- Allow cursor to cross line boundaries with arrow keys in insert mode
vim.opt.whichwrap:append("<,>,[,]")

local function open_file_explorer()
  local file = vim.fn.expand("%:t")

  vim.cmd.Explore()

  vim.schedule(function()
    vim.cmd("normal! gg")
    vim.fn.search("^" .. vim.fn.escape(file, "\\") .. "$", "W")
  end)
end
vim.keymap.set('n', '<leader>fe', open_file_explorer)

require("config.lazy")
