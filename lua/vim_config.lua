require('functions')

vim.g.mapleader = ' '
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.mouse = ""
vim.o.showmode = false
vim.wo.cursorline = true

vim.cmd("set relativenumber")
vim.cmd('set laststatus=3')
vim.cmd('highlight CursorLine guibg=#495177')

vim.api.nvim_set_hl(0, 'LineNrAbove', {fg='#7fcbd7', bold = true})
vim.api.nvim_set_hl(0, 'LineNr', {fg='#857ebb', bold = true})
vim.api.nvim_set_hl(0, 'LineNrBelow', {fg='#ca9dd7', bold = true})

vim.api.nvim_create_autocmd('BufEnter', {command = 'lua require("lazygit.utils").project_root_dir()'})
vim.api.nvim_create_autocmd('BufEnter', {command = 'lua Change_add_comments()'})

vim.cmd('highlight Number guifg=#68E068')
vim.cmd('highlight Boolean guifg=#46CE46')
vim.cmd('highlight Float guifg=#BDF8BD')
vim.cmd('highlight Constant guifg=#68E068')
vim.cmd('highlight String guifg=#90ee90')

vim.cmd('highlight Type guifg=#48d1cc')

vim.cmd('sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=')
vim.cmd('sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=')
vim.cmd('sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=')
vim.cmd('sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=')

vim.cmd('set foldmethod=manual')
