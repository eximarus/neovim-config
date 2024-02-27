local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    { "catppuccin/nvim",                 name = "catppuccin", priority = 1000 },
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            { 'hrsh7th/cmp-nvim-lsp' },
        }
    },
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            { 'L3MON4D3/LuaSnip' }
        },
    },
    "cloudhead/neovim-fuzzy",
    {
        'numToStr/Comment.nvim',
        opts = {
        },
        lazy = false,
    },
    "JoosepAlviste/nvim-ts-context-commentstring",
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    }
})

vim.g.skip_ts_context_commentstring_module = true
require('Comment').setup {
    pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
}

require('lualine').setup {
    options = {
        theme = "catppuccin"
    }
}
