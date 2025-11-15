local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = {
        { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
        {
            "nvim-treesitter/nvim-treesitter",
            build = ":TSUpdate",
            config = function()
                require("nvim-treesitter.configs").setup({
                    highlight = {
                        enable = true,
                        additional_vim_regex_highlighting = false,
                    },
                })
            end,
        },
        {
            'neovim/nvim-lspconfig'
        },
        "cloudhead/neovim-fuzzy",
        "ziglang/zig.vim",
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
        },
        {
            "christoomey/vim-tmux-navigator",
            cmd = {
                "TmuxNavigateLeft",
                "TmuxNavigateDown",
                "TmuxNavigateUp",
                "TmuxNavigateRight",
                "TmuxNavigatePrevious",
            },
            keys = {
                { "<c-h>",  "<cmd><C-U>TmuxNavigateLeft<cr>" },
                { "<c-j>",  "<cmd><C-U>TmuxNavigateDown<cr>" },
                { "<c-k>",  "<cmd><C-U>TmuxNavigateUp<cr>" },
                { "<c-l>",  "<cmd><C-U>TmuxNavigateRight<cr>" },
                { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
            },
        }
    },
    checker = { enabled = true },
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
