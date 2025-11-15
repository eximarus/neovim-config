local capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.lsp.config('pyright', {
    capabilities = capabilities,
})
vim.lsp.config('tsserver', {
    capabilities = capabilities,
})
vim.lsp.config('zls',{
    capabilities = capabilities,
})
vim.lsp.config('gopls',{
    capabilities = capabilities,
    settings = {
        analyses = {
            unusedparams = true
        },
        staticcheck = true,
        gofumpt = true,
    }
})
vim.lsp.config('htmx',{
    capabilities = capabilities,
})
vim.lsp.config('tailwindcss',{
    capabilities = capabilities,
})
vim.lsp.config('clangd',{
    capabilities = capabilities,
})
vim.lsp.config('cmake',{
    capabilities = capabilities,
})
vim.lsp.config('html',{
    capabilities = capabilities,
})
vim.lsp.config('cssls',{
    capabilities = capabilities,
})
vim.lsp.config('jsonls',{
    capabilities = capabilities,
})

vim.lsp.config('lua_ls',{
    capabilities = capabilities,
    on_init = function(client)
        local path = client.workspace_folders[1].name
        if not vim.loop.fs_stat(path .. '/.luarc.json') and not vim.loop.fs_stat(path .. '/.luarc.jsonc') then
            client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
                Lua = {
                    runtime = {
                        version = 'LuaJIT'
                    },
                    workspace = {
                        checkThirdParty = false,
                        library = {
                            vim.env.VIMRUNTIME
                        }
                    }
                }
            })

            client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
        end
        return true
    end
})

local cmp = require('cmp')
cmp.setup({
    sources = {
        { name = 'nvim_lsp' },
    },
    mapping = cmp.mapping.preset.insert({
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
        ['<C-Space>'] = cmp.mapping.complete(),
    }),
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
})
