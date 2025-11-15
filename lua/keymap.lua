vim.g.mapleader = " "
vim.keymap.set("n", "<leader>oe", vim.cmd.Ex)
vim.keymap.set("n", "<C-s>", vim.cmd.w)

vim.keymap.set("n", "<leader>bn", ":bnext<CR>")
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>")
vim.keymap.set("n", "<leader>bd", ":bd<CR>")

vim.keymap.set("n", "j", "jzz", { noremap = true, silent = true });
vim.keymap.set("n", "k", "kzz", { noremap = true, silent = true });
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true });
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true });

vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")

-- vim.keymap.set('n', "<a-j>", ":m .+1<cr>==")
vim.keymap.set('v', "<a-j>", ":m '>+1<cr>gv=gv")
-- vim.keymap.set('i', "<a-j>", "<esc>:m '<+1<cr>==gi")

-- vim.keymap.set('n', "<a-k>", ":m .-2<CR>==")
vim.keymap.set('v', "<a-k>", ":m '<-2<CR>gv=gv")
-- vim.keymap.set('i', "<a-k>", "<ESC>:m '<-2<CR>==gi")

vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

vim.keymap.set("n", "<leader>wd", "<C-w>c")
vim.keymap.set("n", "<leader>ws", "<C-w>s")
vim.keymap.set("n", "<leader>wv", "<C-w>v")

vim.keymap.set('n', '<leader>ff', ":FuzzyOpen<CR>")
vim.keymap.set('n', '<leader>st', ":FuzzyGrep<CR>")

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)

        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)

        vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<leader>ct', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<leader>cf', function()
            vim.lsp.buf.format { async = true }
        end, opts)
    end,
})
