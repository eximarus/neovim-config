local lspconfig = require('lspconfig')

lspconfig.lua_ls.setup {
    on_init = function(client)
        if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc') then
                return
            end
        end

        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
                version = 'LuaJIT'
            },
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.env.VIMRUNTIME
                }
            }
        })
    end,
    settings = {
        Lua = {}
    }
}

lspconfig.pyright.setup {}

lspconfig.ts_ls.setup {}
lspconfig.html.setup {
    --filetypes = { "html" }
}
lspconfig.cssls.setup {}
lspconfig.jsonls.setup {}
lspconfig.eslint.setup({
    on_attach = function(client, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            command = "EslintFixAll",
        })
    end,
})

lspconfig.htmx.setup {}
lspconfig.tailwindcss.setup {}

lspconfig.zls.setup {}
lspconfig.clangd.setup {}
lspconfig.cmake.setup {}
lspconfig.glsl_analyzer.setup {}
lspconfig.wgsl_analyzer.setup {}
lspconfig.slangd.setup {
    settings = {
        slang = {
            format = {
                clangFormatStyle = '{IndentWidth: 4}'
            }
        }
    }
}

lspconfig.gopls.setup {
    settings = {
        analyses = {
            unusedparams = true
        },
        staticcheck = true,
        gofumpt = true,
    }
}
lspconfig.templ.setup {}


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

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = "*.glsl",
    callback = function()
        vim.bo.filetype = "glsl"
    end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = "*.vert",
    callback = function()
        vim.bo.filetype = "vert"
    end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = "*.tesc",
    callback = function()
        vim.bo.filetype = "tesc"
    end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = "*.tese",
    callback = function()
        vim.bo.filetype = "tese"
    end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = "*.frag",
    callback = function()
        vim.bo.filetype = "frag"
    end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = "*.geom",
    callback = function()
        vim.bo.filetype = "geom"
    end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = "*.comp",
    callback = function()
        vim.bo.filetype = "comp"
    end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = "*.wgsl",
    callback = function()
        vim.bo.filetype = "wgsl"
    end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = { "*.zon", "*.zig" },
    callback = function()
        vim.bo.filetype = "zig"
    end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = "*.slang",
    callback = function()
        vim.bo.filetype = "shaderslang"
    end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = "*.hlsl",
    callback = function()
        vim.bo.filetype = "hlsl"
    end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = "*.templ",
    callback = function()
        vim.bo.filetype = "templ"
    end,
})
