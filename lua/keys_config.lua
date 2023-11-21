require('functions')

--INSERT MODE
vim.api.nvim_set_keymap('i', 'vv', '<Esc>v', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', 'nn', '<Esc>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', 'bb', '<Esc><C-v>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<C-s>', '<Esc>:w!<CR> i', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '(', '()', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '[', '[]', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '{', '{}', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '"', '""', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', "'", "''", {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<', '<>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<C-z>', '<Esc>ui', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<Left>', '<Esc>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<Up>', '<Esc>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<Down>', '<Esc>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<Right>', '<Esc>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<S-h>', '<Left>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<S-l>', '<Right>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<S-j>', '<Down>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<S-k>', '<Up>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', 'hh', 'H', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', 'jj', 'J', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', 'kk', 'K', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', 'll', 'L', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<C-l>', '<Delete>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<Tab>', '    ', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<S-Tab>', '<Esc><S-<><S-<>i', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<C-k>', '<Esc>o', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<C-j>', '<Esc><S-o>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', 'ee', '<CR>', {noremap = true, silent = true})

--VIEW MODE    
vim.api.nvim_set_keymap('v', 'ii', '<Esc>i', {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', 'nn', '<Esc>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', 'bb', '<Esc><C-v>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', 'r', 'di', {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '<', '<gv', {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '>', '>gv', {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '<C-s>', '<Esc>:w<CR>i', {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '<CR>', 'i', {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '<S-c>', 'c', {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '<C-k>', ':m -2<CR>==gv', {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '<C-j>', [[:'<,'>m '>+1<CR>==gv]], {noremap = true, silent = true})

--NORMAL MODE    
vim.api.nvim_set_keymap('n', 'term', ':lua Terminal()<CR>i', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'ii', '<Esc>i', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'vv', '<Esc>v', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'bb', '<Esc><C-v>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'r', '<C-r><CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'l', '<Right>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'ct', ':lcd %:p:h<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'cb', ':lct<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'ter', ':terminal<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'qt', ':qa!<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'qq', ':wqa!<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'nn', ':lua LocalTree()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'nb', ':lua ConfigTree()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'nm', ':lua MicroservicesTree()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Tab>', '<C-w>w', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Left>', '<Esc>:vertical resize -5<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Up>', '<Esc>:resize +5<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Down>', '<Esc>:resize -5<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Right>', '<Esc>:vertical resize +5<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-v>', '<Esc>:vsplit<CR>i', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-b>', '<Esc>:split<CR>i', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-k>', '<S-n>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-j>', 'n', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'mvnw', ':lua Mvnw()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'run', ':lua Run_dev()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'build', ':lua Build()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'push', ':lua Push()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-p>', ':UndotreeToggle<CR><Tab>', {noremap = true, silent = true})

--LEADER STUFF   
vim.api.nvim_set_keymap('n', '<leader>g', ':LazyGitCurrentFile<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>l', ':Lazy<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>k', ':Mason<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>j', ':lua Find_files_local()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>h', ':Telescope find_files hidden=true no_ignore=true<CR>', {noremap = true, silent = true})

--LSP STUFF
vim.api.nvim_set_keymap('n', 'imp', ':lua vim.lsp.buf.implementation()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'desc', ':lua vim.lsp.buf.hover()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'refs', ':lua vim.lsp.buf.references()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'err', ':lua vim.diagnostic.open_float()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'en', ':lua vim.diagnostic.goto_next({buffer=0})<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'ep', ':lua vim.diagnostic.goto_prev({buffer=0})<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'rnm', ':lua vim.lsp.buf.rename()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'act', ':lua vim.lsp.buf.code_action()<CR>', {noremap = true, silent = true})
