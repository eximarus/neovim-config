require 'nvim-treesitter.configs'.setup {
    ensure_installed = {
        "lua",
        "c",
        "cpp",
        "cmake",
        "python",
        "html",
        "css",
        "javascript",
        "typescript",
        "go",
        "gomod",
        "gosum",
        "sql",
        "hlsl",
        "glsl",
        "zig",
    },

    sync_install = false,
    auto_install = true,

    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}
