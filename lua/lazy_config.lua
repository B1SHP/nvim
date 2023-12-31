local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
        "folke/tokyonight.nvim",
    },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.3',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'neovim/nvim-lspconfig',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-vsnip',
            'hrsh7th/vim-vsnip',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/nvim-cmp'
        },
    },
    {
        'williamboman/mason.nvim',
        dependencies = {
            'williamboman/mason-lspconfig',
       }
    },
    {
        'kyazdani42/nvim-tree.lua',
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },
    {
    	'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-refactor',
            'p00f/nvim-ts-rainbow'
        }
    },
    {
        'Yggdroot/indentLine'
    },
    {
        'mbbill/undotree'
    },
    {
        'microsoft/java-debug',
        dependencies = { 'mfussenegger/nvim-dap' }
    },
    {
        'kdheepak/lazygit.nvim'
    },
    {
        'ggandor/leap.nvim',
        config = function ()
            require('leap').add_default_mappings()
        end
    },
    {
        'nvim-treesitter/nvim-treesitter-context'
    },
    {
        'kylechui/nvim-surround',
        config = function ()
            require('nvim-surround').setup({})
        end
    },
    {
        'mfussenegger/nvim-jdtls',
    },
    {
        'nvim-telescope/telescope-live-grep-args.nvim',
    }
})
