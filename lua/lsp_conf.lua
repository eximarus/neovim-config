local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require('lspconfig')

lspconfig.pyright.setup {
    capabilities = capabilities,
}
lspconfig.tsserver.setup {
    capabilities = capabilities,
}
lspconfig.zls.setup {
    capabilities = capabilities,
}
lspconfig.gopls.setup {
    capabilities = capabilities,
    settings = {
        analyses = {
            unusedparams = true
        },
        staticcheck = true,
        gofumpt = true,
    }
}
lspconfig.htmx.setup {
    capabilities = capabilities,
}
lspconfig.tailwindcss.setup {
    capabilities = capabilities,
}
lspconfig.clangd.setup {
    capabilities = capabilities,
}
lspconfig.cmake.setup {
    capabilities = capabilities,
}
lspconfig.html.setup {
    capabilities = capabilities,
}
lspconfig.cssls.setup {
    capabilities = capabilities,
}
lspconfig.jsonls.setup {
    capabilities = capabilities,
}

lspconfig.lua_ls.setup {
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
}

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
