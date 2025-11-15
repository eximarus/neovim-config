vim.lsp.config('lua_ls', {
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
})

vim.lsp.config('eslint', {
    on_attach = function(client, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            command = "EslintFixAll",
        })
    end,
})

vim.lsp.config('slangd',{
    settings = {
        slang = {
            format = {
                clangFormatStyle = '{IndentWidth: 4}'
            }
        }
    }
})

vim.lsp.config('gopls',{
    settings = {
        analyses = {
            unusedparams = true
        },
        staticcheck = true,
        gofumpt = true,
    }
})

vim.lsp.enable({
    'lua_ls',
    'pyright',
    'ts_ls',
    'html', 
    'cssls', 
    'jsonls', 
    'eslint', 
    'htmx',
    'tailwindcss',
    'zls',
    'clangd',
    'cmake',
    'glsl_analyzer',
    'slangd',
    'gopls'
});

vim.diagnostic.config({
    virtual_text = true,
    virtual_lines = true
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end,
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
